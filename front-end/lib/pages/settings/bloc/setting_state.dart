part of 'setting_bloc.dart';

enum SettingStatus { loading, initial, getRoleSuccess, inviteSuccess }

class SettingState {
  List<User>? users;
  List<Role>? roles;
  Organization? organization;
  SettingStatus status = SettingStatus.initial;
  Role? selectedRole;
  String email = "";
  BuildContext? context;

  SettingState clone(SettingStatus status) {
    SettingState state = SettingState();
    state.status = status;
    state.users = this.users;
    state.organization = this.organization;
    state.roles = this.roles;
    state.context = this.context;
    state.email = this.email;
    state.selectedRole = this.selectedRole;
    return state;
  }
}
