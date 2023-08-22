// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'screen_size_resource.dart';

class SmallGap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenSize().heightBody / 100,
    );
  }
}

class MediumGap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenSize().heightBody / 50,
    );
  }
}

class LargeGap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSize().heightBody / 15,
    );
  }
}

class SmallHorizontalGap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenSize().width / 100,
    );
  }
}

class MediumHorizontalGap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenSize().width / 50,
    );
  }
}

class LineGap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ChildGap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MediumGap(),
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
          ),
        ),
        MediumGap(),
      ],
    );
  }
}

class ParentGap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MediumGap(),
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
          ),
        ),
        MediumGap(),
      ],
    );
  }
}

class SectionGap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSize().heightBody / 100,
      color: Color.fromARGB(
        20,
        0,
        0,
        0,
      ),
    );
  }
}
