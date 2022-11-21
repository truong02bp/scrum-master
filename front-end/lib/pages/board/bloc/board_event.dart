part of 'board_bloc.dart';

@immutable
abstract class BoardEvent {}

class BoardEventInitial extends BoardEvent {
  BuildContext context;

  BoardEventInitial(this.context);
}

class SelectProjectEvent extends BoardEvent {
  final Project project;

  SelectProjectEvent(this.project);
}

class FilterIssue extends BoardEvent {

  final bool isMyIssue;

  FilterIssue(this.isMyIssue);
}

class UpdateIssueEvent extends BoardEvent {
  int? id;
  String? type;
  String? description;
  String? title;
  String? label;
  int? estimate;
  User? assignee;
  Sprint? sprint;
}

class AssignToMe extends BoardEvent {

}

class UpdateIssueStatus extends BoardEvent {
  int issueId;
  String status;

  UpdateIssueStatus(this.issueId, this.status);
}