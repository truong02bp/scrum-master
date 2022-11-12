import 'dart:async';
import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:scrum_master_front_end/model/issue.dart';
import 'package:scrum_master_front_end/model/project.dart';
import 'package:scrum_master_front_end/model/sprint.dart';
import 'package:scrum_master_front_end/repositories/issue_repository.dart';
import 'package:scrum_master_front_end/repositories/project_repository.dart';
import 'package:scrum_master_front_end/repositories/sprint_repository.dart';

part 'issue_event.dart';

part 'issue_state.dart';

class IssueBloc extends Bloc<IssueEvent, IssueState> {
  ProjectRepository projectRepository = ProjectRepository();
  SprintRepository sprintRepository = SprintRepository();
  IssueRepository issueRepository = IssueRepository();

  IssueBloc() : super(IssueState()) {
    on<IssueInitialEvent>((event, emit) async {
      List<Project>? projects = await projectRepository.findAll();
      if (projects != null && projects.isNotEmpty) {
        state.projects = projects;
        add(SelectProjectEvent(projects[0]));
        emit(state.clone(IssueStatus.initial));
      }
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
  }
}
