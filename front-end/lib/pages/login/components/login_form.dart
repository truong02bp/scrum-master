import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrum_master_front_end/constants/theme.dart';
import 'package:scrum_master_front_end/pages/dash_board/dash_board_screen.dart';
import 'package:scrum_master_front_end/pages/home/home_screen.dart';
import 'package:scrum_master_front_end/pages/issues/issue_screen.dart';
import 'package:scrum_master_front_end/pages/login/bloc/login_bloc.dart';

class LoginForm extends StatelessWidget {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<LoginBloc>(context);
    _email.text = "truong02.bp@gmail.com";
    _password.text = "123456";
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.loginSuccess) {
          Navigator.pushNamed(context, IssueScreen.routeName);
        }
      },
      bloc: bloc,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Login',
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text('Please sign in to continue',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
              )),
          const SizedBox(
            height: 70,
          ),
          Container(
            width: 350,
            child: TextFormField(
              controller: _email,
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
                contentPadding: EdgeInsets.only(left: 20, top: 15, bottom: 5),
                labelStyle:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 350,
            child: BlocBuilder<LoginBloc, LoginState>(
              bloc: bloc,
              buildWhen: (previous, current) =>
                  current.status == LoginStatus.showPassword,
              builder: (context, state) {
                return TextFormField(
                    obscureText: !state.showPassword,
                    controller: _password,
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
                          color: state.showPassword ? Colors.blue : Colors.grey,
                        ),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: 'Password',
                      contentPadding:
                          EdgeInsets.only(left: 20, top: 15, bottom: 5),
                      labelStyle: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ));
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
              'Not a member? To request an account,\n please contact your administrators'),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  bloc.add(LoginSubmitEvent(_email.text, _password.text));
                },
                child: Container(
                  height: 50,
                  width: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.red),
                  child: Center(
                      child: const Text(
                    'Login',
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                  )),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          InkWell(
              onTap: () {},
              child: const Text(
                'Can\'t access your account ?',
                style: TextStyle(color: Colors.blue),
              ))
        ],
      ),
    );
  }
}
