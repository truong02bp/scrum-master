import 'dart:js';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:scrum_master_front_end/alert.dart';
import 'package:scrum_master_front_end/model/organization.dart';
import 'package:scrum_master_front_end/model/role.dart';
import 'package:scrum_master_front_end/model/user.dart';
import 'package:scrum_master_front_end/repositories/user_repository.dart';

part 'setting_event.dart';

part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  UserRepository userRepository = UserRepository();

  SettingBloc() : super(SettingState()) {
    on<SettingInitialEvent>((event, emit) async {
      state.users = [];
      state.context = event.context;
      emit(state.clone(SettingStatus.loading));
      List<User>? users = await userRepository.findAll();
      if (users != null) {
        state.users = users;
        state.organization = users[0].organization;
      }
      else {
        showErrorAlert("Get users failure!", state.context!);
      }
      emit(state.clone(SettingStatus.initial));
      List<Role>? roles = await userRepository.findAllRole();
      state.roles = roles;
    });

    on<InviteMemberEvent>((event, emit) async {
      try {
        emit(state.clone(SettingStatus.loading));
        User? user =
            await userRepository.create(state.email, state.selectedRole!);
        emit(state.clone(SettingStatus.inviteSuccess));
        showSuccessAlert("Invite user success!", state.context!);
      } catch (e) {
        showErrorAlert(e.toString(), state.context!);
      }
    });
  }
}
