part of 'active_bloc.dart';

enum ActiveStatus { initial, showPassword }

class ActiveState {
  String name = "";
  String password = "";
  String confirmPassword = "";
  bool showPassword = false;
  ActiveStatus status = ActiveStatus.initial;

  ActiveState clone(ActiveStatus status) {
    ActiveState state = ActiveState();
    state.name = this.name;
    state.password = this.password;
    state.confirmPassword = this.confirmPassword;
    state.status = status;
    return state;
  }
}
