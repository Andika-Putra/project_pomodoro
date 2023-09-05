// ignore_for_file: use_key_in_widget_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_pomodoro/resources/container_resource.dart';
import 'package:project_pomodoro/resources/gap_resource.dart';
import 'package:project_pomodoro/resources/page_resource.dart';
import 'package:project_pomodoro/resources/screen_size_resource.dart';
import 'package:project_pomodoro/resources/text_resource.dart';
import 'package:provider/provider.dart';

import '../../../resources/appbar_resource.dart';
import '../../../resources/color_choice_resource.dart';
import '../../../utilities/shared_prefs_utility.dart';
import '../../target/controllers/target_controller.dart';

class PomodoroHomePage extends StatefulWidget {
  static const routeName = '/pomodoro/home';

  @override
  State<PomodoroHomePage> createState() => _PomodoroHomePageState();
}

class _PomodoroHomePageState extends State<PomodoroHomePage> {
  int seconds = 100;
  int minutes = 0;
  int hours = 0;

  bool isRunning = false;

  Timer? timer;

  void startTimer() {
    setState(() {
      isRunning = true;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else if (minutes > 0) {
          minutes--;
          seconds = 59;
        } else {
          isRunning = false;
          if (isRunning == false && minutes == 0 && seconds == 0) {
            minutes = 0;
            seconds = 100; //
          }
          timer.cancel();
        }
      });
    });
  }

  void pauseTimer() {
    setState(() {
      isRunning = false;
    });
    timer?.cancel();
  }

  void stopTimer() {
    setState(() {
      minutes = 0;
      seconds = 100; //
      isRunning = false;
    });
    timer?.cancel();
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }

  bool getTargetsTrigger = true;

  @override
  Widget build(BuildContext context) {
    final targetProvider =
        Provider.of<TargetController>(context, listen: false);
    if (getTargetsTrigger == true) {
      targetProvider.getTargets(
        int.parse(
          SharedPrefs(key: 'id').getSharedPrefsValue,
        ),
      );
      getTargetsTrigger = false;
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: AppBarLeading(
          iconColor: ColorChoice().greenSecondary(),
        ),
        title: AppBarTitle(
          title: "Pomodoro",
          color: ColorChoice().greenSecondary(),
        ),
      ),
      body: TemplatePage(
        defineType: "",
        child: Column(
          children: [
            Container(
              width: ScreenSize().width,
              height: ScreenSize().heightAppBar,
              color: ColorChoice().greenTertiary(),
              child: TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SimpleText(
                          text: "Don't know how to use this feature?",
                          weight: FontWeight.bold,
                          color: ColorChoice().greenSecondary(),
                        ),
                        SimpleText(
                          text: "Let us help you",
                          weight: FontWeight.bold,
                          color: ColorChoice().greenSecondary(),
                        ),
                      ],
                    ),
                    MediumHorizontalGap(),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: ColorChoice().greenSecondary(),
                    ),
                  ],
                ),
              ),
            ),
            LargeGap(),
            SizedBox(
              height: ScreenSize().width / 1.5,
              width: ScreenSize().width / 1.5,
              child: Image.asset(
                "assets/images/pomodoro/pmd-timer.png",
              ),
            ),
            LargeGap(),
            isRunning == false
                ? SimpleText(
                    text: "Waiting for you to start the Pomodoro Session...",
                    // weight: FontWeight.bold,
                    size: 16,
                  )
                : Column(
                    children: [
                      SimpleText(
                        text: "Activity session done in",
                        size: 16,
                      ),
                      SimpleText(
                        text:
                            "${minutes < 10 ? "0${minutes.toString()}" : minutes.toString()}:${seconds < 10 ? "0${seconds.toString()}" : seconds.toString()}",
                        weight: FontWeight.bold,
                        size: 16,
                      ),
                    ],
                  ),
          ],
        ),
      ),
      bottomNavigationBar: isRunning == false
          ? Container(
              height: ScreenSize().heightBody * 0.2,
              width: ScreenSize().width,
              color: ColorChoice().greenTertiary(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Center(
                        child: SimpleText(
                          text:
                              "Click the button below to start Pomodoro Session.",
                        ),
                      ),
                      Center(
                        child: SimpleText(
                          text: "Remember, your targets are important!",
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorChoice().greenSecondary(),
                      ),
                      onPressed: () {
                        if (isRunning == false) {
                          startTimer();
                        } else {
                          pauseTimer();
                        }
                      },
                      child: SimpleText(
                        text: "Play Session",
                        size: 16,
                        weight: FontWeight.bold,
                        color: ColorChoice().white(),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Container(
              height: ScreenSize().heightBody * 0.1,
              width: ScreenSize().width,
              color: ColorChoice().greenTertiary(),
              child: Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      // isScrollControlled: true,
                      builder: (context) {
                        return Container(
                          height: ScreenSize().heightBody / 2,
                          child: ContainerParent(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SimpleText(
                                        text: "Target",
                                        color: Colors.black87,
                                        weight: FontWeight.bold,
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Icon(
                                          Icons.close_rounded,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  flex: 5,
                                  child: Scrollbar(
                                    thickness: 5,
                                    radius: const Radius.circular(10),
                                    thumbVisibility: false,
                                    child: ContainerParent(
                                      child: SingleChildScrollView(
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        child: Column(
                                          children: [
                                            Consumer<TargetController>(
                                              builder:
                                                  (context, value, child) =>
                                                      Column(
                                                children: [
                                                  for (int i = 0;
                                                      i <
                                                          value
                                                              .returnedGetTargetsLength;
                                                      i++)
                                                    TargetCard(
                                                      id: value
                                                              .returnedGetTargets[
                                                          "data"][i]["id"],
                                                      title: value
                                                              .returnedGetTargets[
                                                          "data"][i]["title"],
                                                      date:
                                                          value.returnedGetTargets[
                                                                  "data"][i]
                                                              ["dateChosen"],
                                                      timeFrom: value
                                                              .returnedGetTargets[
                                                          "data"][i]["timeFrom"],
                                                      timeTo: value
                                                              .returnedGetTargets[
                                                          "data"][i]["timeTo"],
                                                      description:
                                                          value.returnedGetTargets[
                                                                  "data"][i]
                                                              ["description"],
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            pauseTimer();
                                            Navigator.pop(context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.amber,
                                          ),
                                          child: SimpleText(
                                            text: "Pause Session",
                                            size: 16,
                                            weight: FontWeight.bold,
                                            color: ColorChoice().white(),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            stopTimer();
                                            Navigator.pop(context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                          ),
                                          child: SimpleText(
                                            text: "Stop Session",
                                            size: 16,
                                            weight: FontWeight.bold,
                                            color: ColorChoice().white(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                        // ContainerParent(
                        //   child: Column(
                        //     children: [
                        //       Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           SimpleText(
                        //             text: "Target",
                        //             color: Colors.black87,
                        //             weight: FontWeight.bold,
                        //           ),
                        //           TextButton(
                        //             onPressed: () {
                        //               Navigator.pop(context);
                        //             },
                        //             child: const Icon(
                        //               Icons.close_rounded,
                        //               color: Colors.red,
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //       SingleChildScrollView(
                        //         child: Column(
                        //           children: [
                        //             for (int i = 0; i < 100; i++)
                        //               SimpleText(
                        //                 text: "OK",
                        //                 size: 50,
                        //               ),
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // );
                      },
                    );
                  },
                  child: SimpleText(
                    text: "Tap to see your targets",
                  ),
                ),
              ),
            ),

      // ElevatedButton(
      //     style: ElevatedButton.styleFrom(
      //       backgroundColor: ColorChoice().brownPrimary(),
      //     ),
      //     onPressed: () {
      //       if (isRunning == false) {
      //         startTimer();
      //       } else {
      //         pauseTimer();
      //       }
      //     },
      //     child: SimpleText(
      //       text: "Pause Session",
      //       size: 16,
      //       weight: FontWeight.bold,
      //       color: ColorChoice().white(),
      //     ),
      //   ),
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
