part of 'dash_board_bloc.dart';

@immutable
abstract class DashBoardEvent {}

class DashBoardInitial extends DashBoardEvent {
  BuildContext context;

  DashBoardInitial(this.context);
}

class GetLog extends DashBoardEvent {

}