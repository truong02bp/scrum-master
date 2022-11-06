import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:scrum_master_front_end/model/user.dart';
import 'package:scrum_master_front_end/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository userRepository = UserRepository();

  LoginBloc() : super(LoginState()) {
    on<LoginInitialEvent>((event, emit) async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? token = await sharedPreferences.getString("token");
      if (token != null) {
        emit(state.clone(LoginStatus.loginSuccess));
      }
    });
    _onLoginSubmitEvent();
    _onShowPasswordEvent();
  }

  void _onLoginSubmitEvent() {
    on<LoginSubmitEvent>((event, emit) async {
      state.email = event.email;
      state.password = event.password;
      User? user = await userRepository.login(state.email, state.password);
      if (user != null) {
        state.user = user;
        emit(state.clone(LoginStatus.loginSuccess));
      } else {
        emit(state.clone(LoginStatus.loginFailure));
      }
    });
  }

  void _onShowPasswordEvent() {
    on<ShowPasswordEvent>((event, emit) {
      state.showPassword = !state.showPassword;
      emit(state.clone(LoginStatus.showPassword));
    });
  }
}
