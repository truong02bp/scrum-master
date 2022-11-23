part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class ProfileInitialEvent extends ProfileEvent {
  BuildContext context;

  ProfileInitialEvent(this.context);
}

class SelectImage extends ProfileEvent {

}

class ProfileUpdatePassword extends ProfileEvent {
  final int userId;
  final String oldPassword;
  final String newPassword;

  ProfileUpdatePassword({required this.userId, required this.oldPassword, required this.newPassword});
}


class UpdateUser extends ProfileEvent {
  Uint8List? bytes;

  UpdateUser(this.bytes);
}