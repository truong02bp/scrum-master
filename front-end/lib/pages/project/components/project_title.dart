import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrum_master_front_end/model/user.dart';
import 'package:scrum_master_front_end/pages/project/bloc/project_bloc.dart';

class ProjectTitle extends StatelessWidget {
  TextEditingController name = TextEditingController();
  TextEditingController projectKey = TextEditingController();
  User? selectedUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Projects',
          style: TextStyle(fontSize: 25),
        ),
        Spacer(),
        _buildCreateButton(context),
        const SizedBox(
          width: 40,
        )
      ],
    );
  }

  Widget _buildCreateButton(BuildContext context) {
    final bloc = BlocProvider.of<ProjectBloc>(context);
    bloc.add(GetListUser());
    return BlocBuilder<ProjectBloc, ProjectState>(
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
                width: 600,
                body: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Create project',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          width: 300,
                          height: 80,
                          child: TextFormField(
                            controller: name,
                            decoration: InputDecoration(
                                labelText: 'Name',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                contentPadding: EdgeInsets.all(5)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 300,
                          height: 80,
                          child: TextFormField(
                            controller: projectKey,
                            decoration: InputDecoration(
                                labelText: 'Project key',
                                floatingLabelBehavior:
                                FloatingLabelBehavior.always,
                                contentPadding: EdgeInsets.all(5)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: 300,
                            height: 50,
                            child: DropdownSearch<User>(
                              items: List.generate(state.users.length, (index) {
                                return state.users[index];
                              }),
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    labelText: "Project Leader",
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    contentPadding: EdgeInsets.all(5)),
                              ),
                              onChanged: (value) {
                                selectedUser = value;
                              },
                              itemAsString: (item) => item.name!,
                              validator: (value) {
                                if (value == null) {
                                  return "Please select project leader";
                                }
                              },
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
                              autoValidateMode:
                                  AutovalidateMode.always,
                            )),
                        const SizedBox(
                          height: 50,
                        ),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                                onTap: () {
                                  if (selectedUser != null) {
                                    Navigator.pop(context);
                                    bloc.add(CreateProjectEvent(
                                        name.text, projectKey.text, selectedUser!));
                                  }
                                },
                                child: createButton())),
                      ],
                    ),
                  ),
                ),
              )..show();
            },
            child: createButton());
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
