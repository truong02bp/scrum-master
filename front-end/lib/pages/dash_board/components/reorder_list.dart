import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:scrum_master_front_end/model/issue.dart';
import 'package:scrum_master_front_end/model/project.dart';
import 'package:scrum_master_front_end/model/sprint.dart';
import 'package:scrum_master_front_end/model/user.dart';
import 'package:scrum_master_front_end/pages/dash_board/bloc/dash_board_bloc.dart';
import 'package:scrum_master_front_end/pages/sprint/bloc/sprint_bloc.dart';

class ReorderList extends StatefulWidget {
  final List<Issue> issues;

  ReorderList(this.issues);

  @override
  State<ReorderList> createState() => _ReorderListState();
}

class _ReorderListState extends State<ReorderList> {
  HtmlEditorController controller = HtmlEditorController();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<DashBoardBloc>(context);
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
                Text("${issue.title!}", overflow: TextOverflow.ellipsis),
                Spacer(),
                Container(
                  height: 20,
                  width: 25,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10)),
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
            onTap: () {
              _onTap(issue);
            },
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
            // bloc.add(UpdateIndexIssue(widget.issues));
          });
        },
      ),
    );
  }

  void _onTap(Issue issue) {
    final bloc = BlocProvider.of<DashBoardBloc>(context);
    UpdateIssueEvent event = UpdateIssueEvent();
    event.id = issue.id;
    event.estimate = issue.estimate;
    event.type = issue.type;
    event.title = issue.title;
    event.assignee = issue.assignee;
    event.sprint = issue.sprint;
    event.label = issue.label;
    event.description = issue.description;
    if (event.description != null) {
      controller.setText(event.description!);
    }
    AwesomeDialog(
      context: context,
      animType: AnimType.TOPSLIDE,
      dialogType: DialogType.NO_HEADER,
      aligment: Alignment.topCenter,
      keyboardAware: true,
      width: 1000,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 50, top: 10, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Update issue: ${issue.code}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
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
                Row(
                  children: [
                    SizedBox(
                        width: 100,
                        child: Text(
                          'Projects',
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
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(5)),
                          ),
                          selectedItem: issue.project!.name,
                        )),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(children: [
                  SizedBox(
                      width: 100,
                      child: Text(
                        'Issue type',
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
                      items: ['Story', 'Task', 'Bug'],
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(5)),
                      ),
                      onChanged: (value) {
                        event.type = value;
                      },
                      selectedItem: event.type,
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
                        'Assignee',
                        style: TextStyle(fontSize: 16),
                      )),
                  SizedBox(
                    width: 30,
                  ),
                  BlocBuilder<DashBoardBloc, DashBoardState>(
                    bloc: bloc,
                    builder: (context, state) {

                      return Container(
                        width: 300,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(7)),
                        padding: EdgeInsets.only(left: 10, top: 3),
                        child: DropdownSearch<User>(
                          selectedItem: event.assignee,
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(5)),
                          ),
                          onChanged: (value) {
                            event.assignee = value;
                          },
                          itemAsString: (item) => item.name!,
                          filterFn: (user, filter) {
                            return user.name!.contains(filter);
                          },
                          popupProps: PopupProps.menu(
                            showSearchBox: true,
                            searchFieldProps: TextFieldProps(
                                decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    contentPadding: EdgeInsets.all(5))),
                          ),
                          autoValidateMode: AutovalidateMode.always,
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                    },
                    child: Text(
                      'Assign to me',
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ]),
                const SizedBox(
                  height: 20,
                ),
                Row(children: [
                  SizedBox(
                      width: 100,
                      child: Text(
                        'Label',
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
                      items: ['Operation', 'Deploy', 'Hot-fix'],
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(5)),
                      ),
                      onChanged: (value) {
                        event.label = value;
                      },
                      selectedItem: event.label,
                    ),
                  )
                ]),
                const SizedBox(
                  height: 30,
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
                        'Summary',
                        style: TextStyle(fontSize: 16),
                      )),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: 650,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(7)),
                    padding: EdgeInsets.only(left: 10, top: 3),
                    child: TextFormField(
                      initialValue: event.title,
                      onChanged: (value) {
                        event.title = value;
                      },
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
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
                        'Estimate',
                        style: TextStyle(fontSize: 16),
                      )),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: 650,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(7)),
                    padding: EdgeInsets.only(left: 10, top: 3),
                    child: TextFormField(
                      initialValue:
                          event.estimate != null ? '${event.estimate}' : '',
                      onChanged: (value) {
                        event.estimate = int.parse(value);
                      },
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
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
                        'Description',
                        style: TextStyle(fontSize: 16),
                      )),
                  SizedBox(
                    width: 30,
                  ),
                  BlocBuilder<DashBoardBloc, DashBoardState>(
                    bloc: bloc,
                    builder: (context, state) {
                      return Container(
                          width: 650,
                          height: 300,
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(7)),
                          padding: EdgeInsets.only(left: 10, top: 3),
                          child: HtmlEditor(
                            controller: controller, //required
                            htmlEditorOptions: HtmlEditorOptions(
                                hint: "Your description here...",
                                initialText: issue.description,
                                shouldEnsureVisible: false,
                                adjustHeightForKeyboard: true),
                            htmlToolbarOptions: HtmlToolbarOptions(
                              dropdownBackgroundColor: Colors.white,
                              dropdownBoxDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            otherOptions: OtherOptions(
                              height: 300,
                            ),
                          ));
                    },
                  ),
                ]),
                const SizedBox(
                  height: 40,
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                        onTap: () async {
                          event.description = await controller.getText();
                          Navigator.pop(context);
                        },
                        child: updateButton())),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    )..show();
  }

  Widget updateButton() {
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
          Text('Update'),
          Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}
