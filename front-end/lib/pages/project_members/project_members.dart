import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:scrum_master_front_end/constants/host_api.dart';
import 'package:scrum_master_front_end/constants/theme.dart';
import 'package:scrum_master_front_end/model/project.dart';
import 'package:scrum_master_front_end/model/user.dart';
import 'package:scrum_master_front_end/pages/project_members/bloc/project_member_bloc.dart';
import 'package:scrum_master_front_end/pages/project_members/components/project_member_bar_chart.dart';
import 'package:scrum_master_front_end/widgets/base_screen.dart';
import 'package:scrum_master_front_end/widgets/loading_icon.dart';

class ProjectMembers extends StatelessWidget {
  final Project project;
  User? selectUser;
  String? role;

  ProjectMembers(this.project);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(BlocProvider(
      create: (context) =>
          ProjectMemberBloc()..add(ProjectMemberInitialEvent(context, project)),
      child: (Builder(
        builder: (context) => _buildView(context),
      )),
    ));
  }

  Widget _buildView(BuildContext context) {
    final bloc = BlocProvider.of<ProjectMemberBloc>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            _buildTitle(context),
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
            Row(
              children: [
                Text(
                  'Issue statics',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<ProjectMemberBloc, ProjectMemberState>(
              bloc: bloc,
              builder: (context, state) {
                if (state.statics == null) {
                  return Container();
                }
                return Container(child: ProjectMemberBarChart(state.statics!));
              },
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Text(
                  'Members',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 400,
              child: BlocBuilder<ProjectMemberBloc, ProjectMemberState>(
                bloc: bloc,
                builder: (context, state) {
                  return ListView(
                    padding: const EdgeInsets.all(5),
                    children: List.generate(
                        project.members!.length,
                        (index) => InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(15),
                            child: _buildItem(
                                context: context,
                                user: project.members![index].user!,
                                role: project.members![index].role!))),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildItem(
      {required User user,
      required String role,
      required BuildContext context}) {
    final bloc = BlocProvider.of<ProjectMemberBloc>(context);

    return Container(
      height: 70,
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 7,
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 15,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(35),
            child: CachedNetworkImage(
              height: 50,
              width: 50,
              fit: BoxFit.cover,
              placeholder: (context, url) {
                return Image.asset('assets/images/loading.gif');
              },
              imageUrl: minioHost + user.avatarUrl!,
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: Text(
              user.name!,
              style: TextStyle(fontSize: 14),
            ),
          ),
          const Spacer(),
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: Text(
              user.email,
              style: TextStyle(fontSize: 14),
            ),
          ),
          const Spacer(),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Text(
              role,
              style: TextStyle(fontSize: 14),
            ),
          ),
          const Spacer(),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Text(
              user.isActive == true ? "Activated" : "Disabled",
              style: TextStyle(
                  fontSize: 14,
                  color: user.isActive == true ? Colors.green : Colors.red),
            ),
          ),
          const Spacer(),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              AwesomeDialog(
                  context: context,
                  animType: AnimType.SCALE,
                  dialogType: DialogType.NO_HEADER,
                  width: 500,
                  padding:
                      EdgeInsets.only(top: 40, bottom: 40, left: 40, right: 40),
                  btnOkOnPress: () {
                    bloc.add(RemoveMember(user));
                  },
                  body: SizedBox(
                    height: 50,
                    child: Text(
                      'Are you sure to remove this person?',
                    ),
                  ),
                  btnOkText: 'Confirm',
                  btnCancelOnPress: () {})
                ..show();
            },
            child: const Icon(
              Icons.delete,
              color: Colors.red,
              size: 17,
            ),
          ),
          const SizedBox(
            width: 15,
          )
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    final bloc = BlocProvider.of<ProjectMemberBloc>(context);
    return Row(
      children: [
        Text(
          project.name!,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        Spacer(),
        _buildAddButton(context),
        const SizedBox(
          width: 40,
        ),
        InkWell(
          onTap: () {
            AwesomeDialog(
                context: context,
                animType: AnimType.SCALE,
                dialogType: DialogType.NO_HEADER,
                width: 500,
                padding:
                    EdgeInsets.only(top: 40, bottom: 40, left: 40, right: 40),
                btnOkOnPress: () {
                  bloc.add(RemoveProject(project));
                },
                body: SizedBox(
                  height: 50,
                  child: Text(
                    'Are you sure to delete this project?',
                  ),
                ),
                btnOkText: 'Confirm',
                btnCancelOnPress: () {})
              ..show();
          },
          child: Container(
            height: 40,
            width: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7), color: Colors.red),
            child: Center(
              child: Text('Delete'),
            ),
          ),
        ),
        const SizedBox(
          width: 40,
        ),
      ],
    );
  }

  Widget _buildAddButton(BuildContext context) {
    final bloc = BlocProvider.of<ProjectMemberBloc>(context);
    return BlocBuilder<ProjectMemberBloc, ProjectMemberState>(
      bloc: bloc,
      builder: (context, state) {
        return InkWell(
            onTap: () {
              AwesomeDialog(
                context: context,
                animType: AnimType.TOPSLIDE,
                dialogType: DialogType.NO_HEADER,
                keyboardAware: true,
                aligment: Alignment.topCenter,
                width: 600,
                body: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Add member',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 50,
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
                                    labelText: "Member",
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    contentPadding: EdgeInsets.all(5)),
                              ),
                              onChanged: (value) {
                                selectUser = value;
                              },
                              itemAsString: (item) => item.name!,
                              validator: (value) {
                                if (value == null) {
                                  return "Please select member";
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
                              autoValidateMode: AutovalidateMode.always,
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                            width: 300,
                            height: 80,
                            child: FormBuilderDropdown<String>(
                                name: 'Role',
                                dropdownColor: Colors.white,
                                borderRadius: BorderRadius.circular(7),
                                onChanged: (value) {
                                  role = value;
                                },
                                decoration: InputDecoration(
                                    labelText: 'Role',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    contentPadding: EdgeInsets.all(10)),
                                items: [
                                  DropdownMenuItem(
                                    child: Text("ADMIN"),
                                    value: "ADMIN",
                                  ),
                                  DropdownMenuItem(
                                    child: Text("MAINTAINER"),
                                    value: "MAINTAINER",
                                  ),
                                  DropdownMenuItem(
                                    child: Text("DEVELOPER"),
                                    value: "DEVELOPER",
                                  ),
                                ])),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: state.status == ProjectMemberStatus.loading
                                ? LoadingIcon(height: 40, width: 40)
                                : InkWell(
                                    onTap: () {
                                      if (selectUser != null && role != null) {
                                        bloc.add(AddMember(selectUser!, role!));
                                      }
                                    },
                                    child: inviteButton())),
                      ],
                    ),
                  ),
                ),
              )..show();
            },
            child: inviteButton());
      },
    );
  }

  Widget inviteButton() {
    return Container(
      height: 40,
      width: 80,
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
          Text('Add'),
          Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}
