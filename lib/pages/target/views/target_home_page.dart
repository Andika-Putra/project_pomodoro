// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:project_pomodoro/resources/container_resource.dart';
import 'package:project_pomodoro/resources/gap_resource.dart';
import 'package:project_pomodoro/resources/page_resource.dart';
import 'package:project_pomodoro/resources/screen_size_resource.dart';
import 'package:project_pomodoro/resources/text_resource.dart';

import '../../../resources/appbar_resource.dart';
import '../../../resources/color_choice_resource.dart';

class TargetHomePage extends StatelessWidget {
  static const routeName = '/target-home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: AppBarLeading(
          iconColor: ColorChoice().brownPrimary(),
        ),
        title: AppBarTitle(
          title: "Target",
          iconColor: ColorChoice().brownPrimary(),
        ),
      ),
      body: TemplatePage(
        defineType: "isParent",
        colorRefresh: ColorChoice().brownPrimary(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < 10; i++)
              TextButton(
                onPressed: () {},
                child: ContainerChild(
                  child: Column(
                    children: [
                      SimpleText(
                        text: "This is title",
                        size: 16,
                        weight: FontWeight.bold,
                      ),
                      ParentGap(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            color: ColorChoice().brownPrimary(),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: ScreenSize().width / 50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SimpleText(text: "SampleDay, 00 Xyz 0000"),
                                SimpleText(text: "00:00 - 00:00"),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SmallGap(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.notes_rounded,
                            color: ColorChoice().brownPrimary(),
                          ),
                          Expanded(
                            child: Wrap(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: ScreenSize().width / 50),
                                  child: SimpleText(
                                    text:
                                        "This is a sample description. This is another sample description.",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: ColorChoice().brownPrimary(),
        child: Icon(
          Icons.add,
          color: ColorChoice().white(),
        ),
      ),
    );
  }
}
