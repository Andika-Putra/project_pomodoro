// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:project_pomodoro/resources/color_choice_resource.dart';

import 'screen_size_resource.dart';

class Loading {
  List<Color> defaultRainbowColors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];

  List<Color> greenColors = [
    ColorChoice().greenPrimary(),
    ColorChoice().greenSecondary(),
    ColorChoice().greenTertiary(),
  ];

  Widget indicatorBallPulseSyncOnly() {
    return Container(
      width: ScreenSize().width / 5,
      child: LoadingIndicator(
        indicatorType: Indicator.ballPulseSync,
        colors: defaultRainbowColors,
        strokeWidth: 4.0,
        pathBackgroundColor: Colors.black45,
      ),
    );
  }

  Widget indicatorCircleStrokeSpinOnly() {
    return Center(
      child: Container(
        // width: ScreenSize().width / 10,
        height: ScreenSize().width / 10,
        child: LoadingIndicator(
          indicatorType: Indicator.circleStrokeSpin,
          colors: greenColors,
          strokeWidth: 3.2,
          pathBackgroundColor: Colors.black45,
        ),
      ),
    );
  }
}
