import 'package:flutter/material.dart';
import 'package:scrum_master_front_end/constants/theme.dart';
import 'package:scrum_master_front_end/responsive.dart';
import 'package:scrum_master_front_end/widgets/side_menu.dart';

class BaseScreen extends StatefulWidget {
  final Widget screen;

  BaseScreen(this.screen);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final minWidth = 700.0;

  final minHeight = 700.0;

  ScrollController _horizontalController = ScrollController();

  ScrollController _verticalController = ScrollController();

  @override
  void dispose() {
    _horizontalController.dispose();
    _verticalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scaffold = buildScreen(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final horizontalScrollbarEnabled = constraints.minWidth < minWidth;
        final verticalScrollbarEnabled = constraints.minHeight < minHeight;

        if (horizontalScrollbarEnabled && verticalScrollbarEnabled) {
          return Scrollbar(
            controller: _horizontalController,
            child: Scrollbar(
              notificationPredicate: (notification) => notification.depth == 1,
              controller: _verticalController,
              child: SingleChildScrollView(
                controller: _horizontalController,
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  controller: _verticalController,
                  child: Container(
                    width: minWidth,
                    height: minHeight,
                    child: scaffold,
                  ),
                ),
              ),
            ),
          );
        } else if (horizontalScrollbarEnabled) {
          return Scrollbar(
            controller: _horizontalController,
            child: SingleChildScrollView(
              controller: _horizontalController,
              scrollDirection: Axis.horizontal,
              child: Container(
                width: minWidth,
                child: scaffold,
              ),
            ),
          );
        } else if (verticalScrollbarEnabled) {
          return Scrollbar(
            controller: _verticalController,
            child: SingleChildScrollView(
              controller: _verticalController,
              child: Container(
                height: minHeight,
                child: scaffold,
              ),
            ),
          );
        }

        return scaffold;
      },
    );
  }

  Widget buildScreen(BuildContext context) {
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
              child: widget.screen,
            ),
          ],
        ),
      ),
    );
  }
}
