import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrum_master_front_end/pages/login/bloc/login_bloc.dart';
import 'package:scrum_master_front_end/pages/login/components/login_form.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "/login";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc()..add(LoginInitialEvent()),
      child: Builder(
        builder: (context) => _buildView(context),
      ),
    );
  }

  Widget _buildView(BuildContext context) {
    return Scaffold(
        body: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
            flex: 7,
            fit: FlexFit.tight,
            child: Container(
              padding: EdgeInsets.only(bottom: 150),
              child: Image.asset("assets/images/scrum_3-removebg.png"),
            )),
        Flexible(
            flex: 5,
            fit: FlexFit.tight,
            child: Container(
              child: LoginForm(),
            )),
      ],
    ));
  }
}
