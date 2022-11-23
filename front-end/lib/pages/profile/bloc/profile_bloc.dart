import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:scrum_master_front_end/alert.dart';
import 'package:scrum_master_front_end/model/user.dart';
import 'package:scrum_master_front_end/repositories/user_repository.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  UserRepository userRepository = UserRepository();

  ProfileBloc() : super(ProfileState()) {
    on<ProfileInitialEvent>((event, emit) async {
      state.context = event.context;
      User? user = await userRepository.getCurrentUser();
      if (user != null) {
        state.user = user;
        emit(state.clone(ProfileStatus.initial));
      } else {
        showErrorAlert("Get user information failure", state.context!);
      }
    });

    on<SelectImage>((event, emit) async {
      emit(state.clone(ProfileStatus.selectImageSuccess));
    });

    on<ProfileUpdatePassword>((event, emit) async {
      User? user = await userRepository.updatePassword(
          event.userId, event.oldPassword, event.newPassword);
      if (user != null) {
        state.user = user;
        showSuccessAlert("Update password success", state.context);
        emit(state.clone(ProfileStatus.initial));
      } else {
        showErrorAlert("Update password failure", state.context);
      }
      emit(state.clone(ProfileStatus.selectImageSuccess));
    });

    on<UpdateUser>((event, emit) async {
        User? user = await userRepository.update(state.user!, event.bytes);
        if (user != null) {
          state.user = user;
          showSuccessAlert("Update success", state.context);
          emit(state.clone(ProfileStatus.updateSuccess));
        } else {
          showErrorAlert("Update failure", state.context);
        }
    });
  }
}
