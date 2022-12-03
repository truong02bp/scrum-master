import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:scrum_master_front_end/alert.dart';
import 'package:scrum_master_front_end/model/project.dart';
import 'package:scrum_master_front_end/model/project_member.dart';
import 'package:scrum_master_front_end/model/project_member_statics.dart';
import 'package:scrum_master_front_end/model/user.dart';
import 'package:scrum_master_front_end/pages/profile/profile_screen.dart';
import 'package:scrum_master_front_end/pages/project/bloc/project_bloc.dart';
import 'package:scrum_master_front_end/pages/project/project_screen.dart';
import 'package:scrum_master_front_end/repositories/project_repository.dart';
import 'package:scrum_master_front_end/repositories/statics_repository.dart';
import 'package:scrum_master_front_end/repositories/user_repository.dart';

part 'project_member_event.dart';

part 'project_member_state.dart';

class ProjectMemberBloc extends Bloc<ProjectMemberEvent, ProjectMemberState> {
  UserRepository userRepository = UserRepository();
  ProjectRepository projectRepository = ProjectRepository();
  StaticsRepository staticRepository = StaticsRepository();

  ProjectMemberBloc() : super(ProjectMemberState()) {
    on<ProjectMemberInitialEvent>((event, emit) async {
      // TODO: implement event handler
      state.context = event.context;
      state.project = event.project;
      ProjectMemberStatics? statics =
          await staticRepository.exportProjectMemberStatics(state.project!.id!);
      if (statics != null) {
        state.statics = statics;
        emit(state.clone(ProjectMemberStatus.initial));
      }
      add(GetListUser());
    });

    on<GetListUser>((event, emit) async {
      List<User>? users = await userRepository.findAll();
      if (users != null) {
        state.users = users;
        emit(state.clone(ProjectMemberStatus.getListUserSuccess));
      }
    });

    on<AddMember>((event, emit) async {
      ProjectMember? member = await projectRepository.addMember(
          state.project!.id!, event.user, event.role);
      if (member != null) {
        state.project!.members!.add(member);
        showSuccessAlert("Add member success", state.context!);
        emit(state.clone(ProjectMemberStatus.addMemberSuccess));
      }
    });

    on<RemoveMember>((event, emit) async {
      ProjectMember? member =
          await projectRepository.removeMember(state.project!.id!, event.user);
      if (member != null) {
        state.project!.members!
            .removeWhere((element) => element.id == member.id);
        showSuccessAlert("Remove member success", state.context!);
        emit(state.clone(ProjectMemberStatus.removeMemberSuccess));
      }
    });

    on<RemoveProject>((event, emit) async {
      try {
        await projectRepository.remove(event.project.id!);
        Navigator.of(state.context!).pop();
        Navigator.pushNamed(state.context!, ProjectScreen.routeName);
      } catch (e) {}
    });
  }
}
