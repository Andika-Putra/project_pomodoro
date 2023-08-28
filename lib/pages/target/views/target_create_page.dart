// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_pomodoro/pages/target/models/target.dart';
import 'package:project_pomodoro/pages/target/views/target_home_page.dart';
import 'package:project_pomodoro/resources/container_resource.dart';
import 'package:project_pomodoro/resources/gap_resource.dart';
import 'package:project_pomodoro/resources/page_resource.dart';
import 'package:project_pomodoro/resources/screen_size_resource.dart';
import 'package:project_pomodoro/resources/text_resource.dart';
import 'package:provider/provider.dart';

import '../../../resources/appbar_resource.dart';
import '../../../resources/color_choice_resource.dart';
import '../controllers/target_controller.dart';

class TargetCreatePage extends StatefulWidget {
  TargetCreatePage({super.key});

  static const routeName = '/target-create';

  @override
  State<TargetCreatePage> createState() => _TargetCreatePageState();
}

class _TargetCreatePageState extends State<TargetCreatePage> {
  final createTargetFormKey = GlobalKey<FormState>();
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late final TextEditingController dateController;
  late final TextEditingController timeFromController;
  late final TextEditingController timeToController;

  DateTime date = DateTime.now();
  TimeOfDay timeFrom = TimeOfDay.now();
  TimeOfDay timeTo = TimeOfDay.now();

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
    final targetProvider =
        Provider.of<TargetController>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: AppBarLeading(
          iconColor: ColorChoice().brownPrimary(),
        ),
        title: AppBarTitle(
          title: "Create New Target",
          iconColor: ColorChoice().brownPrimary(),
        ),
      ),
      body: TemplatePage(
        defineType: "",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ContainerParent(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextBox(
                    controller: titleController,
                    prefixIcon: Icons.title_rounded,
                    hintText: "Insert Title",
                  ),
                  TextBox(
                    controller: descriptionController,
                    prefixIcon: Icons.notes_rounded,
                    hintText: "Insert Description",
                  ),
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
                      text: "When do you want to start doing your target?",
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
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 0.5,
                                      offset: Offset(0.5, 0.5),
                                    ),
                                  ],
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: date,
                                      firstDate: DateTime(2021),
                                      lastDate: DateTime(2025),
                                      initialEntryMode:
                                          DatePickerEntryMode.calendarOnly,
                                      initialDatePickerMode: DatePickerMode.day,
                                      selectableDayPredicate: (day) {
                                        if ((day.isAfter(DateTime.now()
                                            .subtract(
                                                const Duration(days: 1))))) {
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
                                              date = value;
                                              dateController.text =
                                                  DateFormat('d MMMM y')
                                                      .format(date);
                                            },
                                          );
                                        }
                                      },
                                    );
                                  },
                                  child: SimpleText(
                                    text: dateController.text == ""
                                        ? "Choose a Date"
                                        : DateFormat('d MMMM y').format(date),
                                    weight: FontWeight.bold,
                                    color: ColorChoice().brownPrimary(),
                                  ),
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SimpleText(
                                text: "Time",
                              ),
                              SmallGap(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        width: 0.7,
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 0.5,
                                          offset: Offset(0.5, 0.5),
                                        ),
                                      ],
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        showTimePicker(
                                          context: context,
                                          initialTime: timeFrom,
                                        ).then((value) {
                                          if (value != null) {
                                            setState(
                                              () {
                                                timeFrom = value;
                                                timeFromController.text = value
                                                    .toString()
                                                    .substring(10, 15);
                                              },
                                            );
                                          }
                                        });
                                      },
                                      child: SimpleText(
                                        text: timeFromController.text == ""
                                            ? "From"
                                            : timeFrom
                                                .toString()
                                                .substring(10, 15),
                                        weight: FontWeight.bold,
                                        color: ColorChoice().brownPrimary(),
                                      ),
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
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 0.5,
                                          offset: Offset(0.5, 0.5),
                                        ),
                                      ],
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        showTimePicker(
                                          context: context,
                                          initialTime: timeTo,
                                        ).then((value) {
                                          if (value != null) {
                                            setState(
                                              () {
                                                timeTo = value;
                                                timeToController.text = value
                                                    .toString()
                                                    .substring(10, 15);
                                              },
                                            );
                                          }
                                        });
                                      },
                                      child: SimpleText(
                                        text: timeToController.text == ""
                                            ? "To"
                                            : timeTo
                                                .toString()
                                                .substring(10, 15),
                                        weight: FontWeight.bold,
                                        color: ColorChoice().brownPrimary(),
                                      ),
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
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(right: ScreenSize().width / 20),
        height: ScreenSize().heightAppBar,
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
                                padding:
                                    EdgeInsets.all(ScreenSize().width / 50),
                                child: SimpleText(
                                  text: "Are you sure to create this target?",
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
                                          ColorChoice().brownPrimary(),
                                    ),
                                    onPressed: () async {
                                      // print(API().baseUri(API.targets));
                                      await targetProvider
                                          .addTarget(
                                        Target(
                                          personId: 1,
                                          title: titleController.text,
                                          description:
                                              descriptionController.text,
                                          dateChosen: dateController.text,
                                          timeFrom: timeFromController.text,
                                          timeTo: timeToController.text,
                                        ),
                                      )
                                          .then((_) {
                                        Navigator.popUntil(
                                            context,
                                            ModalRoute.withName(
                                                TargetHomePage.routeName));
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                TargetHomePage.routeName);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor:
                                                ColorChoice().brownPrimary(),
                                            content: SimpleText(
                                              text:
                                                  "Target has been successfully created!",
                                              color: ColorChoice().white(),
                                              weight: FontWeight.bold,
                                            ),
                                          ),
                                        );
                                      });
                                      // Navigator.popUntil(
                                      //     context,
                                      //     ModalRoute.withName(
                                      //         TargetHomePage.routeName));
                                      // ScaffoldMessenger.of(context)
                                      //     .showSnackBar(
                                      //   SnackBar(
                                      //       backgroundColor:
                                      //           ColorChoice().brownPrimary(),
                                      //       content: SimpleText(
                                      //         text:
                                      //             "Target has been successfully created!",
                                      //         color: ColorChoice().white(),
                                      //         weight: FontWeight.bold,
                                      //       )),
                                      // );
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
              text: "Create Target",
              size: 16,
              weight: FontWeight.bold,
              color: ColorChoice().white(),
            ),
          ),
        ),
      ),
    );
  }
}

class TextBox extends StatelessWidget {
  final TextEditingController controller;
  final IconData prefixIcon;
  // final IconData? suffixIcon;
  final String hintText;

  const TextBox({
    super.key,
    required this.controller,
    required this.prefixIcon,
    // this.suffixIcon,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: null,
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
            color: ColorChoice().brownPrimary(),
          ),
        ),
        // suffixIcon: suffixIcon != null
        //     ? Padding(
        //         padding: const EdgeInsets.all(0),
        //         child: Icon(
        //           suffixIcon,
        //           color: ColorChoice().brownPrimary(),
        //         ),
        //       )
        //     : Container(),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ColorChoice().brownPrimary()),
        ),
      ),
    );
  }

  void doNothing() {}
}
