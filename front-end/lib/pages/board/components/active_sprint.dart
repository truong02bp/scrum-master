import 'package:flutter/material.dart';
import 'package:scrum_master_front_end/pages/board/components/draggable_issue.dart';

class ActiveSprint extends StatelessWidget {
  int size = 4;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Scrum Sprint 2',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
          ),
          const SizedBox(
            height: 15,
          ),
          _buildFilter(),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            height: 0.75,
            color: Colors.black.withOpacity(0.1),
          ),
          _buildStatusBar(),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView(
            children: [
              DraggableIssue(),
              const SizedBox(height: 20,),
              DraggableIssue(),
            ],
          )),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Row(children: [
      Text(
        'FU board',
        style: TextStyle(fontSize: 18, color: Colors.black),
      ),
      Spacer(),
      Icon(
        Icons.lock_clock,
        size: 16,
        color: Colors.black,
      ),
      const SizedBox(
        width: 5,
      ),
      Text(
        '9 days remaining',
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
      const SizedBox(
        width: 50,
      ),
      InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(5),
        child: Container(
            height: 30,
            width: 100,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(5)),
            child: Center(child: Text('Close sprint'))),
      ),
      const SizedBox(
        width: 20,
      ),
    ]);
  }

  Widget _buildFilter() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'Filter : ',
          style: TextStyle(fontSize: 19),
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          'Only my issues',
          style: TextStyle(color: Colors.blueAccent, fontSize: 17),
        ),
        const SizedBox(
          width: 40,
        ),
        Text(
          'Recently updated',
          style: TextStyle(color: Colors.blueAccent, fontSize: 17),
        ),
      ],
    );
  }

  Widget _buildStatusBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildColumn("To do"),
        _buildColumn("In process"),
        _buildColumn("Pre-Release"),
        _buildColumn("Done"),
      ],
    );
  }

  Widget _buildColumn(String title) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: Container(
        margin: EdgeInsets.only(right: 10),
        height: 50,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          width: 1.0,
          color: Colors.black,
        ))),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(fontSize: 17, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
