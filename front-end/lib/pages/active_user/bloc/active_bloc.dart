import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'active_event.dart';

part 'active_state.dart';

class ActiveBloc extends Bloc<ActiveEvent, ActiveState> {
  ActiveBloc() : super(ActiveState()) {
    on<ShowPasswordEvent>((event, emit) {
      state.showPassword = !state.showPassword;
      state.clone(ActiveStatus.showPassword);
    });
  }
}
