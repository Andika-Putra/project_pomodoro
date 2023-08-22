// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

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
  Center indicatorBallPulseSyncOnly() {
    return Center(
      child: Container(
        width: ScreenSize().width / 5,
        child: LoadingIndicator(
          indicatorType: Indicator.ballPulseSync,
          colors: defaultRainbowColors,
          strokeWidth: 4.0,
          pathBackgroundColor: Colors.black45,
        ),
      ),
    );
  }
}
