import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrum_master_front_end/model/issue.dart';
import 'package:scrum_master_front_end/model/sprint.dart';
import 'package:scrum_master_front_end/pages/sprint/bloc/sprint_bloc.dart';
import 'package:scrum_master_front_end/pages/sprint/components/reorder_list.dart';

class SprintCard extends StatefulWidget {
  final Sprint sprint;
  final List<Issue> issues;

  SprintCard(this.sprint, this.issues);

  @override
  State<SprintCard> createState() => _SprintCardState();
}

class _SprintCardState extends State<SprintCard> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SprintBloc>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ReorderList(widget.issues, widget.sprint.project!, []),
        ),
        BlocBuilder<SprintBloc, SprintState>(
          bloc: bloc,
          builder: (context, state) {
            return InkWell(
              onTap: () {
                AwesomeDialog(
                  context: context,
                  animType: AnimType.TOPSLIDE,
                  dialogType: DialogType.NO_HEADER,
                  aligment: Alignment.topCenter,
                  keyboardAware: true,
                  width: 1000,
                  body: Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Issues',
                          style: TextStyle(fontSize: 25),
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
                        Container(
                          height: 400,
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10)),
                          child: ReorderableListView(
                            children: List.generate(state.projectIssues.length,
                                (index) {
                              final issue = state.projectIssues[index];
                              return ListTile(
                                key: ValueKey(issue.priority),
                                leading: Container(
                                  width: 150,
                                  child: Row(
                                    children: [
                                      BlocBuilder<SprintBloc, SprintState>(
                                        bloc: bloc,
                                        buildWhen: (pre, current) =>
                                            current.status ==
                                            SprintStatus.selectIssueSuccess,
                                        builder: (context, state) {
                                          return InkWell(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.grey),
                                                  color: Colors.white),
                                              height: 20,
                                              width: 20,
                                              child: Center(
                                                child: state.selectIssues
                                                        .contains(issue.id!)
                                                    ? Icon(
                                                        Icons.check,
                                                        color: Colors.green,
                                                        size: 12,
                                                      )
                                                    : Container(),
                                              ),
                                            ),
                                            onTap: () {
                                              bloc.add(SelectIssue(issue.id));
                                            },
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Image.asset(
                                        "assets/icons/${issue.type}.png",
                                        width: 20,
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        issue.code!,
                                        style: TextStyle(color: Colors.black54),
                                      )
                                    ],
                                  ),
                                ),
                                title: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${issue.title!}aa",
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      height: 20,
                                      width: 25,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                        child: issue.estimate != null
                                            ? Text(
                                                '${issue.estimate}',
                                                style: TextStyle(fontSize: 13),
                                              )
                                            : Text(''),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                  ],
                                ),
                                tileColor: Colors.white,
                              );
                            }),
                            onReorder: (previous, current) {
                              setState(() {
                                if (current > previous) {
                                  current--;
                                }
                                final item =
                                    state.projectIssues.removeAt(previous);
                                state.projectIssues.insert(current, item);
                                // bloc.add(UpdateIndexIssue(issues));
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            onTap: () {
                              bloc.add(AddIssue());
                              Navigator.pop(context);
                            },
                            borderRadius: BorderRadius.circular(7),
                            child: Container(
                              height: 40,
                              width: 90,
                              decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(7)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Spacer(),
                                  Icon(
                                    Icons.add,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text('Add'),
                                  Spacer(
                                    flex: 2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                )..show();
              },
              borderRadius: BorderRadius.circular(7),
              child: Container(
                height: 40,
                width: 120,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(7)),
                child: Center(child: Text('+ Add issue')),
              ),
            );
          },
        ),
      ],
    );
  }
}
