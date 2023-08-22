// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:project_pomodoro/pages/home/controllers/home_controller.dart';
import 'package:project_pomodoro/pages/target/views/target_home_page.dart';
import 'package:project_pomodoro/resources/appbar_resource.dart';
import 'package:project_pomodoro/resources/color_choice_resource.dart';
import 'package:project_pomodoro/resources/container_resource.dart';
import 'package:project_pomodoro/resources/dropdown_resource.dart';
import 'package:project_pomodoro/resources/gap_resource.dart';
import 'package:project_pomodoro/resources/page_resource.dart';
import 'package:project_pomodoro/resources/skeleton_resourse.dart';
import 'package:project_pomodoro/resources/text_resource.dart';
import 'package:provider/provider.dart';

import '../../../resources/screen_size_resource.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool explorePomodoroTrigger = true;

  bool getPomodoroFaqsTrigger = true;

  bool getOtherFaqsTrigger = true;

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeController>(context, listen: false);
    if (explorePomodoroTrigger == true) {
      Future.delayed(
        const Duration(seconds: 2),
        () {
          setState(() {
            explorePomodoroTrigger = false;
          });
        },
      );
    }

    if (getPomodoroFaqsTrigger == true) {
      homeProvider.getPomodoroFaqs();
      getPomodoroFaqsTrigger = false;
    }

    if (getOtherFaqsTrigger == true) {
      homeProvider.getOtherFaqs();
      getOtherFaqsTrigger = false;
    }

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
              onPressed: () {},
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
                          value.returnedGetPomodoroFaqs["data"] != null
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
                                        i < value.returnedGetPomodoroFaqsLength;
                                        i++)
                                      TemplateDropDown(
                                        question: value
                                                .returnedGetPomodoroFaqs["data"]
                                            [i]["question"],
                                        answer: value
                                                .returnedGetPomodoroFaqs["data"]
                                            [i]["answer"],
                                        isExpanded: value
                                            .returnedGetPomodoroFaqsIsExpanded[i],
                                      ),
                                    MediumGap(),
                                    Center(
                                      child: ElevatedButton(
                                        onPressed: () {},
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
                  Align(
                    alignment: Alignment.center,
                    child: Consumer<HomeController>(
                      builder: (context, value, child) =>
                          value.returnedGetPomodoroFaqs["data"] != null
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
                                        i < value.returnedGetOtherFaqsLength;
                                        i++)
                                      TemplateDropDown(
                                        question:
                                            value.returnedGetOtherFaqs["data"]
                                                [i]["question"],
                                        answer:
                                            value.returnedGetOtherFaqs["data"]
                                                [i]["answer"],
                                        isExpanded: value
                                            .returnedGetOtherFaqsIsExpanded[i],
                                      ),
                                  ],
                                )
                              : const SkeletonOtherFaqs(),
                    ),
                  ),
                ],
              ),
            ),
            SectionGap(),
          ],
        ),
      ),
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
    } else if (featureName == "Target") {
      return Navigator.of(context).pushNamed(TargetHomePage.routeName);
    }
  }
}
