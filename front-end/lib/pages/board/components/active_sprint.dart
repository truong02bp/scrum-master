import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrum_master_front_end/model/sprint.dart';
import 'package:scrum_master_front_end/pages/board/bloc/board_bloc.dart';
import 'package:scrum_master_front_end/pages/board/components/draggable_issue.dart';

class ActiveSprint extends StatelessWidget {
  final Sprint sprint;

  ActiveSprint(this.sprint);

  int size = 4;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<BoardBloc>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            InkWell(
              onTap: () {
                bloc.add(FilterIssue(false));
              },
              borderRadius: BorderRadius.circular(7),
              child: Container(
                width: 50,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(7)),
                child: Center(
                  child: Text(
                    'All',
                    style: TextStyle(color: Colors.blueAccent, fontSize: 18),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            InkWell(
              onTap: () {
                bloc.add(FilterIssue(true));
              },
              borderRadius: BorderRadius.circular(7),
              child: Container(
                width: 150,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(7)),
                child: Center(
                  child: Text(
                    'Only my issues',
                    style: TextStyle(color: Colors.blueAccent, fontSize: 17),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
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
        BlocBuilder<BoardBloc, BoardState>(
          bloc: bloc,
          builder: (context, state) {
            print(state.status);
            return DraggableIssue(state.issues);
          },
        )
      ],
    );
  }

  Widget _buildTitle() {
    return Row(children: [
      Text(
        '${sprint.name}',
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
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
