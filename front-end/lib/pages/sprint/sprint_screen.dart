import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:scrum_master_front_end/constants/theme.dart';
import 'package:scrum_master_front_end/model/project.dart';
import 'package:scrum_master_front_end/model/sprint.dart';
import 'package:scrum_master_front_end/pages/sprint/bloc/sprint_bloc.dart';
import 'package:scrum_master_front_end/pages/sprint/components/create_sprint.dart';
import 'package:scrum_master_front_end/pages/sprint/components/sprint_card.dart';
import 'package:scrum_master_front_end/widgets/base_screen.dart';

class SprintScreen extends StatelessWidget {
  static const String routeName = "/sprint";

  @override
  Widget build(BuildContext context) {
    return BaseScreen(BlocProvider(
      create: (context) => SprintBloc()..add(SprintEventInitial(context)),
      child: Builder(
        builder: (context) => _buildView(context),
      ),
    ));
  }

  Widget _buildView(BuildContext context) {
    final bloc = BlocProvider.of<SprintBloc>(context);
    return Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Sprints',
                    style: TextStyle(fontSize: 25),
                  ),
                  Spacer(),
                  Container(
                    height: 40,
                    width: 200,
                    child: BlocBuilder<SprintBloc, SprintState>(
                      bloc: bloc,
                      builder: (context, state) {
                        if (state.selectedProject == null) {
                          return Container();
                        }
                        return FormBuilderDropdown<Project>(
                            name: 'Project',
                            dropdownColor: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                            onChanged: (value) {},
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
              Expanded(
                child: BlocBuilder<SprintBloc, SprintState>(
                  bloc: bloc,
                  builder: (context, state) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 50,
                                  width: 300,
                                  child: BlocBuilder<SprintBloc, SprintState>(
                                    bloc: bloc,
                                    builder: (context, state) {
                                      if (state.selectedSprint == null) {
                                        return Container();
                                      }
                                      return FormBuilderDropdown<Sprint>(
                                          name: 'Sprint',
                                          dropdownColor: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          onChanged: (value) {
                                            bloc.add(SelectSprintEvent(value!));
                                          },
                                          initialValue: state.selectedSprint,
                                          menuMaxHeight: 300,
                                          decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide(
                                                      width: 1,
                                                      color: Colors.grey
                                                          .withOpacity(0.2))),
                                              labelText: 'Sprint',
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                              contentPadding:
                                                  EdgeInsets.all(5)),
                                          items: List.generate(
                                              state.sprints.length,
                                              (index) => DropdownMenuItem(
                                                    value: state.sprints[index],
                                                    child: Text(state
                                                        .sprints[index].name!),
                                                  )));
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                BlocBuilder<SprintBloc, SprintState>(
                                  bloc: bloc,
                                  builder: (context, state) {
                                    if (state.selectedSprint == null ||
                                        state.selectedSprint!.status ==
                                            "ACTIVE") {
                                      return Container();
                                    }
                                    return InkWell(
                                      onTap: () {},
                                      child: Container(
                                        height: 40,
                                        width: 70,
                                        decoration: BoxDecoration(
                                            color: Colors.blueAccent,
                                            borderRadius:
                                                BorderRadius.circular(7)),
                                        child: Center(child: Text('Active')),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Spacer(),
                                Text(
                                  '${state.sprints.length} sprint',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black54),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                CreateSprint()
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Expanded(
                                child: state.selectedSprint != null
                                    ? Container(
                                        child: SprintCard(state.selectedSprint!,
                                            state.issues))
                                    : Container()),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ]));
  }
}
