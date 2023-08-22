import 'package:flutter/material.dart';

class ColorChoice {
  final List<Color> greenSelection = [
    const Color(0xFF285430),
    const Color(0xFF5F8D4E),
    const Color(0xFFEDF1D6),
  ];

  final List<Color> brownSelection = [
    const Color(0xFFCC7351),
    const Color(0xFFF1DFD6),
  ];

  Color greenPrimary() {
    return greenSelection[0];
  }

  Color greenSecondary() {
    return greenSelection[1];
  }

  Color greenTertiary() {
    return greenSelection[2];
  }

  Color brownPrimary() {
    return brownSelection[0];
  }

  Color brownSecondary() {
    return brownSelection[1];
  }

  Color white() {
    return Colors.white;
  }
}
