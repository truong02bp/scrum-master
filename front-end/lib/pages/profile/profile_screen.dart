import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:scrum_master_front_end/constants/host_api.dart';
import 'package:scrum_master_front_end/model/user.dart';
import 'package:scrum_master_front_end/pages/profile/bloc/profile_bloc.dart';
import 'package:scrum_master_front_end/widgets/base_screen.dart';

import '../../constants/theme.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = "/profile";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Uint8List? bytes;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(BlocProvider(
        create: (context) => ProfileBloc()..add(ProfileInitialEvent(context)),
        child: Builder(
          builder: (context) => _buildView(context),
        )));
  }

  Widget _buildView(BuildContext context) {
    final bloc = BlocProvider.of<ProfileBloc>(context);
    return Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Text(
                  'Profile',
                  style: TextStyle(fontSize: 25),
                ),
                Spacer(),
                BlocBuilder<ProfileBloc, ProfileState>(
                  bloc: bloc,
                  builder: (context, state) {
                    if (state.user == null) {
                      return Container();
                    }
                    return InkWell(
                      onTap: () {
                        String oldPassword = "";
                        String newPassword = "";
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.SCALE,
                          dialogType: DialogType.NO_HEADER,
                          keyboardAware: true,
                          width: 600,
                          btnOkOnPress: () {
                            if (oldPassword.isNotEmpty &&
                                newPassword.isNotEmpty) {
                              bloc.add(ProfileUpdatePassword(
                                  userId: state.user!.id,
                                  oldPassword: oldPassword,
                                  newPassword: newPassword));
                            }
                          },
                          body: Padding(
                            padding: const EdgeInsets.only(
                                top: 10, right: 30, left: 30),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Change password',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  onChanged: (value) {
                                    oldPassword = value;
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      labelText: 'Old password',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  onChanged: (value) {
                                    newPassword = value;
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      labelText: 'New password',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        )..show();
                      },
                      child: Text(
                        'Change password ?',
                        style: TextStyle(color: Colors.blue),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 30,)
              ],
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
            BlocBuilder<ProfileBloc, ProfileState>(
              bloc: bloc,
              builder: (context, state) {
                User? user = state.user;
                if (user == null) {
                  return Container();
                }
                return Padding(
                  padding:
                      const EdgeInsets.only(top: 10, left: 350, right: 350),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          setState(() async {
                            bytes = await ImagePickerWeb.getImageAsBytes();
                            bloc.add(SelectImage());
                          });
                        },
                        borderRadius: BorderRadius.circular(100),
                        child: ClipRRect(
                          key: UniqueKey(),
                          borderRadius: BorderRadius.circular(100),
                          child: bytes == null
                              ? CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  height: 200,
                                  width: 200,
                                  placeholder: (context, url) {
                                    return CircularProgressIndicator();
                                  },
                                  imageUrl: minioHost + state.user!.avatarUrl!,
                                )
                              : Image.memory(
                                  bytes!,
                                  height: 200,
                                  width: 200,
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      TextFormField(
                        readOnly: true,
                        initialValue: "${user.email}",
                        decoration: InputDecoration(
                          focusedBorder: outlineInputBorder,
                          enabledBorder: outlineInputBorder,
                          errorBorder: outlineInputBorder,
                          disabledBorder: outlineInputBorder,
                          prefixIcon: Icon(
                            Icons.mail_outline,
                            size: 16,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: 'Email',
                          labelText: 'Email',
                          contentPadding:
                              EdgeInsets.only(left: 20, top: 15, bottom: 5),
                          labelStyle: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          user.name = value;
                        },
                        initialValue: "${user.name}",
                        decoration: InputDecoration(
                          focusedBorder: outlineInputBorder,
                          enabledBorder: outlineInputBorder,
                          errorBorder: outlineInputBorder,
                          disabledBorder: outlineInputBorder,
                          prefixIcon: Icon(
                            Icons.person,
                            size: 16,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: 'Name',
                          labelText: 'Name',
                          contentPadding:
                              EdgeInsets.only(left: 20, top: 15, bottom: 5),
                          labelStyle: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          user.phone = value;
                        },
                        initialValue: "${user.phone}",
                        decoration: InputDecoration(
                          focusedBorder: outlineInputBorder,
                          enabledBorder: outlineInputBorder,
                          errorBorder: outlineInputBorder,
                          disabledBorder: outlineInputBorder,
                          prefixIcon: Icon(
                            Icons.mail_outline,
                            size: 16,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: 'Phone',
                          labelText: 'Phone',
                          contentPadding:
                              EdgeInsets.only(left: 20, top: 15, bottom: 5),
                          labelStyle: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          user.address = value;
                        },
                        initialValue: "${user.address}",
                        decoration: InputDecoration(
                          focusedBorder: outlineInputBorder,
                          enabledBorder: outlineInputBorder,
                          errorBorder: outlineInputBorder,
                          disabledBorder: outlineInputBorder,
                          prefixIcon: Icon(
                            Icons.mail_outline,
                            size: 16,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: 'Address',
                          labelText: 'Address',
                          contentPadding:
                              EdgeInsets.only(left: 20, top: 15, bottom: 5),
                          labelStyle: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        readOnly: true,
                        initialValue: "${user.organization.name}",
                        decoration: InputDecoration(
                          focusedBorder: outlineInputBorder,
                          enabledBorder: outlineInputBorder,
                          errorBorder: outlineInputBorder,
                          disabledBorder: outlineInputBorder,
                          prefixIcon: Icon(
                            Icons.mail_outline,
                            size: 16,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: 'Organization',
                          labelText: 'Organization',
                          contentPadding:
                              EdgeInsets.only(left: 20, top: 15, bottom: 5),
                          labelStyle: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          bloc.add(UpdateUser(bytes));
                        },
                        child: Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.deepOrangeAccent.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text('Update'),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ]),
        ));
  }
}
