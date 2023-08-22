// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:project_pomodoro/resources/color_choice_resource.dart';
import 'package:project_pomodoro/resources/font_size_resource.dart';

import 'screen_size_resource.dart';
import 'text_resource.dart';

class AppBarLeadingHome extends StatelessWidget {
  final String title;

  AppBarLeadingHome({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: ScreenSize().width / 20,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: SimpleText(
          text: title,
          size: FontSize().adjustFont(28),
          family: "Satisfy",
          color: ColorChoice().greenPrimary(),
          weight: FontWeight.bold,
        ),
      ),
    );
  }
}

/**
 * *Put on AppBar-leading
 */
class AppBarLeading extends StatelessWidget {
  final Color iconColor;

  AppBarLeading({
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Container(
        color: Colors.transparent,
        child: TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}

/**
 * *Put on AppBar-title
 */
class AppBarTitle extends StatelessWidget {
  final String title;
  final Color iconColor;

  AppBarTitle({
    required this.title,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleText(
      text: title,
      size: 20,
      color: iconColor,
    );
  }
}
