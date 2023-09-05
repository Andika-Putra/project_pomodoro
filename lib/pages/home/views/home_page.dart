// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, body_might_complete_normally_nullable, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_pomodoro/pages/account/views/account_home_page.dart';
import 'package:project_pomodoro/pages/home/controllers/home_controller.dart';
import 'package:project_pomodoro/pages/pomodoro/views/pomodoro_home_page.dart';
import 'package:project_pomodoro/pages/target/views/target_create_page.dart';
import 'package:project_pomodoro/pages/target/views/target_home_page.dart';
import 'package:project_pomodoro/resources/appbar_resource.dart';
import 'package:project_pomodoro/resources/color_choice_resource.dart';
import 'package:project_pomodoro/resources/container_resource.dart';
import 'package:project_pomodoro/resources/dropdown_resource.dart';
import 'package:project_pomodoro/resources/font_size_resource.dart';
import 'package:project_pomodoro/resources/gap_resource.dart';
import 'package:project_pomodoro/resources/page_resource.dart';
import 'package:project_pomodoro/resources/skeleton_resourse.dart';
import 'package:project_pomodoro/resources/text_resource.dart';
import 'package:project_pomodoro/utilities/shared_prefs_utility.dart';
import 'package:provider/provider.dart';

import '../../../resources/screen_size_resource.dart';
import '../../target/controllers/target_controller.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool explorePomodoroTrigger = true;

  bool getPomodoroFAQsTrigger = true;
  bool getTargetsTrigger = true;
  bool getOthersFAQsTrigger = true;

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeController>(context, listen: false);
    final targetProvider =
        Provider.of<TargetController>(context, listen: false);
    if (explorePomodoroTrigger == true) {
      Future.delayed(
        const Duration(milliseconds: 1200),
        () {
          setState(() {
            explorePomodoroTrigger = false;
          });
        },
      );
    }

    if (getPomodoroFAQsTrigger == true) {
      homeProvider.getPomodoroFAQs();
      getPomodoroFAQsTrigger = false;
    }

    if (getTargetsTrigger == true) {
      targetProvider
          .getTargets(int.parse(SharedPrefs(key: 'id').getSharedPrefsValue));
      getTargetsTrigger = false;
    }

    if (getOthersFAQsTrigger == true) {
      homeProvider.getOthersFAQs();
      getOthersFAQsTrigger = false;
    }

    // if (getPomodoroFaqsTrigger == true) {
    //   homeProvider.getPomodoroFaqs();
    //   getPomodoroFaqsTrigger = false;
    // }

    // if (getTargetsTrigger == true) {
    //   targetProvider.getTargets();
    //   getTargetsTrigger = false;
    // }

    // if (getOtherFaqsTrigger == true) {
    //   homeProvider.getOtherFaqs();
    //   getOtherFaqsTrigger = false;
    // }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorChoice().greenTertiary(),
        leadingWidth: ScreenSize().width / 2,
        leading: AppBarLeadingHome(title: "Pomodoro"),
        actions: [
          Container(
            margin: EdgeInsets.only(
              right: ScreenSize().width / 20,
            ),
            height: ScreenSize().width / 10,
            width: ScreenSize().width / 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(
                width: 0.7,
                color: Colors.grey,
              ),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AccountHomePage.routeName,
                  arguments: {
                    "id": int.parse(SharedPrefs(key: 'id').getSharedPrefsValue),
                  },
                );
              },
              child: Icon(
                Icons.person,
                color: ColorChoice().greenPrimary(),
              ),
            ),
          ),
        ],
      ),
      body: TemplatePage(
        defineType: "",
        child: Column(
          children: [
            ContainerParent(
              child: explorePomodoroTrigger == false
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SimpleText(
                          text: "Explore Pomodoro",
                          size: 16,
                          color: Colors.black87,
                          weight: FontWeight.bold,
                        ),
                        ParentGap(),
                        Align(
                          alignment: Alignment.center,
                          child: Wrap(
                            spacing: ScreenSize().width / 20,
                            runSpacing: ScreenSize().width / 20,
                            children: [
                              FeatureButton(
                                color: ColorChoice().greenSecondary(),
                                icon: Icons.timer_outlined,
                                title: "Pomodoro",
                                featureName: "Pomodoro",
                              ),
                              FeatureButton(
                                color: ColorChoice().brownPrimary(),
                                icon: Icons.list,
                                title: "Target",
                                featureName: "Target",
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : const SkeletonExplorePomodoro(),
            ),
            SectionGap(),
            ContainerParent(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Consumer<HomeController>(
                      builder: (context, value, child) =>
                          value.returnedGetPomodoroFAQs["data"] != null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Wrap(
                                      children: [
                                        SimpleText(
                                          text:
                                              "Lets achieve your target with Pomodoro Technique!",
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                    MediumGap(),
                                    for (int i = 0;
                                        i < value.returnedGetPomodoroFAQsLength;
                                        i++)
                                      TemplateDropDown(
                                        question: value
                                                .returnedGetPomodoroFAQs["data"]
                                            [i]["question"],
                                        answer: value
                                                .returnedGetPomodoroFAQs["data"]
                                            [i]["answer"],
                                        isExpanded: value
                                            .returnedGetPomodoroFAQsIsExpanded[i],
                                      ),
                                    MediumGap(),
                                    Center(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pushNamed(
                                              PomodoroHomePage.routeName);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              ColorChoice().greenSecondary(),
                                        ),
                                        child: SimpleText(
                                          text:
                                              "Take me to do the pomodoro feature now!",
                                          color: ColorChoice().white(),
                                          weight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : const SkeletonPomodoroFaqs(),
                    ),
                  ),
                ],
              ),
            ),
            SectionGap(),
            ContainerParent(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<TargetController>(
                      builder: (context, value, child) => value
                                  .returnedGetTargets["data"] !=
                              null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SimpleText(
                                  text: "Your available targets",
                                  size: 16,
                                  color: Colors.black87,
                                  weight: FontWeight.bold,
                                ),
                                ParentGap(),
                                targets(value.returnedGetTargetsLength),
                                targetsSeeAll(value.returnedGetTargetsLength),
                              ],
                            )
                          : const SkeletonTodaysTarget()),
                ],
              ),
            ),
            SectionGap(),
            ContainerParent(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Consumer<HomeController>(
                      builder: (context, value, child) =>
                          value.returnedGetOthersFAQs["data"] != null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Wrap(
                                      children: [
                                        SimpleText(
                                          text:
                                              "Or maybe you are currently wondering...",
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                    MediumGap(),
                                    for (int i = 0;
                                        i < value.returnedGetOthersFAQsLength;
                                        i++)
                                      TemplateDropDown(
                                        question:
                                            value.returnedGetOthersFAQs["data"]
                                                [i]["question"],
                                        answer:
                                            value.returnedGetOthersFAQs["data"]
                                                [i]["answer"],
                                        isExpanded: value
                                            .returnedGetOthersFAQsIsExpanded[i],
                                      ),
                                  ],
                                )
                              : const SkeletonOtherFaqs(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget targets(int length) {
    if (length == 0) {
      return Consumer<TargetController>(
        builder: (context, value, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SimpleText(
                text:
                    "Oops, looks like you haven’t add any target today. Let’s add at least one."),
            MediumGap(),
            // const AddTargetCard(),
          ],
        ),
      );
    } else if (length >= 3) {
      return Consumer<TargetController>(
        builder: (context, value, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < 3; i++)
              TargetCard(
                id: value.returnedGetTargets["data"][i]["id"],
                title: value.returnedGetTargets["data"][i]["title"],
                date: value.returnedGetTargets["data"][i]["dateChosen"],
                timeFrom: value.returnedGetTargets["data"][i]["timeFrom"],
                timeTo: value.returnedGetTargets["data"][i]["timeTo"],
                description: value.returnedGetTargets["data"][i]["description"],
              ),
          ],
        ),
      );
    } else {
      return Consumer<TargetController>(
        builder: (context, value, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < value.returnedGetTargetsLength; i++)
              TargetCard(
                id: value.returnedGetTargets["data"][i]["id"],
                title: value.returnedGetTargets["data"][i]["title"],
                date: value.returnedGetTargets["data"][i]["dateChosen"],
                timeFrom: value.returnedGetTargets["data"][i]["timeFrom"],
                timeTo: value.returnedGetTargets["data"][i]["timeTo"],
                description: value.returnedGetTargets["data"][i]["description"],
              ),
            // const AddTargetCard(),
          ],
        ),
      );
    }
  }

  Widget targetsSeeAll(int length) {
    if (length == 0) {
      return SizedBox(
        width: ScreenSize().width,
        child: TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed(TargetHomePage.routeName);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SimpleText(
                text: "Go to Target",
                color: ColorChoice().brownPrimary(),
                weight: FontWeight.bold,
              ),
              Icon(
                Icons.navigate_next_rounded,
                color: ColorChoice().brownPrimary(),
              ),
            ],
          ),
        ),
      );
    }
    // else if (length >= 3) {
    //   return SizedBox(
    //     width: ScreenSize().width,
    //     child: TextButton(
    //       onPressed: () {
    //         Navigator.of(context).pushNamed(TargetHomePage.routeName);
    //       },
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.end,
    //         children: [
    //           SimpleText(
    //             text: "See All",
    //             color: ColorChoice().brownPrimary(),
    //             weight: FontWeight.bold,
    //           ),
    //           Icon(
    //             Icons.navigate_next_rounded,
    //             color: ColorChoice().brownPrimary(),
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // }
    else {
      return SizedBox(
        width: ScreenSize().width,
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(TargetHomePage.routeName);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SimpleText(
                    text: "Go to Target",
                    color: ColorChoice().brownPrimary(),
                    weight: FontWeight.bold,
                  ),
                  Icon(
                    Icons.navigate_next_rounded,
                    color: ColorChoice().brownPrimary(),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: SimpleText(
                text: length >= 3
                    ? "Showing 3 of $length available Target(s)"
                    : "Showing $length of $length available Target(s)",
              ),
            ),
          ],
        ),
      );
    }
  }
}

class SkeletonTodaysTarget extends StatelessWidget {
  const SkeletonTodaysTarget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Bone(
          height: ScreenSize().heightBody / 30,
          width: ScreenSize().width / 2,
        ),
        SmallGap(),
        Bone(
          height: ScreenSize().heightBody / 50,
          width: ScreenSize().width,
        ),
        SmallGap(),
        for (int i = 0; i < 2; i++)
          Padding(
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
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class SkeletonExplorePomodoro extends StatelessWidget {
  const SkeletonExplorePomodoro({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Bone(
          height: ScreenSize().heightBody / 30,
          width: ScreenSize().width / 2,
        ),
        SmallGap(),
        Bone(
          height: ScreenSize().heightBody / 50,
          width: ScreenSize().width,
        ),
        SmallGap(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Bone(
              height: ScreenSize().width / 8,
              width: ScreenSize().width / 8,
            ),
            MediumHorizontalGap(),
            Bone(
              height: ScreenSize().width / 8,
              width: ScreenSize().width / 8,
            ),
          ],
        )
      ],
    );
  }
}

class SkeletonPomodoroFaqs extends StatelessWidget {
  const SkeletonPomodoroFaqs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Bone(
          height: ScreenSize().heightBody / 30,
          width: ScreenSize().width,
        ),
        SmallGap(),
        Center(
          child: Column(
            children: [
              Bone(
                height: ScreenSize().heightBody / 25,
                width: ScreenSize().width / 2,
              ),
              SmallGap(),
              Bone(
                height: ScreenSize().heightBody / 25,
                width: ScreenSize().width / 2,
              ),
              SmallGap(),
              Bone(
                height: ScreenSize().heightBody / 25,
                width: ScreenSize().width / 2,
              ),
              SmallGap(),
            ],
          ),
        ),
        SmallGap(),
      ],
    );
  }
}

class SkeletonOtherFaqs extends StatelessWidget {
  const SkeletonOtherFaqs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Bone(
          height: ScreenSize().heightBody / 30,
          width: ScreenSize().width,
        ),
        SmallGap(),
        Center(
          child: Column(
            children: [
              Bone(
                height: ScreenSize().heightBody / 25,
                width: ScreenSize().width / 2,
              ),
              SmallGap(),
              Bone(
                height: ScreenSize().heightBody / 25,
                width: ScreenSize().width / 2,
              ),
              SmallGap(),
            ],
          ),
        ),
        SmallGap(),
      ],
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
    return TextButton(
      onPressed: () {
        // Navigator.of(context)
        //     .pushNamed(TargetDetailPage.routeName, arguments: {"id": id});
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
                      SimpleText(
                          text: DateFormat('d MMMM y')
                              .format(DateTime.parse(date))),
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

class AddTargetCard extends StatelessWidget {
  const AddTargetCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // targetProvider.getTargetDetail(id);
        Navigator.of(context).pushNamed(TargetCreatePage.routeName);
      },
      child: ContainerChild(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon(
            //   Icons.add,
            //   color: ColorChoice().white(),
            // ),
            Container(
              height: ScreenSize().width / 8,
              width: ScreenSize().width / 8,
              margin: EdgeInsets.only(
                top: ScreenSize().width / 30,
                bottom: ScreenSize().width / 30,
              ),
              decoration: BoxDecoration(
                color: ColorChoice().brownPrimary(),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 30,
              ),
            ),
            MediumHorizontalGap(),
            MediumHorizontalGap(),
            SimpleText(
              text: "Click to add target",
              size: FontSize().adjustFont(16),
              color: ColorChoice().brownPrimary(),
              weight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final String featureName;

  const FeatureButton({
    required this.color,
    required this.icon,
    required this.title,
    required this.featureName,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        validateFeatureNavigation(context, featureName);
      },
      child: Column(
        children: [
          Container(
            height: ScreenSize().width / 8,
            width: ScreenSize().width / 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
          ),
          SmallGap(),
          SimpleText(
            text: title,
            color: Colors.black87,
          ),
        ],
      ),
    );
  }

  Future<void>? validateFeatureNavigation(
      BuildContext context, String featureName) {
    if (featureName == "Pomodoro") {
      return Navigator.of(context).pushNamed(PomodoroHomePage.routeName);
    } else if (featureName == "Target") {
      return Navigator.of(context).pushNamed(TargetHomePage.routeName);
    }
  }
}
