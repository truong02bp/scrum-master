part of 'issue_bloc.dart';

@immutable
abstract class IssueEvent {}

class IssueInitialEvent extends IssueEvent {

  BuildContext context;

  IssueInitialEvent(this.context);
}

class SelectProjectEvent extends IssueEvent {
  final Project project;

  SelectProjectEvent(this.project);
}

class SelectSprintEvent extends IssueEvent {
  final Sprint sprint;

  SelectSprintEvent(this.sprint);
}

class ShowButton extends IssueEvent {}

class AssignToMe extends IssueEvent {

}

class UpdateIndexIssue extends IssueEvent {
  List<Issue> issues;

  UpdateIndexIssue(this.issues);
}


class CreateIssueEvent extends IssueEvent {
  Project? project;
  String? type;
  String? description;
  String? title;
  String? label;
  int? estimate;
  User? assignee;
  Sprint? sprint;
}

class UpdateIssueEvent extends IssueEvent {
  int? id;
  String? type;
  String? description;
  String? title;
  String? label;
  int? estimate;
  User? assignee;
  Sprint? sprint;
}

class DeleteIssue extends IssueEvent {
  int id;

  DeleteIssue(this.id);
}


