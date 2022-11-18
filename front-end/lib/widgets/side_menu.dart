import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scrum_master_front_end/pages/active_user/active_user_screen.dart';
import 'package:scrum_master_front_end/pages/board/board_screen.dart';
import 'package:scrum_master_front_end/pages/dash_board/dash_board_screen.dart';
import 'package:scrum_master_front_end/pages/issues/issue_screen.dart';
import 'package:scrum_master_front_end/pages/profile/profile_screen.dart';
import 'package:scrum_master_front_end/pages/project/project_screen.dart';
import 'package:scrum_master_front_end/pages/settings/setting_screen.dart';
import 'package:scrum_master_front_end/pages/sprint/sprint_screen.dart';

class SideMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/scrum.png"),
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {
              Navigator.pushNamed(context, DashBoardScreen.routeName);
            },
          ),
          DrawerListTile(
            title: "Projects",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              Navigator.pushNamed(context, ProjectScreen.routeName);
            },
          ),
          DrawerListTile(
            title: "Sprints",
            svgSrc: "assets/icons/sprint.svg",
            press: () {
              Navigator.pushNamed(context, SprintScreen.routeName);
            },
          ),
          DrawerListTile(
            title: "Boards",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              Navigator.pushNamed(context, BoardScreen.routeName);
            },
          ),
          DrawerListTile(
            title: "Issues",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {
              Navigator.pushNamed(context, IssueScreen.routeName);
            },
          ),
          DrawerListTile(
            title: "Profile",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {
              Navigator.pushNamed(context, ProfileScreen.routeName);
            },
          ),
          DrawerListTile(
            title: "Settings",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {
              Navigator.pushNamed(context, SettingScreen.routeName);
            },
          ),
          DrawerListTile(
            title: "Log out",
            svgSrc: "assets/icons/logout.svg",
            press: () {

            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: Image.network(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
