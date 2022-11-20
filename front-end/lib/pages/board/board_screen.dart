import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:scrum_master_front_end/constants/theme.dart';
import 'package:scrum_master_front_end/model/project.dart';

import 'package:scrum_master_front_end/pages/board/bloc/board_bloc.dart';
import 'package:scrum_master_front_end/widgets/base_screen.dart';

import 'components/active_sprint.dart';

class BoardScreen extends StatelessWidget {
  static const String routeName = "/board";

  @override
  Widget build(BuildContext context) {
    return BaseScreen(BlocProvider(
        create: (context) => BoardBloc()..add(BoardEventInitial(context)),
        child: Builder(builder: (context) => _buildView(context))));
  }

  Widget _buildView(BuildContext context) {
    final bloc = BlocProvider.of<BoardBloc>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Board',
                  style: TextStyle(fontSize: 25),
                ),
                Spacer(),
                Container(
                  height: 40,
                  width: 200,
                  child: BlocBuilder<BoardBloc, BoardState>(
                    bloc: bloc,
                    builder: (context, state) {
                      if (state.selectedProject == null) {
                        return Container();
                      }
                      return FormBuilderDropdown<Project>(
                          name: 'Project',
                          dropdownColor: Colors.white,
                          borderRadius: BorderRadius.circular(7),
                          onChanged: (value) {
                            bloc.add(SelectProjectEvent(value!));
                          },
                          initialValue: state.selectedProject,
                          autofocus: false,
                          menuMaxHeight: 300,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Colors.grey.withOpacity(0.2))),
                              labelText: 'Project',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              contentPadding: EdgeInsets.all(5)),
                          items: List.generate(
                              state.projects.length,
                              (index) => DropdownMenuItem(
                                    value: state.projects[index],
                                    child: Text(state.projects[index].name!),
                                  )));
                    },
                  ),
                ),
                const SizedBox(
                  width: 50,
                )
              ],
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
            BlocBuilder<BoardBloc, BoardState>(
              bloc: bloc,
              builder: (context, state) {
                if (state.sprint == null) {
                  return Container();
                }
                return ActiveSprint(state.sprint!);
              },
            ),
          ],
        ),
      ),
    );
  }

}
