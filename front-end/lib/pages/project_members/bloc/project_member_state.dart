part of 'project_member_bloc.dart';

enum ProjectMemberStatus {
  initial,
  loading,
  addMemberSuccess,
  removeMemberSuccess,
  getListUserSuccess
}

class ProjectMemberState {
  Project? project;
  List<User> users = [];
  BuildContext? context;
  ProjectMemberStatus status = ProjectMemberStatus.initial;
  ProjectMemberStatics? statics;

  ProjectMemberState clone(ProjectMemberStatus status) {
    ProjectMemberState state = ProjectMemberState();
    state.context = this.context;
    state.users = this.users;
    state.status = status;
    state.project = this.project;
    state.statics = this.statics;
    return state;
  }
}
