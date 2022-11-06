part of 'project_bloc.dart';

@immutable
abstract class ProjectEvent {}

class ProjectEventInitial extends ProjectEvent {
    BuildContext context;

    ProjectEventInitial(this.context);
}

class GetListUser extends ProjectEvent {

}

class CreateProjectEvent extends ProjectEvent {

    final String name;
    final String projectKey;
    final User projectLeader;

    CreateProjectEvent(this.name, this.projectKey, this.projectLeader);
}
