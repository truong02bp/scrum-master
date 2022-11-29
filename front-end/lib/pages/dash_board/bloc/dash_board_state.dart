part of 'dash_board_bloc.dart';

enum DashBoardStatus {
  initial,
  getIssuesSuccess,
  getHistoryLogSuccess,
  getStaticsSuccess
}

class DashBoardState {
  late BuildContext context;
  List<Issue> issues = [];
  DashBoardStatus status = DashBoardStatus.initial;
  int? userId;
  int page = 0;
  List<ActivityLog> logs = [];
  IssueStatics? issueStatics;
  ProjectStatics? projectStatics;
  PerformanceStatics? performanceStatics;

  DashBoardState clone(DashBoardStatus status) {
    DashBoardState state = DashBoardState();
    state.issues = this.issues;
    state.context = this.context;
    state.status = this.status;
    state.userId = this.userId;
    state.page = this.page;
    state.logs = this.logs;
    state.issueStatics = this.issueStatics;
    state.projectStatics = this.projectStatics;
    state.performanceStatics = this.performanceStatics;
    return state;
  }
}
