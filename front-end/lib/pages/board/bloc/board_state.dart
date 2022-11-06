part of 'board_bloc.dart';

enum BoardStatus { initial, updateSuccess }

class BoardState {
  Sprint? sprint;
  List<Issue> issues = [];

  BoardStatus boardStatus = BoardStatus.initial;

  BoardState clone(BoardStatus status) {
    BoardState state = BoardState();
    state.boardStatus = status;
    state.sprint = this.sprint;
    state.issues = this.issues;
    return state;
  }
}
