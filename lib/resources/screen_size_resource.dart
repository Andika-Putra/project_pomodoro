// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class ScreenSize {
  final double _heightFullScreen =
      MediaQueryData.fromView(WidgetsBinding.instance.window)
          .size
          .height
          .toDouble();
  final double _widthFullScreen =
      MediaQueryData.fromView(WidgetsBinding.instance.window)
          .size
          .width
          .toDouble();
  final double _heightNavigationBar =
      MediaQueryData.fromView(WidgetsBinding.instance.window)
          .padding
          .top
          .toDouble();
  final double _heightAppBar = AppBar().preferredSize.height;

  double get heightFullScreen => _heightFullScreen;
  double get width => _widthFullScreen;
  double get heightAppBar => _heightAppBar;
  double get heightBody =>
      _heightFullScreen - _heightNavigationBar - _heightAppBar;
}
