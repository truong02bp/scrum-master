part of 'profile_bloc.dart';

enum ProfileStatus {initial, selectImageSuccess, updateSuccess}

class ProfileState {
  late BuildContext context;
  User? user;
  ProfileStatus status = ProfileStatus.initial;

  ProfileState clone(ProfileStatus status) {
    ProfileState state = ProfileState();
    state.status = status;
    state.user = this.user;
    state.context = this.context;
    return state;
  }
}

