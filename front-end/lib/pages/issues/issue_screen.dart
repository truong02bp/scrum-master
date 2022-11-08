import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:scrum_master_front_end/constants/theme.dart';
import 'package:scrum_master_front_end/model/project.dart';
import 'package:scrum_master_front_end/pages/issues/bloc/issue_bloc.dart';
import 'package:scrum_master_front_end/widgets/base_screen.dart';

class IssueScreen extends StatelessWidget {
  static const String routeName = "/issue";

  @override
  Widget build(BuildContext context) {
    return BaseScreen(BlocProvider(
      create: (context) =>
      IssueBloc()
        ..add(IssueInitialEvent()),
      child: Builder(builder: (context) => _buildView(context),),
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
                        decoration: InputDecoration(
                            labelText: 'Project',
                            floatingLabelBehavior:
                            FloatingLabelBehavior.always,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(5)),
                        items: List.generate(
                            state.projects!.length,
                                (index) =>
                                DropdownMenuItem(
                                  value: state.projects![index],
                                  child: Text(state.projects![index].name!),
                                )));
                  },
                ),
              ),
              const SizedBox(width: 50,)
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 1,
            color: Colors.grey.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}
