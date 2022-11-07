import 'package:flutter/material.dart';
import 'package:scrum_master_front_end/pages/active_user/active_user_screen.dart';
import 'package:scrum_master_front_end/pages/board/board_screen.dart';
import 'package:scrum_master_front_end/pages/board/board_screen.dart';
import 'package:scrum_master_front_end/pages/dash_board/dash_board_screen.dart';
import 'package:scrum_master_front_end/pages/issues/issue_screen.dart';
import 'package:scrum_master_front_end/pages/login/login_screen.dart';
import 'package:scrum_master_front_end/pages/profile/profile_screen.dart';
import 'package:scrum_master_front_end/pages/project_members/project_members.dart';
import 'package:scrum_master_front_end/pages/project_members/project_members.dart';
import 'package:scrum_master_front_end/pages/project/project_screen.dart';
import 'package:scrum_master_front_end/pages/settings/setting_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return _GeneratePageRoute(
            widget: LoginScreen(), routeName: settings.name!);
      case ActiveUserScreen.routeName:
        return _GeneratePageRoute(
            widget: ActiveUserScreen(), routeName: settings.name!);
      case DashBoardScreen.routeName:
        return _GeneratePageRoute(
            widget: DashBoardScreen(), routeName: settings.name!);
      case ProjectScreen.routeName:
        return _GeneratePageRoute(
            widget: ProjectScreen(), routeName: settings.name!);
      case IssueScreen.routeName:
        return _GeneratePageRoute(
            widget: IssueScreen(), routeName: settings.name!);
      case ProfileScreen.routeName:
        return _GeneratePageRoute(
            widget: ProfileScreen(), routeName: settings.name!);
      case SettingScreen.routeName:
        return _GeneratePageRoute(
            widget: SettingScreen(), routeName: settings.name!);
      case BoardScreen.routeName:
        return _GeneratePageRoute(
            widget: BoardScreen(), routeName: settings.name!);
      default:
        return _GeneratePageRoute(
            widget: LoginScreen(), routeName: settings.name!);
    }
  }
}

class _GeneratePageRoute extends PageRouteBuilder {
  final Widget widget;
  final String routeName;

  _GeneratePageRoute({required this.widget, required this.routeName})
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
        );
}
