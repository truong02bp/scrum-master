import 'package:flutter/material.dart';
import 'package:scrum_master_front_end/model/issue.dart';

class ReorderList extends StatefulWidget {
  final List<Issue> issues;

  ReorderList(this.issues);

  @override
  State<ReorderList> createState() => _ReorderListState();
}

class _ReorderListState extends State<ReorderList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          borderRadius: BorderRadius.circular(10)),
      child: ReorderableListView(
        children: List.generate(widget.issues.length, (index) {
          final issue = widget.issues[index];
          return ListTile(
            key: ValueKey(issue.priority),
            leading: Container(
              width: 100,
              child: Row(
                children: [
                  Image.asset(
                    "assets/icons/${issue.type}.png",
                    width: 20,
                    height: 20,
                  ),
                  SizedBox(width: 10,),
                  Text(issue.code!, style: TextStyle(color: Colors.black54),)
                ],
              ),
            ),

            title: Text("${issue.title!}"),
            onTap: () {},
            tileColor: Colors.white,
          );
        }),
        onReorder: (previous, current) {
          setState(() {
            if (current > previous) {
              current--;
            }
            final item = widget.issues.removeAt(previous);
            widget.issues.insert(current, item);
          });
        },
      ),
    );
  }
}
