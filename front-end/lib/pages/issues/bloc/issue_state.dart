part of 'issue_bloc.dart';

enum IssueStatus { initial, selectedSuccess, showButtonSuccess }

class IssueState {
  Project? selectedProject;
  List<Project>? projects;
  List<Issue> issues = [];
  List<Sprint>? sprints;
  IssueStatus status = IssueStatus.initial;

  bool showButton = true;

  IssueState clone(IssueStatus status) {
    IssueState state = IssueState();
    state.status = status;
    state.selectedProject = this.selectedProject;
    state.projects = this.projects;
    state.showButton = this.showButton;
    return state;
  }
}
