import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrum_master_front_end/constants/theme.dart';
import 'package:scrum_master_front_end/pages/active_user/active_user_screen.dart';
import 'package:scrum_master_front_end/pages/home/home_screen.dart';
import 'package:scrum_master_front_end/pages/login/login_screen.dart';
import 'package:scrum_master_front_end/routers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.black),
        canvasColor: secondaryColor,
      ),
      home: LoginScreen(),
      routes: routes,
    );
  }
}
