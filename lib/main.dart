// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:project_pomodoro/pages/account/controllers/account_controller.dart';
import 'package:project_pomodoro/pages/account/views/account_home_page.dart';
import 'package:project_pomodoro/pages/account/views/sign_in_page.dart';
import 'package:project_pomodoro/pages/account/views/sign_up_page.dart';
import 'package:project_pomodoro/pages/home/controllers/home_controller.dart';
import 'package:project_pomodoro/pages/home/views/home_page.dart';
import 'package:project_pomodoro/pages/pomodoro/views/pomodoro_guide_page.dart';
import 'package:project_pomodoro/pages/pomodoro/views/pomodoro_home_page.dart';
import 'package:project_pomodoro/pages/splash/views/splash_page.dart';
import 'package:project_pomodoro/pages/target/controllers/target_controller.dart';
import 'package:project_pomodoro/pages/target/views/target_create_page.dart';
import 'package:project_pomodoro/pages/target/views/target_detail_page.dart';
import 'package:project_pomodoro/pages/target/views/target_home_page.dart';
import 'package:project_pomodoro/utilities/shared_prefs_utility.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs().init();
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
          create: (context) => AccountController(),
        ),
        ChangeNotifierProvider(
          create: (context) => TargetController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: SplashPage.routeName,
        routes: {
          SplashPage.routeName: (context) => SplashPage(),
          SignInPage.routeName: (context) => SignInPage(),
          SignUpPage.routeName: (context) => SignUpPage(),
          HomePage.routeName: (context) => HomePage(),
          TargetHomePage.routeName: (context) => TargetHomePage(),
          TargetCreatePage.routeName: (context) => TargetCreatePage(),
          TargetDetailPage.routeName: (context) => TargetDetailPage(),
          AccountHomePage.routeName: (context) => AccountHomePage(),
          PomodoroHomePage.routeName: (context) => PomodoroHomePage(),
          PomodoroGuidePage.routeName: (context) => PomodoroGuidePage(),
        },
      ),
    );
  }
}
