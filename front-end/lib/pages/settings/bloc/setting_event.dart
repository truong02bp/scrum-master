part of 'setting_bloc.dart';

@immutable
abstract class SettingEvent {}

class SettingInitialEvent extends SettingEvent {
  BuildContext context;

  SettingInitialEvent(this.context);
}

class InviteMemberEvent extends SettingEvent  {

}

class RemoveMemberEvent extends SettingEvent  {
  int userId;

  RemoveMemberEvent(this.userId);
}
