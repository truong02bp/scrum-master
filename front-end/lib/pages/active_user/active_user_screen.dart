import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrum_master_front_end/constants/theme.dart';
import 'package:scrum_master_front_end/pages/active_user/bloc/active_bloc.dart';

class ActiveUserScreen extends StatelessWidget {
  static final String routeName = "/active-user";

  @override
  Widget build(BuildContext context) {
    String myurl = Uri.base.toString();
    print(myurl);
    String? para1 = Uri.base.queryParameters["email"];
    print(para1);
    return Scaffold(
      body: SafeArea(
          child: BlocProvider(
            create: (context) => ActiveBloc(),
            child: Builder(builder: (context) => _buildView(context),),
          )
      ),
    );
  }

  Widget _buildView(BuildContext context) {
    final bloc = BlocProvider.of<ActiveBloc>(context);
    return BlocBuilder<ActiveBloc, ActiveState>(
      bloc: bloc,
      builder: (context, state) {
        return Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: 300,
                  height: 80,
                  child: TextFormField(
                      onChanged: (value) {
                        state.name = value;
                      },
                      decoration: InputDecoration(
                        focusedBorder: outlineInputBorder,
                        enabledBorder: outlineInputBorder,
                        errorBorder: outlineInputBorder,
                        disabledBorder: outlineInputBorder,
                        prefixIcon: Icon(
                          Icons.account_circle,
                          size: 16,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            bloc.add(ShowPasswordEvent());
                          },
                          child: Icon(
                            Icons.remove_red_eye_outlined,
                            size: 16,
                            color: state.showPassword ? Colors.blue : Colors
                                .grey,
                          ),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: 'Name',
                        contentPadding: EdgeInsets.only(
                            left: 20, top: 15, bottom: 5),
                        labelStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ))
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                  width: 300,
                  height: 80,
                  child: TextFormField(
                      obscureText: !state.showPassword,
                      onChanged: (value) {
                        state.password = value;
                      },
                      decoration: InputDecoration(
                        focusedBorder: outlineInputBorder,
                        enabledBorder: outlineInputBorder,
                        errorBorder: outlineInputBorder,
                        disabledBorder: outlineInputBorder,
                        prefixIcon: Icon(
                          Icons.lock,
                          size: 16,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            bloc.add(ShowPasswordEvent());
                          },
                          child: Icon(
                            Icons.remove_red_eye_outlined,
                            size: 16,
                            color: state.showPassword ? Colors.blue : Colors
                                .grey,
                          ),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: 'Password',
                        contentPadding: EdgeInsets.only(
                            left: 20, top: 15, bottom: 5),
                        labelStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ))
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                  width: 300,
                  height: 80,
                  child: TextFormField(
                      obscureText: !state.showPassword,
                      onChanged: (value) {
                        state.confirmPassword = value;
                      },
                      decoration: InputDecoration(
                        focusedBorder: outlineInputBorder,
                        enabledBorder: outlineInputBorder,
                        errorBorder: outlineInputBorder,
                        disabledBorder: outlineInputBorder,
                        prefixIcon: Icon(
                          Icons.lock,
                          size: 16,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            bloc.add(ShowPasswordEvent());
                          },
                          child: Icon(
                            Icons.remove_red_eye_outlined,
                            size: 16,
                            color: state.showPassword ? Colors.blue : Colors
                                .grey,
                          ),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: 'Confirm password',
                        contentPadding: EdgeInsets.only(
                            left: 20, top: 15, bottom: 5),
                        labelStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ))
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 40,
                width: 90,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(7)),
                child: Center(child: Text('Active')),
              ),
            ],
          ),
        );
      },
    );
  }
}
