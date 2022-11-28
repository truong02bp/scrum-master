import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:scrum_master_front_end/model/activity_log.dart';
import 'package:scrum_master_front_end/model/issue.dart';
import 'package:scrum_master_front_end/repositories/issue_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'dash_board_event.dart';

part 'dash_board_state.dart';

class DashBoardBloc extends Bloc<DashBoardEvent, DashBoardState> {
  IssueRepository issueRepository = IssueRepository();

  DashBoardBloc() : super(DashBoardState()) {
    on<DashBoardInitial>((event, emit) async {
      state.context = event.context;
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      state.userId = sharedPreferences.getInt("userId");
      List<Issue>? issues = await issueRepository.findByUserId(state.userId!);
      if (issues != null) {
        state.issues = issues;
      }
      emit(state.clone(DashBoardStatus.getIssuesSuccess));
      add(GetLog());
    });

    on<GetLog>((event, emit) async {
      List<ActivityLog>? logs =
          await issueRepository.findLog(state.userId!, state.page);
      if (logs != null) {
        state.logs.addAll(logs);
        state.page++;
        emit(state.clone(DashBoardStatus.getIssuesSuccess));
      }
    });
  }
}
