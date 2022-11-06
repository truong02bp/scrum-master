import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrum_master_front_end/constants/theme.dart';
import 'package:scrum_master_front_end/pages/project/bloc/project_bloc.dart';
import 'package:scrum_master_front_end/pages/project/components/project_card.dart';
import 'package:scrum_master_front_end/pages/project/components/project_title.dart';
import 'package:scrum_master_front_end/widgets/loading_icon.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProjectBloc()..add(ProjectEventInitial(context)),
      child: Builder(builder: (context) => _buildView(context)),
    );
  }

  Widget _buildView(BuildContext buildContext) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          ProjectTitle(),
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
          BlocBuilder<ProjectBloc, ProjectState>(builder: (context, state) {
            if (state.projects.isNotEmpty) {
              return Wrap(
                spacing: 90,
                runSpacing: 40,
                children: List.generate(
                  state.projects.length,
                      (index) => ProjectCard(state.projects[index]),
                ),
              );
            }
            return Container();
          })
        ],
      ),
    );
  }
}
