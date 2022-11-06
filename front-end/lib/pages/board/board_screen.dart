import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrum_master_front_end/pages/board/bloc/board_bloc.dart';
import 'package:scrum_master_front_end/pages/board/components/home_drawer.dart';
import 'package:scrum_master_front_end/widgets/custom_app_bar/custom_app_bar.dart';

import '../../constants/color.dart';
import '../home/home_screen.dart';
import 'components/active_sprint.dart';

class BoardScreen extends StatelessWidget {
  const BoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => BoardBloc(),
        child: Builder(builder: (context) => _buildView(context)));
  }

  Widget _buildView(BuildContext context) {
    return Scaffold(
      body: ActiveSprint(),
    );
  }

}
