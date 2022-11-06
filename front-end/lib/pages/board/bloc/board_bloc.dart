import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:scrum_master_front_end/model/issue.dart';
import 'package:scrum_master_front_end/model/sprint.dart';

part 'board_event.dart';
part 'board_state.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  BoardBloc() : super(BoardState()) {
    on<BoardEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
