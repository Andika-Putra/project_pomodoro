// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:project_pomodoro/resources/container_resource.dart';
import 'package:project_pomodoro/resources/gap_resource.dart';
import 'package:project_pomodoro/resources/page_resource.dart';
import 'package:project_pomodoro/resources/text_resource.dart';

import '../../../resources/appbar_resource.dart';
import '../../../resources/color_choice_resource.dart';
import '../../../resources/screen_size_resource.dart';

class PomodoroGuidePage extends StatelessWidget {
  static const routeName = '/pomodoro/guide';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: AppBarLeading(
          iconColor: ColorChoice().greenSecondary(),
        ),
        title: AppBarTitle(
          title: "Pomodoro Guide",
          color: ColorChoice().greenSecondary(),
        ),
      ),
      body: TemplatePage(
        defineType: "",
        child: Column(
          children: [
            ContainerParent(
              color: ColorChoice().greenTertiary(),
              child: Column(
                children: [
                  SimpleText(
                    text:
                        "Click the “Play Session” button to start your 25+5 minutes session",
                  ),
                  MediumGap(),
                  ContainerChild(
                    child: SizedBox(
                      height: ScreenSize().width / 10,
                      child: Image.asset(
                        "assets/images/pomodoro/pmd-guide-buttonplaysession.png",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ContainerParent(
              child: Column(
                children: [
                  SimpleText(
                    text:
                        "Activity session will be started and timer will be automatically shown as follows",
                  ),
                  MediumGap(),
                  ContainerChild(
                    child: SizedBox(
                      height: ScreenSize().width / 1.5,
                      child: Image.asset(
                        "assets/images/pomodoro/pmd-guide-activitysession.png",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ContainerParent(
              color: ColorChoice().greenTertiary(),
              child: Column(
                children: [
                  SimpleText(
                    text:
                        "While in activity session, you can see your added targets so you can keep track on what you want to do in each session.",
                  ),
                  SmallGap(),
                  SimpleText(
                    text:
                        "In addition, we added “Stop/Pause Session” in case you can’t finish the session for a few reasons",
                  ),
                  MediumGap(),
                  ContainerChild(
                    child: SizedBox(
                      height: ScreenSize().width / 1.5,
                      child: Image.asset(
                        "assets/images/pomodoro/pmd-guide-activetargets.png",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ContainerParent(
              child: Column(
                children: [
                  SimpleText(
                    text:
                        "After the activity session ends, you may take rest for several minutes in break session",
                  ),
                  MediumGap(),
                  ContainerChild(
                    child: SizedBox(
                      height: ScreenSize().width / 1.5,
                      child: Image.asset(
                        "assets/images/pomodoro/pmd-guide-breaksession.png",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ContainerParent(
              color: ColorChoice().greenTertiary(),
              child: Column(
                children: [
                  SimpleText(
                    text:
                        "After break session is done, pop up will be shown for you whether you want to continue the repetitive pomodoro session or end it",
                  ),
                  MediumGap(),
                  ContainerChild(
                    child: SizedBox(
                      height: ScreenSize().width / 3,
                      child: Image.asset(
                        "assets/images/pomodoro/pmd-guide-continuesession.png",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ContainerParent(
              child: Column(
                children: [
                  SimpleText(
                    text:
                        "That’s all you need to understand about this feature, pretty easy right?",
                  ),
                  MediumGap(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorChoice().greenSecondary(),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: SimpleText(
                      text: "Okay okay, I'll start doing it now",
                      size: 16,
                      weight: FontWeight.bold,
                      color: ColorChoice().white(),
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
}
