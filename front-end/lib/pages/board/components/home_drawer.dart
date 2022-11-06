import 'package:flutter/material.dart';
import 'package:scrum_master_front_end/pages/board/components/active_sprint.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black12,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Image.asset("assets/images/scrum.png"),
            title: Text(
              'Falcon UA',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ListTile(
            leading: Image.asset(
              "assets/images/board.png",
              height: 25,
              width: 25,
              color: Colors.white,
            ),
            title: Text('Boards'),
            onTap: (){

            },
          ),
          ListTile(
            leading: Image.asset(
              "assets/images/backlog.png",
              height: 25,
              width: 25,
              color: Colors.white,
            ),
            title: Text('Backlog'),
            onTap: () {},
          ),
          ListTile(
            leading: Image.asset(
              "assets/images/sprint.png",
              height: 25,
              width: 25,
              color: Colors.white,
            ),
            title: Text('Active sprint'),
            onTap: () {},
          ),
          ListTile(
            leading: Image.asset(
              "assets/images/issue.png",
              height: 25,
              width: 25,
              color: Colors.white,
            ),
            title: Text('Issues'),
            onTap: () {},
          ),
          ListTile(
            leading: Image.asset(
              "assets/images/activity.png",
              height: 25,
              width: 25,
              color: Colors.white,
            ),
            title: Text('Activity'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {},
          ),
        ],
      ),
    );
  }


}
