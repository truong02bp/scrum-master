import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'custom_app_bar_event.dart';
part 'custom_app_bar_state.dart';

class CustomAppBarBloc extends Bloc<CustomAppBarEvent, CustomAppBarState> {
  CustomAppBarBloc() : super(CustomAppBarState()) {
    on<CustomAppBarEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
