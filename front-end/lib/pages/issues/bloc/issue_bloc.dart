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
      state.issues.clear();

      List<Sprint>? sprints =
          await sprintRepository.findByProjectId(state.selectedProject!.id!);
      if (sprints != null) {
        state.sprints = sprints;
        if (sprints.isNotEmpty) {
          state.selectedSprint = sprints[0];
        }
      }
      List<Issue>? issues =
          await issueRepository.findByProjectId(state.selectedProject!.id!);
      if (issues != null) {
        state.issues = issues;
      }
      emit(state.clone(IssueStatus.selectedSuccess));
    });

    on<UpdateIndexIssue>((event, emit) async {
      List<Issue>? issues = await issueRepository.updateIndex(event.issues);
      if (issues != null) {
        state.issues = issues;
        emit(state.clone(IssueStatus.showButtonSuccess));
      }
    });

    on<SelectSprintEvent>((event, emit) async {
      state.selectedSprint = event.sprint;
      emit(state.clone(IssueStatus.showButtonSuccess));
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
        state.issues.add(issue);
        showSuccessAlert("Create issue success", state.context!);
        emit(state.clone(IssueStatus.assignToMeSuccess));
      } else {
        showErrorAlert("Create issue failure", state.context!);
      }
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
        int index =
            state.issues.indexWhere((element) => element.id == issue.id);
        state.issues.insert(index + 1, issue);
        state.issues.removeAt(index);
        showSuccessAlert("Update issue success", state.context!);
        emit(state.clone(IssueStatus.assignToMeSuccess));
      } else {
        showErrorAlert("Update issue failure", state.context!);
      }
    });

    on<DeleteIssue>((event, emit) async {
      try {
        await issueRepository.delete(event.id);
        state.issues.removeWhere((element) => element.id == event.id);
        showSuccessAlert("Delete issue success", state.context!);
        emit(state.clone(IssueStatus.assignToMeSuccess));
      }
      catch (exception) {
        showErrorAlert("Delete issue failure", state.context!);
      }
    });
  }
}
