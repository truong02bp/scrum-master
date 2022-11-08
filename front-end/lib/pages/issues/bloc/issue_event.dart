part of 'issue_bloc.dart';

@immutable
abstract class IssueEvent {}

class IssueInitialEvent extends IssueEvent {}

class SelectProjectEvent extends IssueEvent {
  final Project project;

  SelectProjectEvent(this.project);
}
