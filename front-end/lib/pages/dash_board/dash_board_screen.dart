import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrum_master_front_end/constants/theme.dart';
import 'package:scrum_master_front_end/pages/dash_board/bloc/dash_board_bloc.dart';
import 'package:scrum_master_front_end/widgets/base_screen.dart';

import 'components/reorder_list.dart';

class DashBoardScreen extends StatelessWidget {
  static const String routeName = "/dashboard";

  @override
  Widget build(BuildContext context) {
    return BaseScreen(BlocProvider(
      create: (context) => DashBoardBloc()..add(DashBoardInitial(context)),
      child: Builder(builder: (context) {
        return _buildView(context);
      }),
    ));
  }

  Widget _buildView(BuildContext context) {
    final bloc = BlocProvider.of<DashBoardBloc>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard',
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 1,
              color: Colors.grey.withOpacity(0.5),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My issues',
                        style: TextStyle(fontSize: 21, color: Colors.black),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: BlocBuilder<DashBoardBloc, DashBoardState>(
                          bloc: bloc,
                          builder: (context, state) {
                            print(state.issues.length);
                            if (state.issues.isEmpty) {
                              return Container();
                            }
                            return ReorderList(state.issues);
                          },
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
