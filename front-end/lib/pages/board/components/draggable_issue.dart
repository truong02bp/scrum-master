import 'dart:math';

import 'package:flutter/material.dart';

class DraggableIssue extends StatefulWidget {
  @override
  State<DraggableIssue> createState() => _DraggableIssueState();
}

class _DraggableIssueState extends State<DraggableIssue> {
  List<Widget> todo = [];
  List<Widget> processing = [];
  List<Widget> preRelease = [];
  List<Widget> done = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todo.add(_buildItem());
  }

  @override
  Widget build(BuildContext context) {
    int count = max(todo.length,
            max(processing.length, max(done.length, preRelease.length))) +
        1;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildColumn(count, todo),
        _buildColumn(count, processing),
        _buildColumn(count, preRelease),
        _buildColumn(count, done),
      ],
    );
  }

  Widget _buildColumn(int count, list) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: DragTarget(
        onLeave: (Widget? widget) {
          list.remove(widget);
        },
        builder: (context, a, b) {
          return Container(
              margin: EdgeInsets.only(right: 10),
              color: Colors.grey.withOpacity(0.1),
              height: count * 140,
              width: double.infinity,
              child: list.isNotEmpty
                  ? ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        final item = list[index];
                        return Draggable(
                          data: item,
                          child: item,
                          feedback: item,
                          childWhenDragging: Container(),
                        );
                      })
                  : Container());
        },
        onAccept: (Widget widget) {
          setState(() {
            list.add(widget);
          });
        },
      ),
    );
  }

  Widget _buildItem() {
    final item = Container(
      height: 120,
      width: 280,
      margin: EdgeInsets.only(top: 10, left: 5, right: 5),
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(15)),
    );
    return item;
  }
}
