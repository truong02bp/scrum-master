part of 'login_bloc.dart';

enum LoginStatus { initial, loginSuccess, loginFailure, showPassword }

class LoginState {
  User? user;
  String email = "";
  String password = "";
  bool showPassword = false;
  LoginStatus status = LoginStatus.initial;

  LoginState clone(LoginStatus status) {
    LoginState state = LoginState();
    state.user = this.user;
    state.status = status;
    state.email = this.email;
    state.showPassword = this.showPassword;
    state.password = this.password;
    return state;
  }
}
