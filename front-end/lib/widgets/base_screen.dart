import 'package:flutter/material.dart';
import 'package:scrum_master_front_end/constants/theme.dart';
import 'package:scrum_master_front_end/responsive.dart';
import 'package:scrum_master_front_end/widgets/side_menu.dart';

class BaseScreen extends StatelessWidget {

  final Widget screen;


  BaseScreen(this.screen);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Responsive.isDesktop(context)
          ? PreferredSize(child: Container(), preferredSize: Size.zero)
          : AppBar(
        backgroundColor: secondaryColor,
        title: Text('Scrum Master'),
      ),
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 7,
              child: screen,
            ),
          ],
        ),
      ),
    );
  }
}
