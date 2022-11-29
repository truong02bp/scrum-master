import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:scrum_master_front_end/model/activity_log.dart';
import 'package:scrum_master_front_end/model/issue.dart';
import 'package:scrum_master_front_end/model/issue_statics.dart';
import 'package:scrum_master_front_end/model/performance_statics.dart';
import 'package:scrum_master_front_end/model/project_statics.dart';
import 'package:scrum_master_front_end/repositories/issue_repository.dart';
import 'package:scrum_master_front_end/repositories/statics_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'dash_board_event.dart';

part 'dash_board_state.dart';

class DashBoardBloc extends Bloc<DashBoardEvent, DashBoardState> {
  IssueRepository issueRepository = IssueRepository();
  StaticsRepository staticRepository = StaticsRepository();

  DashBoardBloc() : super(DashBoardState()) {
    on<DashBoardInitial>((event, emit) async {
      state.context = event.context;
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      state.userId = sharedPreferences.getInt("userId");

      IssueStatics? issueStatics =
          await staticRepository.exportIssueStatics(state.userId!);
      if (issueStatics != null) {
        state.issueStatics = issueStatics;
        emit(state.clone(DashBoardStatus.getStaticsSuccess));
      }

      PerformanceStatics? performanceStatics =
          await staticRepository.exportPerformanceStatics(state.userId!);
      if (issueStatics != null) {
        state.performanceStatics = performanceStatics;
        emit(state.clone(DashBoardStatus.getStaticsSuccess));
      }

      ProjectStatics? projectStatics =
          await staticRepository.exportProjectStatics(state.userId!);
      if (issueStatics != null) {
        state.projectStatics = projectStatics;
        emit(state.clone(DashBoardStatus.getStaticsSuccess));
      }
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
