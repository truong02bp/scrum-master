import 'package:flutter/material.dart';

class ReorderList extends StatelessWidget {
  const ReorderList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          borderRadius:
          BorderRadius.circular(10)),
      child: ReorderableListView(
        children: [],
        onReorder: (previous, current) {},
      ),
    );
  }
}
