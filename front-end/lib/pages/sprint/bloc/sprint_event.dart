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
