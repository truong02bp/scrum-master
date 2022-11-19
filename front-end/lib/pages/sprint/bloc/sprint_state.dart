part of 'sprint_bloc.dart';

enum SprintStatus {
  initial,
  selectProjectSuccess,
  selectSprintSuccess,
  createIssueSuccess,
  selectDateSuccess,
  selectIssueSuccess,
  addIssueSuccess,
  assignToMeSuccess,
  updateIssueSuccess,
  activeSprintSuccess
}

class SprintState {
  late BuildContext context;
  List<Project> projects = [];
  Sprint? selectedSprint;
  List<Sprint> sprints = [];
  List<Issue> issues = [];
  List<Issue> projectIssues = [];
  Project? selectedProject;
  SprintStatus status = SprintStatus.initial;
  int? userId;
  Set<int> selectIssues = Set();

  SprintState clone(SprintStatus status) {
    SprintState state = SprintState();
    state.status = status;
    state.context = this.context;
    state.projects = this.projects;
    state.userId = this.userId;
    state.selectedProject = this.selectedProject;
    state.selectedSprint = this.selectedSprint;
    state.sprints = this.sprints;
    state.issues = this.issues;
    state.projectIssues = this.projectIssues;
    state.selectIssues = this.selectIssues;
    return state;
  }
}
