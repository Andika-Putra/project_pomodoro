// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:project_pomodoro/resources/gap_resource.dart';
import 'package:project_pomodoro/resources/page_resource.dart';
import 'package:project_pomodoro/resources/screen_size_resource.dart';
import 'package:project_pomodoro/resources/text_resource.dart';

import '../../../resources/appbar_resource.dart';
import '../../../resources/color_choice_resource.dart';

class PomodoroHomePage extends StatefulWidget {
  static const routeName = '/pomodoro/home';

  @override
  State<PomodoroHomePage> createState() => _PomodoroHomePageState();
}

class _PomodoroHomePageState extends State<PomodoroHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: AppBarLeading(
          iconColor: ColorChoice().greenSecondary(),
        ),
        title: AppBarTitle(
          title: "Pomodoro",
          color: ColorChoice().greenSecondary(),
        ),
      ),
      body: TemplatePage(
        defineType: "",
        child: Column(
          children: [
            Container(
              width: ScreenSize().width,
              height: ScreenSize().heightAppBar,
              color: ColorChoice().greenTertiary(),
              child: TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SimpleText(
                          text: "Don't know how to use this feature?",
                          weight: FontWeight.bold,
                          color: ColorChoice().greenSecondary(),
                        ),
                        SimpleText(
                          text: "Let us help you",
                          weight: FontWeight.bold,
                          color: ColorChoice().greenSecondary(),
                        ),
                      ],
                    ),
                    MediumHorizontalGap(),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: ColorChoice().greenSecondary(),
                    ),
                  ],
                ),
              ),
            ),
            LargeGap(),
            SizedBox(
              height: ScreenSize().width / 1.5,
              width: ScreenSize().width / 1.5,
              child: Image.asset(
                "assets/images/pomodoro/pmd-timer.png",
              ),
            ),
            LargeGap(),
            SimpleText(
              text: "Waiting for you to start the Pomodoro Session...",
              // weight: FontWeight.bold,
              size: 16,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: ScreenSize().heightBody * 0.2,
        width: ScreenSize().width,
        color: ColorChoice().greenTertiary(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Center(
                  child: SimpleText(
                    text: "Click the button below to start Pomodoro Session.",
                  ),
                ),
                Center(
                  child: SimpleText(
                    text: "Remember, your targets are important!",
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorChoice().greenSecondary(),
                ),
                onPressed: () {},
                child: SimpleText(
                  text: "Start Pomodoro Session",
                  size: 16,
                  weight: FontWeight.bold,
                  color: ColorChoice().white(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
