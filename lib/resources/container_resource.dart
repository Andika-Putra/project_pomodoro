// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'screen_size_resource.dart';

//ContainerDefault contains padding only
class ContainerDefault extends StatelessWidget {
  final Widget child;

  ContainerDefault({
    required this.child,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSize().width,
      height: ScreenSize().heightBody,
      padding: EdgeInsets.only(
        left: ScreenSize().width / 30,
        right: ScreenSize().width / 30,
      ),
      child: child,
    );
  }
}

//ContainerGrandParent ..
class ContainerGrandParent extends StatelessWidget {
  final Widget child;

  ContainerGrandParent({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSize().width,
      height: ScreenSize().heightBody,
      // padding: EdgeInsets.all(
      //   ScreenSize().getWidthOfScreen / 30,
      // ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 0.7,
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10,
            offset: Offset(3, 5),
          ),
        ],
      ),
      child: child,
    );
  }
}

//ContainerParent contains shadow on top looking like a parent of children
class ContainerParent extends StatelessWidget {
  final Widget? child;
  final Color? color;

  ContainerParent({this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSize().width,
      // height: ScreenSize().getHeightOfBody,
      padding: EdgeInsets.all(
        ScreenSize().width / 30,
      ),
      decoration: BoxDecoration(
        color: color ?? Colors.transparent,
      ),
      child: child,
    );
  }
}

//ContainerChild contains a card with shadow around
class ContainerChild extends StatelessWidget {
  final Widget child;

  ContainerChild({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ScreenSize().width / 50),
      width: ScreenSize().width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 0.7,
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 0.5,
            offset: Offset(0.5, 0.5),
          ),
        ],
      ),
      child: child,
    );
  }
}

//ContainerDropdown is like ContainerParent, but less padding for top & bottom
class ContainerDropdown extends StatefulWidget {
  final Widget? child;

  ContainerDropdown({
    this.child,
  });

  @override
  State<ContainerDropdown> createState() => _ContainerDropdownState();
}

class _ContainerDropdownState extends State<ContainerDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSize().width,
      margin: EdgeInsets.only(
        left: ScreenSize().width / 30,
        right: ScreenSize().width / 30,
        top: ScreenSize().width / 80,
        bottom: ScreenSize().width / 80,
      ),
      // padding: EdgeInsets.only(
      //   left: ScreenSize().getWidthOfScreen / 30,
      //   right: ScreenSize().getWidthOfScreen / 30,
      //   top: ScreenSize().getWidthOfScreen / 80,
      //   bottom: ScreenSize().getWidthOfScreen / 80,
      // ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 0.7,
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 0.5,
            offset: Offset(0.5, 0.5),
          ),
        ],
      ),
      child: widget.child,
    );
  }
}

//ContainerGrandChild
class ContainerGrandChild extends StatelessWidget {
  final Widget? child;

  ContainerGrandChild({
    this.child,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ScreenSize().width / 50),
      width: ScreenSize().width / 3.7,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 0.7,
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 0.5,
            offset: Offset(0.5, 0.5),
          ),
        ],
      ),
      child: child,
    );
  }
}

class ContainerStatus extends StatefulWidget {
  final Color? color;
  final Widget? child;

  ContainerStatus({
    this.color,
    this.child,
  });

  @override
  State<ContainerStatus> createState() => _ContainerStatusState();
}

class _ContainerStatusState extends State<ContainerStatus> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSize().heightBody / 30,
      width: ScreenSize().width / 4,
      decoration: BoxDecoration(
          color: widget.color, borderRadius: BorderRadius.circular(4)),
      child: widget.child,
    );
  }
}
