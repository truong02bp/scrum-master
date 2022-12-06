import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scrum_master_front_end/pages/active_user/active_user_screen.dart';
import 'package:scrum_master_front_end/pages/board/board_screen.dart';
import 'package:scrum_master_front_end/pages/dash_board/dash_board_screen.dart';
import 'package:scrum_master_front_end/pages/issues/issue_screen.dart';
import 'package:scrum_master_front_end/pages/login/login_screen.dart';
import 'package:scrum_master_front_end/pages/profile/profile_screen.dart';
import 'package:scrum_master_front_end/pages/project/project_screen.dart';
import 'package:scrum_master_front_end/pages/settings/setting_screen.dart';
import 'package:scrum_master_front_end/pages/sprint/sprint_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
            pngSrc: "assets/icons/menu_dashbord.png",
            press: () {
              Navigator.pushNamed(context, DashBoardScreen.routeName);
            },
          ),
          DrawerListTile(
            title: "Projects",
            pngSrc: "assets/icons/menu_tran.png",
            press: () {
              Navigator.pushNamed(context, ProjectScreen.routeName);
            },
          ),
          DrawerListTile(
            title: "Boards",
            pngSrc: "assets/icons/menu_doc.png",
            press: () {
              Navigator.pushNamed(context, BoardScreen.routeName);
            },
          ),
          DrawerListTile(
            title: "Sprints",
            pngSrc: "assets/icons/sprint.png",
            press: () {
              Navigator.pushNamed(context, SprintScreen.routeName);
            },
          ),
          DrawerListTile(
            title: "Issues",
            pngSrc: "assets/icons/menu_task.png",
            press: () {
              Navigator.pushNamed(context, IssueScreen.routeName);
            },
          ),
          DrawerListTile(
            title: "Profile",
            pngSrc: "assets/icons/menu_profile.png",
            press: () {
              Navigator.pushNamed(context, ProfileScreen.routeName);
            },
          ),
          DrawerListTile(
            title: "Members",
            pngSrc: "assets/icons/menu_setting.png",
            press: () {
              Navigator.pushNamed(context, SettingScreen.routeName);
            },
          ),
          DrawerListTile(
            title: "Log out",
            pngSrc: "assets/icons/logout.png",
            press: () {
              AwesomeDialog(
                context: context,
                animType: AnimType.TOPSLIDE,
                dialogType: DialogType.QUESTION,
                aligment: Alignment.center,
                keyboardAware: true,
                title: 'Confirm to logout',
                btnOkOnPress: () async {
                  SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.remove("userId");
                  sharedPreferences.remove("token");
                  Navigator.pushNamed(context, LoginScreen.routeName);
                },
                btnCancelOnPress: () {},
                width: 400,
              )..show();
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
    required this.pngSrc,
    required this.press,
  }) : super(key: key);

  final String title, pngSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: Image.asset(
        pngSrc,
        color: Colors.white,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
