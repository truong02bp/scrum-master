import 'package:flutter/material.dart';
import 'package:scrum_master_front_end/widgets/base_screen.dart';

class DashBoardScreen extends StatelessWidget {
  static const String routeName = "/dashboard";

  @override
  Widget build(BuildContext context) {
    return BaseScreen(_buildView());
  }

  Widget _buildView() {
    return Container(
      child: Center(
        child: Text('AAA'),
      ),
    );
  }
}
