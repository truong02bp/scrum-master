import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:scrum_master_front_end/alert.dart';
import 'package:scrum_master_front_end/model/issue.dart';
import 'package:scrum_master_front_end/model/project.dart';
import 'package:scrum_master_front_end/model/sprint.dart';
import 'package:scrum_master_front_end/repositories/issue_repository.dart';
import 'package:scrum_master_front_end/repositories/project_repository.dart';
import 'package:scrum_master_front_end/repositories/sprint_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'sprint_event.dart';

part 'sprint_state.dart';

class SprintBloc extends Bloc<SprintEvent, SprintState> {
  ProjectRepository projectRepository = ProjectRepository();
  SprintRepository sprintRepository = SprintRepository();
  IssueRepository issueRepository = IssueRepository();

  SprintBloc() : super(SprintState()) {
    on<SprintEventInitial>((event, emit) async {
      state.context = event.context;
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      List<Project>? projects = await projectRepository.findAll();
      if (projects != null && projects.isNotEmpty) {
        state.projects = projects;
        add(SelectProjectEvent(projects[0]));
        emit(state.clone(SprintStatus.initial));
      }
      state.userId = sharedPreferences.getInt("userId");
    });

    on<SelectProjectEvent>((event, emit) async {
      state.selectedProject = event.project;
      state.issues.clear();

      List<Sprint>? sprints =
          await sprintRepository.findByProjectId(state.selectedProject!.id!);
      if (sprints != null) {
        state.sprints = sprints;
        if (sprints.isNotEmpty) {
          add(SelectSprintEvent(sprints[0]));
        }
      }
      List<Issue>? projectIssues =
          await issueRepository.findByProjectId(state.selectedProject!.id!);
      if (projectIssues != null) {
        state.projectIssues = projectIssues;
      }
      emit(state.clone(SprintStatus.selectProjectSuccess));
    });

    on<SelectSprintEvent>((event, emit) async {
      state.selectedSprint = event.sprint;
      emit(state.clone(SprintStatus.selectSprintSuccess));
      List<Issue>? issues =
          await issueRepository.findBySprintId(state.selectedSprint!.id!);
      if (issues != null) {
        state.issues = issues;
      }
      emit(state.clone(SprintStatus.selectSprintSuccess));
    });

    on<CreateSprintEvent>((event, emit) async {
      event.project = state.selectedProject!;
      Sprint? sprint = await sprintRepository.create(event);
      if (sprint != null) {
        showSuccessAlert("Create sprint success", state.context!);
        state.sprints.add(sprint);
      } else {
        showErrorAlert("Create sprint failure", state.context!);
      }
    });

    on<SelectDate>((event, emit) async {
      emit(state.clone(SprintStatus.selectDateSuccess));
    });
  }
}
