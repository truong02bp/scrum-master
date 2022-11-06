import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:scrum_master_front_end/alert.dart';
import 'package:scrum_master_front_end/model/project.dart';
import 'package:scrum_master_front_end/model/user.dart';
import 'package:scrum_master_front_end/repositories/project_repository.dart';
import 'package:scrum_master_front_end/repositories/user_repository.dart';

part 'project_event.dart';

part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  UserRepository userRepository = UserRepository();
  ProjectRepository projectRepository = ProjectRepository();

  ProjectBloc() : super(ProjectState()) {
    on<ProjectEventInitial>((event, emit) async {
      // TODO: implement event handler
      state.context = event.context;

      add(GetListProject());

      emit(state.clone(ProjectStatus.initial));
    });

    on<GetListProject>((event, emit) async {
      List<Project>? projects = await projectRepository.findAll();
      if (projects != null) {
        state.projects = projects;
      }
      emit(state.clone(ProjectStatus.getProjectsSuccess));
    });


    on<GetListUser>((event, emit) async {
      List<User>? users = await userRepository.findAll();
      if (users != null) {
        state.users = users;
      }
    });

    on<CreateProjectEvent>((event, emit) async {
      Project? project = await projectRepository.create(
          event.name, event.projectKey, event.projectLeader);
      if (project != null) {
        emit(state.clone(ProjectStatus.createProjectSuccess));
        add(GetListProject());
        showSuccessAlert("Create project success", state.context!);
      }
    });
  }
}
