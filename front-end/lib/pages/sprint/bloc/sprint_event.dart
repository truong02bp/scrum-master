part of 'sprint_bloc.dart';

@immutable
abstract class SprintEvent {}

class SprintEventInitial extends SprintEvent {
  BuildContext context;

  SprintEventInitial(this.context);
}

class SelectProjectEvent extends SprintEvent {
  final Project project;

  SelectProjectEvent(this.project);
}

class SelectSprintEvent extends SprintEvent {
  final Sprint sprint;

  SelectSprintEvent(this.sprint);
}

class CreateSprintEvent extends SprintEvent {
  late DateTime startDate;
  late DateTime endDate;
  late String name;
  late Project project;
}

class SelectDate extends SprintEvent {

}

class SelectIssue extends SprintEvent {
  int? id;

  SelectIssue(this.id);
}

class AddIssue extends SprintEvent {

}

class ActiveSprint extends SprintEvent {

}

class UpdateIssueEvent extends SprintEvent {
  int? id;
  String? type;
  String? description;
  String? title;
  String? label;
  int? estimate;
  User? assignee;
  Sprint? sprint;
}

class AssignToMe extends SprintEvent {

}
