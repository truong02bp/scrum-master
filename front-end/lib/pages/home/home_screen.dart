import 'package:flutter/material.dart';
import 'package:scrum_master_front_end/constants/theme.dart';
import 'package:scrum_master_front_end/pages/board/board_screen.dart';
import 'package:scrum_master_front_end/pages/dash_board/dash_board_screen.dart';
import 'package:scrum_master_front_end/pages/home/components/side_menu.dart';
import 'package:scrum_master_front_end/pages/issues/issue_screen.dart';
import 'package:scrum_master_front_end/pages/profile/profile_screen.dart';
import 'package:scrum_master_front_end/pages/project/project_screen.dart';
import 'package:scrum_master_front_end/pages/settings/setting_screen.dart';
import 'package:scrum_master_front_end/responsive.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 1;

  List<Widget> screens = [
    DashBoardScreen(),
    ProjectScreen(),
    BoardScreen(),
    IssueScreen(),
    ProfileScreen(),
    SettingScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Responsive.isDesktop(context)
          ? PreferredSize(child: Container(), preferredSize: Size.zero)
          : AppBar(
              backgroundColor: secondaryColor,
              title: Text('Scrum Master'),
            ),
      drawer: SideMenu(callBack: (index) {
        setState(() {
          _index = index;
        });
      },),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(callBack: (index) {
                    setState(() {
                      _index = index;
                  });
                },),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 7,
              child: screens[_index],
            ),
          ],
        ),
      ),
    );
  }
}
