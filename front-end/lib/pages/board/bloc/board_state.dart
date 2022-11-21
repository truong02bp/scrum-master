part of 'board_bloc.dart';

enum BoardStatus {
  initial,
  updateSuccess,
  selectProjectSuccess,
  selectProjectFailure,
  assignToMeSuccess,
  updateIssueSuccess,
  updateStatusSuccess,
  filterSuccess,
}

class BoardState {
  late BuildContext context;
  int? userId;
  Sprint? sprint;
  List<Issue> issues = [];
  List<Issue> filterIssues = [];
  List<Project> projects = [];
  Project? selectedProject;
  bool isMyIssue = false;
  BoardStatus status = BoardStatus.initial;

  BoardState clone(BoardStatus status) {
    BoardState state = BoardState();
    state.status = status;
    state.sprint = this.sprint;
    state.issues = this.issues;
    state.context = this.context;
    state.userId = this.userId;
    state.projects = this.projects;
    state.selectedProject = this.selectedProject;
    state.isMyIssue = this.isMyIssue;
    state.filterIssues = this.filterIssues;
    return state;
  }
}
