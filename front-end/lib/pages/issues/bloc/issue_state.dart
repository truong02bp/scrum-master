part of 'issue_bloc.dart';

enum IssueStatus { initial, selectedSuccess }

class IssueState {
  Project? selectedProject;
  List<Project>? projects;
  List<Issue>? issues;
  List<Sprint>? sprints;
  IssueStatus status = IssueStatus.initial;

  IssueState clone(IssueStatus status) {
    IssueState state = IssueState();
    state.status = status;
    state.selectedProject = this.selectedProject;
    state.projects = this.projects;
    return state;
  }
}
