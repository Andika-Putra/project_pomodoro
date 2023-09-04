// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_pomodoro/pages/target/models/target.dart';
import 'package:project_pomodoro/pages/target/views/target_home_page.dart';
import 'package:project_pomodoro/resources/page_resource.dart';
import 'package:provider/provider.dart';

import '../../../resources/appbar_resource.dart';
import '../../../resources/color_choice_resource.dart';
import '../../../resources/container_resource.dart';
import '../../../resources/gap_resource.dart';
import '../../../resources/screen_size_resource.dart';
import '../../../resources/skeleton_resourse.dart';
import '../../../resources/text_resource.dart';
import '../controllers/target_controller.dart';

class TargetDetailPage extends StatefulWidget {
  int? id;
  TargetDetailPage({
    super.key,
    this.id,
  });

  static const routeName = '/target/detail';

  @override
  State<TargetDetailPage> createState() => _TargetDetailPageState();
}

class _TargetDetailPageState extends State<TargetDetailPage> {
  bool getTargetDetailTrigger = true;
  bool isEditingMode = false;

  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late final TextEditingController dateController;
  late final TextEditingController timeFromController;
  late final TextEditingController timeToController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    dateController = TextEditingController();
    timeFromController = TextEditingController();
    timeToController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    timeFromController.dispose();
    timeToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final receivedArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, int>;
    final targetProvider =
        Provider.of<TargetController>(context, listen: false);

    if (getTargetDetailTrigger == true) {
      targetProvider.getTargetDetail(receivedArguments["id"] as int);
      getTargetDetailTrigger = !getTargetDetailTrigger;
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: AppBarLeading(
          iconColor: ColorChoice().brownPrimary(),
        ),
        title: AppBarTitle(
          title: "Target Detail",
          color: ColorChoice().brownPrimary(),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(
              right: ScreenSize().width / 20,
            ),
            height: ScreenSize().width / 10,
            width: ScreenSize().width / 10,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: TextButton(
              onPressed: () {
                setState(
                  () {
                    isEditingMode = !isEditingMode;
                  },
                );
              },
              child: Icon(
                isEditingMode == false
                    ? Icons.edit_rounded
                    : Icons.close_rounded,
                color: ColorChoice().brownPrimary(),
              ),
            ),
          ),
        ],
      ),
      body: TemplatePage(
        defineType: "isChild",
        arguments: {"id": receivedArguments["id"] as int},
        child: Consumer<TargetController>(
          builder: (context, value, child) => value
                  .returnedGetTargetDetail.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ContainerParent(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextBox(
                            controller: titleController,
                            controllerValue:
                                value.returnedGetTargetDetail["data"]["title"],
                            prefixIcon: Icons.title_rounded,
                            hintText: "Insert Title",
                            isEditingMode: isEditingMode,
                          ),
                          TextBox(
                            controller: descriptionController,
                            controllerValue: value
                                .returnedGetTargetDetail["data"]["description"],
                            prefixIcon: Icons.notes_rounded,
                            hintText: "Insert Description",
                            isEditingMode: isEditingMode,
                          ),
                          // TextBox(
                          //   controller: descriptionController,
                          //   prefixIcon: Icons.notes_rounded,
                          //   hintText: "Insert Description",
                          // ),
                        ],
                      ),
                    ),
                    SmallGap(),
                    ContainerParent(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: SimpleText(
                              text: "Your plan time on doing your target",
                              size: 14,
                              // color: Colors.black87,
                              weight: FontWeight.bold,
                            ),
                          ),
                          MediumGap(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 5,
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SimpleText(
                                        text: "Date",
                                      ),
                                      SmallGap(),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            width: 0.7,
                                            color: Colors.grey,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          boxShadow: [
                                            isEditingMode == true
                                                ? const BoxShadow(
                                                    color: Colors.grey,
                                                    blurRadius: 0.5,
                                                    offset: Offset(0.5, 0.5),
                                                  )
                                                : BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.1),
                                                  ),
                                          ],
                                        ),
                                        child: DateChoose(
                                          date: DateTime.parse(
                                              value.returnedGetTargetDetail[
                                                  "data"]["dateChosen"]),
                                          controller: dateController,
                                          isEditingMode: isEditingMode,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 5,
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SimpleText(
                                        text: "Time",
                                      ),
                                      SmallGap(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                width: 0.7,
                                                color: Colors.grey,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              boxShadow: [
                                                isEditingMode == true
                                                    ? const BoxShadow(
                                                        color: Colors.grey,
                                                        blurRadius: 0.5,
                                                        offset:
                                                            Offset(0.5, 0.5),
                                                      )
                                                    : BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.1),
                                                      ),
                                              ],
                                            ),
                                            child: TimeChoose(
                                              controller: timeFromController,
                                              timeOfDay: stringToTimeOfDay(
                                                value.returnedGetTargetDetail[
                                                    "data"]["timeFrom"],
                                              ),
                                              isEditingMode: isEditingMode,
                                            ),
                                          ),
                                          SimpleText(
                                            text: " - ",
                                            size: 24,
                                            weight: FontWeight.bold,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                width: 0.7,
                                                color: Colors.grey,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              boxShadow: [
                                                isEditingMode == true
                                                    ? const BoxShadow(
                                                        color: Colors.grey,
                                                        blurRadius: 0.5,
                                                        offset:
                                                            Offset(0.5, 0.5),
                                                      )
                                                    : BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.1),
                                                      ),
                                              ],
                                            ),
                                            child: TimeChoose(
                                              controller: timeToController,
                                              timeOfDay: stringToTimeOfDay(
                                                value.returnedGetTargetDetail[
                                                    "data"]["timeTo"],
                                              ),
                                              isEditingMode: isEditingMode,
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
                        ],
                      ),
                    ),
                  ],
                )
              : const SkeletonForm(),
        ),
      ),
      bottomNavigationBar: isEditingMode == true
          ? Container(
              padding: EdgeInsets.only(right: ScreenSize().width / 20),
              height: ScreenSize().heightAppBar * 1.5,
              width: ScreenSize().width,
              color: Colors.transparent,
              child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorChoice().brownPrimary(),
                  ),
                  onPressed: () {
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
                                      padding: EdgeInsets.all(
                                        ScreenSize().width / 50,
                                      ),
                                      child: SimpleText(
                                        text:
                                            "Are you sure to save these changes?",
                                        size: 16,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 4,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.all(ScreenSize().width / 50),
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
                                                ColorChoice().brownPrimary(),
                                          ),
                                          onPressed: () {
                                            targetProvider
                                                .updateTarget(Target(
                                              id: targetProvider
                                                      .returnedGetTargetDetail[
                                                  "data"]["id"],
                                              title: titleController.text,
                                              description:
                                                  descriptionController.text,
                                              dateChosen: dateController.text,
                                              timeFrom: timeFromController.text,
                                              timeTo: timeToController.text,
                                            ))
                                                .then((_) {
                                              Navigator.popUntil(
                                                  context,
                                                  ModalRoute.withName(
                                                      TargetHomePage
                                                          .routeName));
                                              Navigator.of(context)
                                                  .pushReplacementNamed(
                                                TargetHomePage.routeName,
                                              );
                                              Navigator.of(context).pushNamed(
                                                  TargetDetailPage.routeName,
                                                  arguments: {
                                                    "id":
                                                        receivedArguments["id"]
                                                            as int
                                                  });
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  backgroundColor: ColorChoice()
                                                      .brownPrimary(),
                                                  content: SimpleText(
                                                    text:
                                                        "Target has been successfully updated!",
                                                    color:
                                                        ColorChoice().white(),
                                                    weight: FontWeight.bold,
                                                  ),
                                                ),
                                              );
                                            });
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
                  },
                  child: SimpleText(
                    text: "Save Changes",
                    size: 16,
                    weight: FontWeight.bold,
                    color: ColorChoice().white(),
                  ),
                ),
              ),
            )
          : const SizedBox(),
    );
  }

  TimeOfDay stringToTimeOfDay(String time) {
    return TimeOfDay(
      hour: int.parse(
        time.substring(0, 2),
      ),
      minute: int.parse(
        time.substring(3, 5),
      ),
    );
  }
}

class SkeletonForm extends StatelessWidget {
  const SkeletonForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: ScreenSize().heightBody / 100,
        left: ScreenSize().heightBody / 40,
        right: ScreenSize().heightBody / 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Bone(
              height: ScreenSize().heightBody / 20,
              width: ScreenSize().width,
            ),
          ),
          SmallGap(),
          Center(
            child: Bone(
              height: ScreenSize().heightBody / 20,
              width: ScreenSize().width,
            ),
          ),
          MediumGap(),
          MediumGap(),
          Center(
            child: Bone(
              height: ScreenSize().heightBody / 30,
              width: ScreenSize().width / 2,
            ),
          ),
          SmallGap(),
          SizedBox(
            width: ScreenSize().width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Bone(
                  height: ScreenSize().heightBody / 10,
                  width: ScreenSize().width / 2.5,
                ),
                Bone(
                  height: ScreenSize().heightBody / 10,
                  width: ScreenSize().width / 2.5,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TextBox extends StatelessWidget {
  final TextEditingController controller;
  final String controllerValue;
  final IconData prefixIcon;
  final String hintText;
  final bool isEditingMode;

  const TextBox({
    super.key,
    required this.controller,
    required this.controllerValue,
    required this.prefixIcon,
    required this.hintText,
    required this.isEditingMode,
  });

  @override
  Widget build(BuildContext context) {
    controller.text = controllerValue;
    return TextFormField(
      controller: controller,
      // initialValue: initialValue,
      maxLines: null,
      enabled: isEditingMode,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 14),
        labelStyle: TextStyle(
          fontSize: 14,
          color: ColorChoice().brownPrimary(),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(0),
          child: Icon(
            prefixIcon,
            color: isEditingMode == true
                ? ColorChoice().brownPrimary()
                : Colors.black54,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ColorChoice().brownPrimary()),
        ),
      ),
    );
  }

  void doNothing() {}
}

class DateChoose extends StatefulWidget {
  // final BuildContext context;
  DateTime date;
  final TextEditingController controller;
  final bool isEditingMode;

  DateChoose({
    super.key,
    // required this.context,
    required this.date,
    required this.controller,
    required this.isEditingMode,
  });

  @override
  State<DateChoose> createState() => _DateChooseState();
}

class _DateChooseState extends State<DateChoose> {
  @override
  void initState() {
    super.initState();
    widget.controller.text = DateTime.parse(widget.date
            .toString()
            .substring(0, widget.date.toString().length - 4))
        .toString();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        widget.isEditingMode == true
            ? showDatePicker(
                context: context,
                initialDate: widget.date,
                firstDate: DateTime(2021),
                lastDate: DateTime(2025),
                initialEntryMode: DatePickerEntryMode.calendarOnly,
                initialDatePickerMode: DatePickerMode.day,
                selectableDayPredicate: (day) {
                  if ((day.isAfter(
                      DateTime.now().subtract(const Duration(days: 1))))) {
                    return true;
                  } else {
                    return false;
                  }
                },
                builder: (context, child) {
                  return Theme(
                    data: ThemeData.light(),
                    child: child!,
                  );
                },
              ).then(
                (value) {
                  if (value != null) {
                    setState(
                      () {
                        widget.date = value;
                        widget.controller.text = value
                            .toString()
                            .substring(0, value.toString().length - 4);
                        // print(widget.controller.text);
                        // print(widget.date);
                      },
                    );
                  }
                },
              )
            : null;
      },
      child: SimpleText(
        text: widget.controller.text == ""
            ? "Choose a Date"
            : DateFormat('d MMMM y').format(widget.date),
        weight: FontWeight.bold,
        color: widget.isEditingMode == true
            ? ColorChoice().brownPrimary()
            : Colors.black54,
      ),
    );
  }
}

class TimeChoose extends StatefulWidget {
  final TextEditingController controller;
  TimeOfDay timeOfDay;
  final bool isEditingMode;

  TimeChoose({
    super.key,
    required this.controller,
    required this.timeOfDay,
    required this.isEditingMode,
  });

  @override
  State<TimeChoose> createState() => _TimeChooseState();
}

class _TimeChooseState extends State<TimeChoose> {
  @override
  Widget build(BuildContext context) {
    widget.controller.text = widget.timeOfDay.toString().substring(10, 15);

    return TextButton(
      onPressed: () {
        widget.isEditingMode == true
            ? showTimePicker(
                context: context,
                initialTime: widget.timeOfDay,
              ).then(
                (value) {
                  if (value != null) {
                    setState(
                      () {
                        widget.timeOfDay = value;
                        widget.controller.text =
                            value.toString().substring(10, 15);
                      },
                    );
                  }
                },
              )
            : null;
      },
      child: SimpleText(
        text: widget.controller.text == ""
            ? "From"
            : widget.timeOfDay.toString().substring(10, 15),
        weight: FontWeight.bold,
        color: widget.isEditingMode == true
            ? ColorChoice().brownPrimary()
            : Colors.black54,
      ),
    );
  }
}
