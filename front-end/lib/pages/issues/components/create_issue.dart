import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:scrum_master_front_end/model/issue.dart';
import 'package:scrum_master_front_end/model/project.dart';
import 'package:scrum_master_front_end/model/sprint.dart';
import 'package:scrum_master_front_end/model/user.dart';
import 'package:scrum_master_front_end/pages/issues/bloc/issue_bloc.dart';

class CreateIssue extends StatefulWidget {
  @override
  State<CreateIssue> createState() => _CreateIssueState();
}

class _CreateIssueState extends State<CreateIssue> {
  HtmlEditorController controller = HtmlEditorController();
  CreateIssueEvent event = CreateIssueEvent();

  @override
  Widget build(BuildContext context) {
    return _buildButton(context);
  }

  Widget _buildButton(BuildContext context) {
    final bloc = BlocProvider.of<IssueBloc>(context);
    return BlocBuilder<IssueBloc, IssueState>(
      bloc: bloc,
      builder: (context, state) {
        final project = state.selectedProject;
        if (project == null) {
          return Container();
        }
        event.project = project;
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
                  padding: const EdgeInsets.only(left: 50, top: 10, right: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Create issue',
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
                                child: DropdownSearch<Project>(
                                  items: state.projects!,
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(5)),
                                  ),
                                  onChanged: (value) {
                                    event.project = value;
                                  },
                                  itemAsString: (item) => item.name!,
                                  selectedItem: state.selectedProject,
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
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(5)),
                              ),
                              onChanged: (value) {
                                event.type = value;
                              },
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
                              onChanged: (value) {
                                event.title = value;
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
                              onChanged: (value) {
                                event.estimate = int.parse(value);
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
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(5)),
                              ),
                              onChanged: (value) {
                                event.label = value;
                              },
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
                                'Description',
                                style: TextStyle(fontSize: 16),
                              )),
                          SizedBox(
                            width: 30,
                          ),
                          Container(
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
                                    adjustHeightForKeyboard: true),
                                htmlToolbarOptions: HtmlToolbarOptions(
                                  dropdownBackgroundColor: Colors.white,
                                  dropdownBoxDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                otherOptions: OtherOptions(
                                  height: 300,
                                ),
                              )),
                        ]),
                        const SizedBox(
                          height: 20,
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
                          BlocBuilder<IssueBloc, IssueState>(
                            bloc: bloc,
                            buildWhen: (previous, current) =>
                                current.status == IssueStatus.assignToMeSuccess,
                            builder: (context, state) {
                              if (state.status ==
                                  IssueStatus.assignToMeSuccess) {
                                event.assignee = project.members!
                                    .firstWhere(
                                        (element) => element.id == state.userId)
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
                                  items: project.members!
                                      .map((e) => e.user!)
                                      .toList(),
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
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
                                  selectedItem: event.assignee,
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
                          height: 20,
                        ),
                        Row(children: [
                          SizedBox(
                              width: 100,
                              child: Text(
                                'Sprint',
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
                            child: DropdownSearch<Sprint>(
                              items: state.sprints!,
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(5),
                                ),
                              ),
                              onChanged: (value) {
                                event.sprint = value;
                              },
                              itemAsString: (item) => item.name!,
                              filterFn: (sprint, filter) {
                                return sprint.name!.contains(filter);
                              },
                              popupProps: PopupProps.menu(
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    contentPadding: EdgeInsets.all(5),
                                  ),
                                ),
                              ),
                              autoValidateMode: AutovalidateMode.always,
                            ),
                          )
                        ]),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                                onTap: () async {
                                  event.description =
                                      await controller.getText();
                                  bloc.add(event);
                                  Navigator.pop(context);
                                },
                                child: createButton())),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )..show();
          },
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 40,
            width: 120,
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(7)
            ),
            child: Center(child: Text('+ Create issue')),
          ),
        );
      },
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
