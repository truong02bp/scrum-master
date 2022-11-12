import 'dart:async';
import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:scrum_master_front_end/alert.dart';
import 'package:scrum_master_front_end/model/issue.dart';
import 'package:scrum_master_front_end/model/project.dart';
import 'package:scrum_master_front_end/model/sprint.dart';
import 'package:scrum_master_front_end/model/user.dart';
import 'package:scrum_master_front_end/repositories/issue_repository.dart';
import 'package:scrum_master_front_end/repositories/project_repository.dart';
import 'package:scrum_master_front_end/repositories/sprint_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'issue_event.dart';

part 'issue_state.dart';

class IssueBloc extends Bloc<IssueEvent, IssueState> {
  ProjectRepository projectRepository = ProjectRepository();
  SprintRepository sprintRepository = SprintRepository();
  IssueRepository issueRepository = IssueRepository();

  IssueBloc() : super(IssueState()) {
    on<IssueInitialEvent>((event, emit) async {
      state.context = event.context;
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      List<Project>? projects = await projectRepository.findAll();
      if (projects != null && projects.isNotEmpty) {
        state.projects = projects;
        add(SelectProjectEvent(projects[0]));
        emit(state.clone(IssueStatus.initial));
      }
      state.userId = sharedPreferences.getInt("userId");
    });

    on<SelectProjectEvent>((event, emit) async {
      state.selectedProject = event.project;
      List<Sprint>? sprints =
          await sprintRepository.findByProjectId(state.selectedProject!.id!);
      if (sprints != null) {
        state.sprints = sprints;
      }
      List<Issue>? issues =
          await issueRepository.findByProjectId(state.selectedProject!.id!);
      if (issues != null) {
        state.issues = issues;
      }
      emit(state.clone(IssueStatus.selectedSuccess));
    });

    on<ShowButton>((event, emit) async {
      state.showButton = !state.showButton;
      emit(state.clone(IssueStatus.showButtonSuccess));
    });

    on<AssignToMe>((event, emit) async {
      emit(state.clone(IssueStatus.assignToMeSuccess));
    });

    on<CreateIssueEvent>((event, emit) async {
      Issue? issue = await issueRepository.create(event);
      if (issue != null) {
        showSuccessAlert("Create issue success", state.context!);
        emit(state.clone(IssueStatus.assignToMeSuccess));
      }
      else {
        showErrorAlert("Create issue failure", state.context!);
      }
    });
  }
}
