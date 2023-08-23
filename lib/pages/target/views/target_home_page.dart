// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_pomodoro/configurations/api.dart';
import 'package:project_pomodoro/pages/target/controllers/target_controller.dart';
import 'package:project_pomodoro/pages/target/views/target_create_page.dart';
import 'package:project_pomodoro/resources/container_resource.dart';
import 'package:project_pomodoro/resources/gap_resource.dart';
import 'package:project_pomodoro/resources/page_resource.dart';
import 'package:project_pomodoro/resources/screen_size_resource.dart';
import 'package:project_pomodoro/resources/skeleton_resourse.dart';
import 'package:project_pomodoro/resources/text_resource.dart';
import 'package:provider/provider.dart';

import '../../../resources/appbar_resource.dart';
import '../../../resources/color_choice_resource.dart';

class TargetHomePage extends StatelessWidget {
  static const routeName = '/target-home';

  bool getTargetsTrigger = true;

  @override
  Widget build(BuildContext context) {
    final targetProvider =
        Provider.of<TargetController>(context, listen: false);
    if (getTargetsTrigger == true) {
      targetProvider.getTargets();
      getTargetsTrigger = false;
    }

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
        child: Consumer<TargetController>(
          builder: (context, value, child) =>
              value.returnedGetTargets["data"] != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i = 0; i < value.returnedGetTargetsLength; i++)
                          TargetCard(
                            title: value.returnedGetTargets["data"][i]["title"],
                            dateTimeFrom: value.returnedGetTargets["data"][i]
                                ["dateTimeFrom"],
                            dateTimeTo: value.returnedGetTargets["data"][i]
                                ["dateTimeTo"],
                            description: value.returnedGetTargets["data"][i]
                                ["description"],
                          ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i = 0; i < 3; i++) const SkeletonTargetList(),
                      ],
                    ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(TargetCreatePage.routeName);
        },
        backgroundColor: ColorChoice().brownPrimary(),
        child: Icon(
          Icons.add,
          color: ColorChoice().white(),
        ),
      ),
    );
  }
}

class SkeletonTargetList extends StatelessWidget {
  const SkeletonTargetList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ScreenSize().width / 50),
      child: ContainerChild(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Bone(
                height: ScreenSize().heightBody / 30,
                width: ScreenSize().width / 2,
              ),
            ),
            SmallGap(),
            Bone(
              height: ScreenSize().heightBody / 50,
              width: ScreenSize().width,
            ),
            SmallGap(),
            Bone(
              height: ScreenSize().heightBody / 30,
              width: ScreenSize().width / 2,
            ),
            SmallGap(),
            Bone(
              height: ScreenSize().heightBody / 30,
              width: ScreenSize().width / 2,
            ),
            SmallGap(),
          ],
        ),
      ),
    );
  }
}

class TargetCard extends StatelessWidget {
  final String title, dateTimeFrom, dateTimeTo, description;

  const TargetCard({
    super.key,
    required this.title,
    required this.dateTimeFrom,
    required this.dateTimeTo,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: ContainerChild(
        child: Column(
          children: [
            SimpleText(
              text: title,
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
                  padding: EdgeInsets.only(left: ScreenSize().width / 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SimpleText(
                        text: DateFormat('EEEE, d MMM y')
                            .format(DateTime.parse(dateTimeFrom)),
                      ),
                      SimpleText(
                        text:
                            "${DateFormat('Hm').format(DateTime.parse(dateTimeFrom))} - ${DateFormat('Hm').format(DateTime.parse(dateTimeTo))}",
                      ),
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
                        padding: EdgeInsets.only(left: ScreenSize().width / 50),
                        child: SimpleText(
                          text: description,
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
    );
  }
}
