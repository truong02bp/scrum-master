import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrum_master_front_end/model/user.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:scrum_master_front_end/constants/host_api.dart';
import 'package:scrum_master_front_end/constants/theme.dart';
import 'package:scrum_master_front_end/model/issue.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:scrum_master_front_end/pages/board/bloc/board_bloc.dart';

class DraggableIssue extends StatefulWidget {
  final Key key;
  final List<Issue> issues;

  DraggableIssue(this.key, this.issues);

  @override
  State<DraggableIssue> createState() => _DraggableIssueState();
}

class _DraggableIssueState extends State<DraggableIssue> {
  List<Issue> todo = [];
  List<Issue> processing = [];
  List<Issue> preRelease = [];
  List<Issue> done = [];
  HtmlEditorController controller = HtmlEditorController();
  late BoardBloc bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (Issue issue in widget.issues) {
      if (issue.status == null || issue.status == 'Todo') {
        todo.add(issue);
      }
      if (issue.status == 'Prerelase') {
        preRelease.add(issue);
      }
      if (issue.status == 'Processing') {
        processing.add(issue);
      }
      if (issue.status == 'Done') {
        done.add(issue);
      }
      bloc = BlocProvider.of<BoardBloc>(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      key: widget.key,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildColumn(todo, 'Todo'),
        _buildColumn(processing, 'Processing'),
        _buildColumn(preRelease, 'Prerelase'),
        _buildColumn(done, 'Done'),
      ],
    );
  }

  Widget _buildColumn(List<Issue> list, String status) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: DragTarget(
        onLeave: (Issue? issue) {
          list.remove(issue);
        },
        builder: (context, a, b) {
          return Container(
              margin: EdgeInsets.only(right: 10),
              color: Colors.grey.withOpacity(0.2),
              width: double.infinity,
              height: widget.issues.length * 180,
              child: list.isNotEmpty
                  ? Column(
                      children: List.generate(list.length, (index) {
                        final item = list[index];
                        return Draggable<Issue>(
                          data: item,
                          child: InkWell(
                              onTap: () {
                                _onTap(item, context);
                              },
                              child: _buildItem(item)),
                          feedback: Material(
                              type: MaterialType.card, child: _buildItem(item)),
                          ignoringFeedbackPointer: true,
                          childWhenDragging: Container(),
                        );
                      }),
                    )
                  : Container());
        },
        onWillAccept: (value) => value != null,
        onAccept: (Issue issue) {
          if (!list.contains(issue)) {
            list.add(issue);
            bloc.add(UpdateIssueStatus(issue.id!, status));
          }
        },
      ),
    );
  }

  Container _buildItem(Issue issue) {
    final item = Container(
      width: 280,
      margin: EdgeInsets.only(top: 10, left: 5, right: 5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(7)),
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  issue.code!,
                  style: TextStyle(color: Colors.black54),
                ),
                SizedBox(
                  height: 7,
                ),
                Text(issue.title!),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/icons/${issue.type}.png",
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
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
                  ],
                ),
              ],
            ),
            issue.assignee != null
                ? Positioned(
                    right: 0,
                    top: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: CachedNetworkImage(
                        height: 30,
                        width: 30,
                        fit: BoxFit.cover,
                        imageUrl: minioHost + issue.assignee!.avatarUrl!,
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
    return item;
  }

  void _onTap(Issue issue, BuildContext context) {
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
      print(event.description);
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
                  BlocBuilder<BoardBloc, BoardState>(
                    bloc: bloc,
                    buildWhen: (previous, current) =>
                        current.status == BoardStatus.assignToMeSuccess,
                    builder: (context, state) {
                      if (state.selectedProject == null) {
                        return Container();
                      }
                      if (state.status == BoardStatus.assignToMeSuccess) {
                        event.assignee = state.selectedProject!.members!
                            .firstWhere((element) => element.id == state.userId)
                            .user;
                      }
                      return Container(
                        width: 300,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(7)),
                        padding: EdgeInsets.only(left: 10, top: 3),
                        child: DropdownSearch<User>(
                          items: state.selectedProject!.members!
                              .map((e) => e.user!)
                              .toList(),
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
                      bloc.add(AssignToMe());
                    },
                    child: Text(
                      'Assign to me',
                      style: TextStyle(color: Colors.blue),
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
                  height: 50,
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
                  BlocBuilder<BoardBloc, BoardState>(
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
                          bloc.add(event);
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    done.clear();
    preRelease.clear();
    processing.clear();
    todo.clear();
  }
}
