part of 'project_member_bloc.dart';

@immutable
abstract class ProjectMemberEvent {}

class InviteMemberEvent extends ProjectMemberEvent {

}

class ProjectMemberInitialEvent extends ProjectMemberEvent {
    Project project;
    BuildContext context;

    ProjectMemberInitialEvent(this.context, this.project);
}

class GetListUser extends ProjectMemberEvent {

}

class AddMember extends ProjectMemberEvent {
    final User user;
    final String role;

    AddMember(this.user, this.role);
}

class RemoveMember extends ProjectMemberEvent {
    final User user;

    RemoveMember(this.user);
}

