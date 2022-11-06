import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:scrum_master_front_end/constants/host_api.dart';
import 'package:scrum_master_front_end/model/role.dart';
import 'package:scrum_master_front_end/pages/settings/bloc/setting_bloc.dart';
import 'package:scrum_master_front_end/widgets/loading_icon.dart';

class OrganizationTitle extends StatelessWidget {
  const OrganizationTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SettingBloc>(context);
    return BlocBuilder<SettingBloc, SettingState>(
      bloc: bloc,
      buildWhen: (previous, current) => current.status == SettingStatus.initial,
      builder: (context, state) {
        if (state.organization == null) {
          return CircularProgressIndicator();
        }
        return Row(
          children: [
            CachedNetworkImage(
              height: 60,
              width: 60,
              fit: BoxFit.cover,
              placeholder: (context, url) {
                return CircularProgressIndicator();
              },
              imageUrl: minioHost + state.organization!.logo,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(state.organization!.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),),
            Spacer(),
            _buildInviteButton(context),
            const SizedBox(
              width: 20,
            ),
          ],
        );
      },
    );
  }

  Widget _buildInviteButton(BuildContext context) {
    final bloc = BlocProvider.of<SettingBloc>(context);
    return BlocBuilder<SettingBloc, SettingState>(
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
                          'Invite member',
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
                            onChanged: (value) {
                              state.email = value;
                            },
                            decoration: InputDecoration(
                                labelText: 'Email',
                                floatingLabelBehavior:
                                FloatingLabelBehavior.always,
                                contentPadding: EdgeInsets.all(5)),
                          ),
                        ),
                        Container(
                            width: 300,
                            height: 80,
                            child: FormBuilderDropdown<Role>(
                                name: 'Role',
                                dropdownColor: Colors.white,
                                borderRadius: BorderRadius.circular(7),
                                onChanged: (value) {
                                  state.selectedRole = value;
                                },
                                autofocus: false,
                                decoration: InputDecoration(
                                    labelText: 'Role',
                                    floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                    contentPadding: EdgeInsets.all(5)),
                                items: List.generate(
                                    state.roles!.length,
                                        (index) => DropdownMenuItem(
                                      value: state.roles![index],
                                      child: Text(state.roles![index].code),
                                    )))),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: state.status == SettingStatus.loading
                                ? LoadingIcon(height: 40, width: 40)
                                : InkWell(
                                onTap: () {
                                  bloc.add(InviteMemberEvent());
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
          Text('Invite'),
          Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}
