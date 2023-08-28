// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:project_pomodoro/pages/target/controllers/target_controller.dart';
import 'package:project_pomodoro/pages/target/views/target_create_page.dart';
import 'package:project_pomodoro/pages/target/views/target_detail_page.dart';
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
  static const routeName = '/target/home';

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
          builder: (context, value, child) => value.returnedGetTargetsTrigger ==
                  true
              ? value.returnedGetTargets.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i = 0; i < value.returnedGetTargetsLength; i++)
                          TargetCard(
                            id: value.returnedGetTargets["data"][i]["id"],
                            title: value.returnedGetTargets["data"][i]["title"],
                            date: value.returnedGetTargets["data"][i]
                                ["dateChosen"],
                            timeFrom: value.returnedGetTargets["data"][i]
                                ["timeFrom"],
                            timeTo: value.returnedGetTargets["data"][i]
                                ["timeTo"],
                            description: value.returnedGetTargets["data"][i]
                                ["description"],
                          ),
                      ],
                    )
                  : SizedBox(
                      height: ScreenSize().heightBody / 1.5,
                      width: ScreenSize().width,
                      child: ContainerParent(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: ScreenSize().width / 1.5,
                              width: ScreenSize().width / 1.5,
                              child: Image.asset(
                                "assets/images/target/pmd-notarget.png",
                              ),
                            ),
                            LargeGap(),
                            SimpleText(
                              text: "You are currently have no target yet.",
                            ),
                            SimpleText(
                              text: "Let's add some!",
                            ),
                          ],
                        ),
                      ),
                    )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < 10; i++) const SkeletonTargetList(),
                  ],
                ),
        ),

        // child: Consumer<TargetController>(
        //   builder: (context, value, child) => Column(
        //     children: [
        //       for
        //       SimpleText(text: value.returnedGetTargetsLength.toString()),
        //     ],
        //   ),
        // ),
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
  final int id;
  final String title, date, timeFrom, timeTo, description;

  const TargetCard({
    super.key,
    required this.id,
    required this.title,
    required this.date,
    required this.timeFrom,
    required this.timeTo,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final targetProvider =
        Provider.of<TargetController>(context, listen: false);
    return TextButton(
      onPressed: () {
        // targetProvider.getTargetDetail(id);
        Navigator.of(context)
            .pushNamed(TargetDetailPage.routeName, arguments: {"id": id});
      },
      onLongPress: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: SizedBox(
                height: ScreenSize().heightBody / 20,
                width: ScreenSize().width / 2,
                child: TextButton(
                  onPressed: () async {
                    await targetProvider.deleteTarget(id).then(
                      (_) {
                        Navigator.popUntil(context,
                            ModalRoute.withName(TargetHomePage.routeName));
                        Navigator.of(context)
                            .pushReplacementNamed(TargetHomePage.routeName);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: ColorChoice().brownPrimary(),
                            content: SimpleText(
                              text: "Target has been successfully deleted!",
                              color: ColorChoice().white(),
                              weight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SimpleText(
                        text: "Delete",
                        size: 16,
                        color: ColorChoice().brownPrimary(),
                        weight: FontWeight.bold,
                      ),
                      Icon(
                        Icons.delete_rounded,
                        color: ColorChoice().brownPrimary(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
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
                      SimpleText(text: date),
                      SimpleText(
                        text: "$timeFrom - $timeTo",
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
                          overflow: true,
                          maxLines: true,
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
