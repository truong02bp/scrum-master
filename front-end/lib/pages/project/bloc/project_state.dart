part of 'project_bloc.dart';

enum ProjectStatus { initial, getUsersSuccess, createProjectSuccess }

class ProjectState {
  BuildContext? context;
  List<Project> projects = [];
  List<User> users = [];
  ProjectStatus status = ProjectStatus.initial;

  ProjectState clone(ProjectStatus status) {
    ProjectState state = ProjectState();
    state.status = status;
    state.users = this.users;
    state.projects = this.projects;
    state.context = this.context;
    return state;
  }
}
