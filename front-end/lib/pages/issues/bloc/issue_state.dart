part of 'issue_bloc.dart';

enum IssueStatus {
  initial,
  selectedSuccess,
  showButtonSuccess,
  assignToMeSuccess,
  createIssueSuccess
}

class IssueState {
  BuildContext? context;
  Project? selectedProject;
  List<Project>? projects;
  List<Issue> issues = [];
  List<Sprint>? sprints = [];
  IssueStatus status = IssueStatus.initial;
  int? userId;

  bool showButton = true;

  IssueState clone(IssueStatus status) {
    IssueState state = IssueState();
    state.context = this.context;
    state.status = status;
    state.selectedProject = this.selectedProject;
    state.projects = this.projects;
    state.showButton = this.showButton;
    state.userId = this.userId;
    return state;
  }
}
