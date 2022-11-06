import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrum_master_front_end/pages/board/bloc/board_bloc.dart';
import 'package:scrum_master_front_end/widgets/base_screen.dart';

import 'components/active_sprint.dart';

class BoardScreen extends StatelessWidget {
  static const String routeName = "/board";

  @override
  Widget build(BuildContext context) {
    return BaseScreen(BlocProvider(
        create: (context) => BoardBloc(),
        child: Builder(builder: (context) => _buildView(context))));
  }

  Widget _buildView(BuildContext context) {
    return Scaffold(
      body: ActiveSprint(),
    );
  }

}
