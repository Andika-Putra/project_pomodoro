// ignore_for_file: use_key_in_widget_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project_pomodoro/pages/account/views/sign_in_page.dart';
import 'package:project_pomodoro/resources/color_choice_resource.dart';
import 'package:project_pomodoro/resources/screen_size_resource.dart';

import '../../../utilities/shared_prefs_utility.dart';

class SplashPage extends StatefulWidget {
  static const routeName = '/splash';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  startDelay() async {
    String previousToken = SharedPrefs(key: "token").getSharedPrefsValue;
    return Timer(const Duration(milliseconds: 1200), () {
      if (previousToken == "") {
        Navigator.of(context).pushReplacementNamed(SignInPage.routeName);
      } else {
        Navigator.of(context).pushReplacementNamed(SignInPage.routeName);
        // Navigator.of(context).pushReplacementNamed(HomePage.routeName);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: ScreenSize().width,
        height: ScreenSize().heightFullScreen,
        color: ColorChoice().brownTertiary(),
        child: Center(
          child: SizedBox(
            height: ScreenSize().width / 1.5,
            width: ScreenSize().width / 1.5,
            child: Image.asset(
              "assets/images/splash/pmd-splash.png",
            ),
          ),
        ),
      ),
    );
  }
}
