import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrum_master_front_end/pages/issues/bloc/issue_bloc.dart';

class CreateSprint extends StatefulWidget {
  const CreateSprint({Key? key}) : super(key: key);

  @override
  State<CreateSprint> createState() => _CreateSprintState();
}

class _CreateSprintState extends State<CreateSprint> {
  late DateTime startDate;
  late DateTime endDate;
  late IssueBloc bloc;
  late CreateSprintEvent event;
  bool canEdit = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startDate = DateTime.now();
    endDate = DateTime.now();
    bloc = BlocProvider.of<IssueBloc>(context);
    event = CreateSprintEvent();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AwesomeDialog(
            context: context,
            animType: AnimType.TOPSLIDE,
            dialogType: DialogType.NO_HEADER,
            aligment: Alignment.topCenter,
            keyboardAware: true,
            width: 1000,
            body: Container(
                child: Padding(
                    padding:
                        const EdgeInsets.only(left: 120, top: 10, right: 100),
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        Text(
                          'Create sprint',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 1,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(children: [
                          SizedBox(
                              width: 100,
                              child: Text(
                                'Sprint name',
                                style: TextStyle(fontSize: 16),
                              )),
                          SizedBox(
                            width: 30,
                          ),
                          Container(
                            width: 300,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 10, top: 3),
                            child: TextFormField(
                              onChanged: (value) {
                                event.name = value;
                              },
                              decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(bottom: 10)),
                            ),
                          ),
                        ]),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(children: [
                          SizedBox(
                              width: 100,
                              child: Text(
                                'Duration',
                                style: TextStyle(fontSize: 16),
                              )),
                          SizedBox(
                            width: 30,
                          ),
                          Container(
                            width: 300,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.only(left: 10, top: 3),
                            child: DropdownSearch<String>(
                              items: [
                                '1 week',
                                '2 weeks',
                                '3 weeks',
                                '4 weeks',
                                'Customize'
                              ],
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(5)),
                              ),
                              onChanged: (value) {
                                if (value == '1 week') {
                                  setState(() {
                                    canEdit = false;
                                    startDate = DateTime.now();
                                    endDate =
                                        DateTime.now().add(Duration(days: 7));
                                  });
                                }
                                if (value == '2 weeks') {
                                  setState(() {
                                    canEdit = false;
                                    startDate = DateTime.now();
                                    endDate =
                                        DateTime.now().add(Duration(days: 14));
                                  });
                                }
                                if (value == '3 weeks') {
                                  setState(() {
                                    canEdit = false;
                                    startDate = DateTime.now();
                                    endDate =
                                        DateTime.now().add(Duration(days: 21));
                                  });
                                }
                                if (value == '4 weeks') {
                                  setState(() {
                                    canEdit = false;
                                    startDate = DateTime.now();
                                    endDate =
                                        DateTime.now().add(Duration(days: 28));
                                  });
                                }
                                if (value == 'Customize') {
                                  setState(() {
                                    canEdit = true;
                                    startDate = DateTime.now();
                                    endDate = DateTime.now();
                                  });
                                }
                                bloc.add(SelectDate());
                              },
                              selectedItem: 'Customize',
                            ),
                          )
                        ]),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(children: [
                          SizedBox(
                              width: 100,
                              child: Text(
                                'Start date',
                                style: TextStyle(fontSize: 16),
                              )),
                          SizedBox(
                            width: 30,
                          ),
                          InkWell(
                            onTap: () {
                              if (canEdit) {
                                showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2020),
                                        lastDate: DateTime(2024))
                                    .then((value) => {
                                          setState(() {
                                            if (value != null) {
                                              startDate = value;
                                              bloc.add(SelectDate());
                                            }
                                          })
                                        });
                              }
                            },
                            child: BlocBuilder<IssueBloc, IssueState>(
                              bloc: bloc,
                              builder: (context, state) {
                                return Container(
                                  width: 300,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(7)),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '    ${startDate.day}/${startDate.month}/${startDate.year}',
                                        style: TextStyle(fontSize: 18),
                                      )),
                                );
                              },
                            ),
                          ),
                        ]),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(children: [
                          SizedBox(
                              width: 100,
                              child: Text(
                                'End date',
                                style: TextStyle(fontSize: 16),
                              )),
                          SizedBox(
                            width: 30,
                          ),
                          InkWell(
                            onTap: () {
                              if (canEdit) {
                                showDatePicker(
                                        context: context,
                                        initialDate: startDate,
                                        firstDate: startDate,
                                        lastDate: DateTime(2024))
                                    .then((value) => {
                                          setState(() {
                                            if (value != null) {
                                              endDate = value;
                                              bloc.add(SelectDate());
                                            }
                                          })
                                        });
                              }
                            },
                            child: BlocBuilder<IssueBloc, IssueState>(
                              bloc: bloc,
                              builder: (context, state) {
                                return Container(
                                  width: 300,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(7)),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '    ${endDate.day}/${endDate.month}/${endDate.year}',
                                        style: TextStyle(fontSize: 18),
                                      )),
                                );
                              },
                            ),
                          ),
                        ]),
                        const SizedBox(
                          height: 30,
                        ),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                                onTap: () async {
                                  event.startDate = startDate;
                                  event.endDate = endDate;
                                  bloc.add(event);
                                  Navigator.pop(context);
                                },
                                child: createButton())),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    )))))
          ..show();
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 40,
        width: 120,
        decoration: BoxDecoration(
            color: Colors.blueAccent.withOpacity(0.7),
            borderRadius: BorderRadius.circular(7)),
        child: Center(child: Text(' + Create sprint')),
      ),
    );
  }

  Widget createButton() {
    return Container(
      height: 40,
      width: 90,
      decoration: BoxDecoration(
          color: Colors.blueAccent, borderRadius: BorderRadius.circular(7)),
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
          Text('Create'),
          Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}
