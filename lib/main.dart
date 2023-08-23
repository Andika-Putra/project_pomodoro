// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:project_pomodoro/pages/home/controllers/home_controller.dart';
import 'package:project_pomodoro/pages/home/views/home_page.dart';
import 'package:project_pomodoro/pages/target/controllers/target_controller.dart';
import 'package:project_pomodoro/pages/target/views/target_create_page.dart';
import 'package:project_pomodoro/pages/target/views/target_home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeController(),
        ),
        ChangeNotifierProvider(
          create: (context) => TargetController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (context) => HomePage(),
          TargetHomePage.routeName: (context) => TargetHomePage(),
          TargetCreatePage.routeName: (context) => TargetCreatePage(),
        },
      ),
    );
  }
}
