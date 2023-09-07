// ignore_for_file: use_key_in_widget_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_pomodoro/pages/pomodoro/views/pomodoro_guide_page.dart';
import 'package:project_pomodoro/resources/container_resource.dart';
import 'package:project_pomodoro/resources/gap_resource.dart';
import 'package:project_pomodoro/resources/page_resource.dart';
import 'package:project_pomodoro/resources/screen_size_resource.dart';
import 'package:project_pomodoro/resources/text_resource.dart';
import 'package:provider/provider.dart';

import '../../../resources/appbar_resource.dart';
import '../../../resources/color_choice_resource.dart';
import '../../../resources/skeleton_resourse.dart';
import '../../../utilities/shared_prefs_utility.dart';
import '../../target/controllers/target_controller.dart';

class PomodoroHomePage extends StatefulWidget {
  static const routeName = '/pomodoro/home';

  @override
  State<PomodoroHomePage> createState() => _PomodoroHomePageState();
}

class _PomodoroHomePageState extends State<PomodoroHomePage> {
  int activitySeconds = 59;
  int activityMinutes = 24;

  int breakSeconds = 59;
  int breakMinutes = 4;

  bool isActivitySessionRunning = false;
  bool isBreakSessionRunning = false;
  bool isActivitySessionFinished = false;
  bool isBreakSessionFinished = false;

  Timer? timer;

  void startActivityTimer() {
    setState(() {
      isActivitySessionRunning = true;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (activitySeconds > 0) {
          activitySeconds--;
        } else if (activityMinutes > 0) {
          activityMinutes--;
          activitySeconds = 59;
        } else {
          isActivitySessionRunning = false;
          if (isActivitySessionRunning == false &&
              activityMinutes == 0 &&
              activitySeconds == 0) {
            activityMinutes = 24;
            activitySeconds = 59;
            timer.cancel();
            isActivitySessionFinished = true;
            isBreakSessionRunning = true;

            startBreakTimer();
            return;
          }

          //
        }
      });
    });
  }

  void startBreakTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (breakSeconds > 0) {
          breakSeconds--;
        } else if (breakMinutes > 0) {
          breakMinutes--;
          breakSeconds = 59;
        } else {
          isBreakSessionRunning = false;
          if (isBreakSessionRunning == false &&
              breakMinutes == 0 &&
              breakSeconds == 0) {
            breakMinutes = 4;
            breakSeconds = 59;
            timer.cancel();
            isBreakSessionRunning = false;
            isActivitySessionFinished = false;
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SizedBox(
                    height: ScreenSize().heightBody / 5,
                    width: ScreenSize().width / 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 3,
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.all(ScreenSize().width / 50),
                              child: SimpleText(
                                text:
                                    "Session has just finished. Do you want to continue the pomodoro session?",
                                size: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 4,
                          child: Padding(
                            padding: EdgeInsets.all(ScreenSize().width / 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        ColorChoice().brownPrimary(),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: SimpleText(
                                    text: "No",
                                    color: ColorChoice().white(),
                                    weight: FontWeight.bold,
                                  ),
                                ),
                                MediumHorizontalGap(),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        ColorChoice().greenPrimary(),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    startActivityTimer();
                                  },
                                  child: SimpleText(
                                    text: "Sure",
                                    color: ColorChoice().white(),
                                    weight: FontWeight.bold,
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
              },
            );

            // startActivityTimer();
            // print("Break finished");
            return;
          }

          //
        }
      });
    });
  }

  void pauseActivityTimer() {
    setState(() {
      isActivitySessionRunning = false;
    });
    timer?.cancel();
  }

  void stopActivityTimer() {
    setState(() {
      activityMinutes = 0;
      activitySeconds = 3; //
      isActivitySessionRunning = false;
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
        colorBackground: Colors.white,
        child: Column(
          children: [
            Container(
              width: ScreenSize().width,
              height: ScreenSize().heightAppBar,
              color: ColorChoice().greenTertiary(),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(PomodoroGuidePage.routeName);
                },
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
            displayTimer(isActivitySessionRunning, isBreakSessionRunning,
                isActivitySessionFinished),

            // SizedBox(
            //   height: ScreenSize().width / 1.5,
            //   width: ScreenSize().width / 1.5,
            //   child: Image.asset(
            //     "assets/images/pomodoro/pmd-timer.png",
            //   ),
            // ),
            // LargeGap(),
            // isActivitySessionRunning == false
            //     ? SimpleText(
            //         text: "Waiting for you to start the Pomodoro Session...",
            //         // weight: FontWeight.bold,
            //         size: 16,
            //       )
            //     : Column(
            //         children: [
            //           SimpleText(
            //             text: "Activity session done in",
            //             size: 16,
            //           ),
            //           SimpleText(
            //             text:
            //                 "${activityMinutes < 10 ? "0${activityMinutes.toString()}" : activityMinutes.toString()}:${activitySeconds < 10 ? "0${activitySeconds.toString()}" : activitySeconds.toString()}",
            //             weight: FontWeight.bold,
            //             size: 16,
            //           ),
            //         ],
            //       ),
          ],
        ),
      ),
      bottomNavigationBar: isActivitySessionFinished == false
          ? isActivitySessionRunning == false
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
                            if (isActivitySessionRunning == false) {
                              startActivityTimer();
                            } else {
                              pauseActivityTimer();
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
                  child: TextButton(
                    onPressed: () {
                      targetProvider.getTargets(int.parse(
                          SharedPrefs(key: 'id').getSharedPrefsValue));
                      showModalBottomSheet(
                        context: context,
                        // isScrollControlled: true,
                        builder: (context) {
                          return SizedBox(
                            height: ScreenSize().heightBody / 2,
                            child: ContainerParent(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    flex: 6,
                                    child: Column(
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SimpleText(
                                                text: "Your active targets",
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
                                                      builder: (context, value,
                                                              child) =>
                                                          value.returnedGetTargetsTrigger ==
                                                                  true
                                                              ? value
                                                                      .returnedGetTargets[
                                                                          "data"]
                                                                      .isNotEmpty
                                                                  ? Column(
                                                                      children: [
                                                                        for (int i =
                                                                                0;
                                                                            i < value.returnedGetTargetsLength;
                                                                            i++)
                                                                          TargetCard(
                                                                            id: value.returnedGetTargets["data"][i]["id"],
                                                                            title:
                                                                                value.returnedGetTargets["data"][i]["title"],
                                                                            date:
                                                                                value.returnedGetTargets["data"][i]["dateChosen"],
                                                                            timeFrom:
                                                                                value.returnedGetTargets["data"][i]["timeFrom"],
                                                                            timeTo:
                                                                                value.returnedGetTargets["data"][i]["timeTo"],
                                                                            description:
                                                                                value.returnedGetTargets["data"][i]["description"],
                                                                          ),
                                                                      ],
                                                                    )
                                                                  : ContainerParent(
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                ScreenSize().width / 4,
                                                                            width:
                                                                                ScreenSize().width / 4,
                                                                            child:
                                                                                Image.asset(
                                                                              "assets/images/target/pmd-notarget.png",
                                                                            ),
                                                                          ),
                                                                          // LargeGap(),
                                                                          LargeHorizontalGap(),
                                                                          Expanded(
                                                                            child:
                                                                                SimpleText(
                                                                              text: "You have not set any target yet..",
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )
                                                              : Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    for (int i =
                                                                            0;
                                                                        i < 10;
                                                                        i++)
                                                                      const SkeletonTargetList(),
                                                                  ],
                                                                ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Flexible(
                                  //   flex: 1,
                                  //   child: Row(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.spaceBetween,
                                  //     children: [
                                  //       SimpleText(
                                  //         text: "Your active targets",
                                  //         color: Colors.black87,
                                  //         weight: FontWeight.bold,
                                  //       ),
                                  //       TextButton(
                                  //         onPressed: () {
                                  //           Navigator.pop(context);
                                  //         },
                                  //         child: const Icon(
                                  //           Icons.close_rounded,
                                  //           color: Colors.red,
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  // Flexible(
                                  //   flex: 5,
                                  //   child: Scrollbar(
                                  //     thickness: 5,
                                  //     radius: const Radius.circular(10),
                                  //     thumbVisibility: false,
                                  //     child: ContainerParent(
                                  //       child: SingleChildScrollView(
                                  //         physics:
                                  //             const AlwaysScrollableScrollPhysics(),
                                  //         child: Column(
                                  //           children: [
                                  //             Consumer<TargetController>(
                                  //               builder: (context, value, child) =>
                                  //                   value.returnedGetTargetsTrigger ==
                                  //                           true
                                  //                       ? value
                                  //                               .returnedGetTargets[
                                  //                                   "data"]
                                  //                               .isNotEmpty
                                  //                           ? Column(
                                  //                               children: [
                                  //                                 for (int i = 0;
                                  //                                     i <
                                  //                                         value
                                  //                                             .returnedGetTargetsLength;
                                  //                                     i++)
                                  //                                   TargetCard(
                                  //                                     id: value.returnedGetTargets[
                                  //                                             "data"]
                                  //                                         [i]["id"],
                                  //                                     title: value.returnedGetTargets[
                                  //                                             "data"]
                                  //                                         [
                                  //                                         i]["title"],
                                  //                                     date: value.returnedGetTargets[
                                  //                                             "data"][i]
                                  //                                         [
                                  //                                         "dateChosen"],
                                  //                                     timeFrom: value
                                  //                                                 .returnedGetTargets[
                                  //                                             "data"][i]
                                  //                                         [
                                  //                                         "timeFrom"],
                                  //                                     timeTo: value
                                  //                                                 .returnedGetTargets[
                                  //                                             "data"][i]
                                  //                                         [
                                  //                                         "timeTo"],
                                  //                                     description: value
                                  //                                                 .returnedGetTargets[
                                  //                                             "data"][i]
                                  //                                         [
                                  //                                         "description"],
                                  //                                   ),
                                  //                               ],
                                  //                             )
                                  //                           : ContainerParent(
                                  //                               child: Row(
                                  //                                 mainAxisAlignment:
                                  //                                     MainAxisAlignment
                                  //                                         .spaceEvenly,
                                  //                                 crossAxisAlignment:
                                  //                                     CrossAxisAlignment
                                  //                                         .center,
                                  //                                 children: [
                                  //                                   SizedBox(
                                  //                                     height: ScreenSize()
                                  //                                             .width /
                                  //                                         4,
                                  //                                     width: ScreenSize()
                                  //                                             .width /
                                  //                                         4,
                                  //                                     child: Image
                                  //                                         .asset(
                                  //                                       "assets/images/target/pmd-notarget.png",
                                  //                                     ),
                                  //                                   ),
                                  //                                   // LargeGap(),
                                  //                                   LargeHorizontalGap(),
                                  //                                   Expanded(
                                  //                                     child:
                                  //                                         SimpleText(
                                  //                                       text:
                                  //                                           "You have not set any target yet..",
                                  //                                     ),
                                  //                                   ),
                                  //                                 ],
                                  //                               ),
                                  //                             )
                                  //                       : Column(
                                  //                           crossAxisAlignment:
                                  //                               CrossAxisAlignment
                                  //                                   .start,
                                  //                           children: [
                                  //                             for (int i = 0;
                                  //                                 i < 10;
                                  //                                 i++)
                                  //                               const SkeletonTargetList(),
                                  //                           ],
                                  //                         ),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),

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
                                              pauseActivityTimer();
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
                                              stopActivityTimer();
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
                        },
                      );
                    },
                    child: SimpleText(
                      text: "Tap for more",
                      weight: FontWeight.bold,
                      color: ColorChoice().greenSecondary(),
                    ),
                  ),
                )
          : SimpleText(text: ""),
    );
  }

  Widget displayTimer(bool isActivitySessionRunning, bool isBreakSessionRunning,
      bool isActivitySessionFinished) {
    if (!isActivitySessionFinished) {
      return Column(
        children: [
          SizedBox(
            height: ScreenSize().width / 1.5,
            width: ScreenSize().width / 1.5,
            child: Image.asset(
              "assets/images/pomodoro/pmd-timer.png",
            ),
          ),
          LargeGap(),
          isActivitySessionRunning == false
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
                          "${activityMinutes < 10 ? "0${activityMinutes.toString()}" : activityMinutes.toString()}:${activitySeconds < 10 ? "0${activitySeconds.toString()}" : activitySeconds.toString()}",
                      weight: FontWeight.bold,
                      size: 16,
                    ),
                  ],
                ),
        ],
      );
    } else {
      return Column(
        children: [
          SizedBox(
            height: ScreenSize().width / 1.5,
            width: ScreenSize().width / 1.5,
            child: Image.asset(
              "assets/images/pomodoro/pmd-ringingtimer.png",
            ),
          ),
          LargeGap(),
          Column(
            children: [
              SimpleText(
                text: "Activity session done.",
                // weight: FontWeight.bold,
                size: 16,
              ),
              SimpleText(
                text: "Take a rest for a while since you don’t",
                // weight: FontWeight.bold,
                size: 16,
              ),
              SimpleText(
                text: "want to make your brain overload",
                // weight: FontWeight.bold,
                size: 16,
              ),
              MediumGap(),
              SimpleText(
                text: "Break session done in",
                size: 16,
              ),
              SimpleText(
                text:
                    "${breakMinutes < 10 ? "0${breakMinutes.toString()}" : breakMinutes.toString()}:${breakSeconds < 10 ? "0${breakSeconds.toString()}" : breakSeconds.toString()}",
                weight: FontWeight.bold,
                size: 16,
              ),
            ],
          )
        ],
      );
    }
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
