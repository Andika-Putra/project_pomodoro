// ignore_for_file: use_key_in_widget_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:project_pomodoro/resources/color_choice_resource.dart';
import 'package:project_pomodoro/resources/container_resource.dart';
import 'package:project_pomodoro/resources/screen_size_resource.dart';

class TemplatePage extends StatefulWidget {
  final String defineType;
  final Color? colorRefresh;
  final Widget child;
  final Object? arguments;

  const TemplatePage({
    required this.defineType,
    this.colorRefresh,
    required this.child,
    this.arguments,
  });

  @override
  State<TemplatePage> createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: widget.colorRefresh ?? ColorChoice().greenPrimary(),
      child: Scrollbar(
        thickness: 5,
        radius: const Radius.circular(10),
        thumbVisibility: false,
        child: defineType(widget.defineType),
      ),
      onRefresh: () {
        return Future.delayed(
          const Duration(seconds: 2),
          () {
            // print("Refresh Succeed");
            Navigator.of(context).pushReplacementNamed(
                ModalRoute.of(context)!.settings.name.toString(),
                arguments: widget.arguments);
          },
        );
      },
    );
  }

  Widget defineType(String defineType) {
    if (defineType == "isParent") {
      return ContainerDefault(
        child: typeContent(),
      );
    } else if (defineType == "isChild") {
      return ContainerGrandParent(
        child: typeContent(),
      );
    } else {
      return Container(
        height: ScreenSize().heightBody,
        width: ScreenSize().width,
        child: typeContent(),
      );
    }
  }

  Widget typeContent() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: widget.child,
    );
  }
}
