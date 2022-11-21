import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
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

part 'board_event.dart';

part 'board_state.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  ProjectRepository projectRepository = ProjectRepository();
  SprintRepository sprintRepository = SprintRepository();
  IssueRepository issueRepository = IssueRepository();

  BoardBloc() : super(BoardState()) {
    on<BoardEventInitial>((event, emit) async {
      state.context = event.context;
      List<Project>? projects = await projectRepository.findAll();
      if (projects != null && projects.isNotEmpty) {
        state.projects = projects;
        add(SelectProjectEvent(projects[0]));
        emit(state.clone(BoardStatus.initial));
      }
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      state.userId = sharedPreferences.getInt("userId");
    });

    on<SelectProjectEvent>((event, emit) async {
      Sprint? sprint =
          await sprintRepository.findActiveSprintByProjectId(event.project.id!);
      if (sprint != null) {
        state.selectedProject = event.project;
        state.issues.clear();
        state.sprint = sprint;
        List<Issue>? issues =
            await issueRepository.findBySprintId(state.sprint!.id!);
        if (issues != null) {
          state.issues = issues;
        }
        emit(state.clone(BoardStatus.selectProjectSuccess));
      } else {
        showErrorAlert("Active sprint not available", state.context);
        emit(state.clone(BoardStatus.selectProjectFailure));
      }
    });
    on<FilterIssue>((event, emit) async {
      state.isMyIssue = event.isMyIssue;
      if (state.isMyIssue) {
        state.filterIssues = state.issues
            .where((element) =>
                element.assignee != null &&
                element.assignee!.id == state.userId)
            .toList();
      }
      emit(state.clone(BoardStatus.filterSuccess));
    });

    on<UpdateIssueEvent>((event, emit) async {
      Issue? issue = await issueRepository.update(
          event.id,
          event.type,
          event.description,
          event.title,
          event.label,
          event.estimate,
          event.assignee,
          event.sprint);
      if (issue != null) {
        if (!state.isMyIssue) {
          int index =
              state.issues.indexWhere((element) => element.id == issue.id);
          state.issues.insert(index + 1, issue);
          state.issues.removeAt(index);
        } else {
          int index = state.filterIssues
              .indexWhere((element) => element.id == issue.id);
          state.filterIssues.insert(index + 1, issue);
          state.filterIssues.removeAt(index);
        }

        showSuccessAlert("Update issue success", state.context);
        emit(state.clone(BoardStatus.updateIssueSuccess));
      } else {
        showErrorAlert("Update issue failure", state.context);
      }
    });

    on<AssignToMe>((event, emit) async {
      emit(state.clone(BoardStatus.assignToMeSuccess));
    });

    on<UpdateIssueStatus>((event, emit) async {
      Issue? issue =
          await issueRepository.updateStatus(event.issueId, event.status);
      if (issue != null) {
        if (state.isMyIssue) {
          state.filterIssues.removeWhere((element) => element.id! == issue.id);
          state.filterIssues.add(issue);
        } else {
          state.issues.removeWhere((element) => element.id! == issue.id);
          state.issues.add(issue);
        }

        emit(state.clone(BoardStatus.updateStatusSuccess));
      } else {
        showErrorAlert("Update status issue failure", state.context);
      }
    });
  }
}
