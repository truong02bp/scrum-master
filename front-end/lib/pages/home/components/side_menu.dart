import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scrum_master_front_end/pages/active_user/active_user_screen.dart';

class SideMenu extends StatelessWidget {

  Function callBack;

  SideMenu({required this.callBack});

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
              callBack(0);
            },
          ),
          DrawerListTile(
            title: "Projects",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              callBack(1);
            },
          ),
          DrawerListTile(
            title: "Boards",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              callBack(2);
            },
          ),
          DrawerListTile(
            title: "Issues",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {
              callBack(3);
            },
          ),
          DrawerListTile(
            title: "Profile",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {
              callBack(4);
            },
          ),
          DrawerListTile(
            title: "Settings",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {
              callBack(5);
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
