// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';

import 'container_resource.dart';
import 'text_resource.dart';

class TemplateDropDown extends StatefulWidget {
  final String question;
  final String answer;
  bool isExpanded;
  TemplateDropDown({
    required this.question,
    required this.answer,
    required this.isExpanded,
  });

  @override
  State<TemplateDropDown> createState() => _TemplateDropDownState();
}

class _TemplateDropDownState extends State<TemplateDropDown> {
  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          widget.isExpanded = !isExpanded;
        });
      },
      children: [
        ExpansionPanel(
          isExpanded: widget.isExpanded,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: SimpleText(
                text: widget.question,
                color: Colors.black,
                weight: FontWeight.bold,
              ),
            );
          },
          body: Column(
            children: [
              Wrap(
                children: [
                  ContainerParent(
                    child: SimpleText(
                      text: widget.answer,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
