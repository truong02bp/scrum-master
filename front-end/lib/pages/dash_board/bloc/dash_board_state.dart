part of 'dash_board_bloc.dart';

enum DashBoardStatus {initial, getIssuesSuccess, getHistoryLogSuccess}

class DashBoardState {

  late BuildContext context;
  List<Issue> issues = [];
  DashBoardStatus status = DashBoardStatus.initial;
  int? userId;

  DashBoardState clone(DashBoardStatus status) {
    DashBoardState state = DashBoardState();
    state.issues = this.issues;
    state.context = this.context;
    state.status = this.status;
    state.userId = this.userId;
    return state;
  }
}

