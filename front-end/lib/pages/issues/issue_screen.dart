import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:scrum_master_front_end/constants/theme.dart';
import 'package:scrum_master_front_end/model/project.dart';
import 'package:scrum_master_front_end/pages/issues/bloc/issue_bloc.dart';
import 'package:scrum_master_front_end/pages/issues/components/create_issue.dart';
import 'package:scrum_master_front_end/pages/issues/components/reorder_list.dart';
import 'package:scrum_master_front_end/widgets/base_screen.dart';

class IssueScreen extends StatelessWidget {
  static const String routeName = "/issue";

  @override
  Widget build(BuildContext context) {
    return BaseScreen(BlocProvider(
      create: (context) => IssueBloc()..add(IssueInitialEvent()),
      child: Builder(
        builder: (context) => _buildView(context),
      ),
    ));
  }

  Widget _buildView(BuildContext context) {
    final bloc = BlocProvider.of<IssueBloc>(context);
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Issues',
                style: TextStyle(fontSize: 25),
              ),
              Spacer(),
              Container(
                height: 40,
                width: 200,
                child: BlocBuilder<IssueBloc, IssueState>(
                  bloc: bloc,
                  builder: (context, state) {
                    if (state.projects == null) {
                      return Container();
                    }
                    return FormBuilderDropdown<Project>(
                        name: 'Project',
                        dropdownColor: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                        onChanged: (value) {
                          state.selectedProject = value;
                        },
                        initialValue: state.selectedProject,
                        autofocus: false,
                        menuMaxHeight: 300,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(width: 1, color: Colors.grey.withOpacity(0.2))
                            ),
                            labelText: 'Project',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            contentPadding: EdgeInsets.all(5)),
                        items: List.generate(
                            state.projects!.length,
                            (index) => DropdownMenuItem(
                                  value: state.projects![index],
                                  child: Text(state.projects![index].name!),
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
              child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10)),
            child: BlocBuilder<IssueBloc, IssueState>(
              bloc: bloc,
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Backlog',
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text('${state.issues.length} issues'),
                          Spacer(),
                          InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 40,
                              width: 120,
                              decoration: BoxDecoration(
                                  color: Colors.blueAccent.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(7)),
                              child: Center(child: Text('+ Create sprint')),
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        child: Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ReorderList(),
                                ),
                                CreateIssue()
                              ],
                            )),
                      ),
                    ],
                  ),
                );
              },
            ),
          ))
        ],
      ),
    );
  }
}
