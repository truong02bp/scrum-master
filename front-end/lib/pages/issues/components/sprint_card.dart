import 'package:flutter/material.dart';
import 'package:scrum_master_front_end/constants/theme.dart';
import 'package:scrum_master_front_end/model/sprint.dart';
import 'package:scrum_master_front_end/pages/issues/components/reorder_list.dart';

class SprintCard extends StatelessWidget {
  final Sprint sprint;

  SprintCard(this.sprint);

  @override
  Widget build(BuildContext context) {
    print(sprint.issues!.length);
    return Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ReorderList(sprint.issues!, sprint.project!, []),
            ),
          ],
        ));
  }
}
