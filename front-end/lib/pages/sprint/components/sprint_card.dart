import 'package:flutter/material.dart';
import 'package:scrum_master_front_end/model/issue.dart';
import 'package:scrum_master_front_end/model/sprint.dart';
import 'package:scrum_master_front_end/pages/sprint/components/reorder_list.dart';

class SprintCard extends StatelessWidget {
  final Sprint sprint;
  final List<Issue> issues;

  SprintCard(this.sprint, this.issues);

  @override
  Widget build(BuildContext context) {
    print(issues.length);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ReorderList(issues, sprint.project!, []),
        ),
      ],
    );
  }
}
