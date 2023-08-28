// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:project_pomodoro/resources/page_resource.dart';
import 'package:project_pomodoro/resources/text_resource.dart';
import 'package:provider/provider.dart';

import '../../../resources/appbar_resource.dart';
import '../../../resources/color_choice_resource.dart';
import '../../../resources/container_resource.dart';
import '../../../resources/gap_resource.dart';
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

  late final TextEditingController titleController;
  // late final TextEditingController descriptionController;
  // late final TextEditingController dateController;
  // late final TextEditingController timeFromController;
  // late final TextEditingController timeToController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    // descriptionController = TextEditingController();
    // dateController = TextEditingController();
    // timeFromController = TextEditingController();
    // timeToController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    // descriptionController.dispose();
    // dateController.dispose();
    // timeFromController.dispose();
    // timeToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final receivedArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, int>;
    final targetProvider =
        Provider.of<TargetController>(context, listen: false);

    // Future<void> setControllerValue() async {
    //   await targetProvider.getTargetDetail(receivedArguments["id"] as int).then(
    //     (_) {
    //       titleController.text =
    //           targetProvider.returnedGetTargetDetail["status"];
    //     },
    //   );
    // }

    if (getTargetDetailTrigger == true) {
      targetProvider.getTargetDetail(receivedArguments["id"] as int);
      // setControllerValue();
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
          title: "Create New Target",
          iconColor: ColorChoice().brownPrimary(),
        ),
      ),
      body: TemplatePage(
        defineType: "isChild",
        child: Consumer<TargetController>(
          builder: (context, value, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SimpleText(text: "${value.returnedGetTargetDetail["data"]}"),

              ContainerParent(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextBox(
                      controller: titleController,
                      controllerValue: value.returnedGetTargetDetail["data"]
                          ["title"],
                      prefixIcon: Icons.title_rounded,
                      hintText: "Insert Title",
                    ),
                  ],
                ),
              ),
              SmallGap(),
            ],
          ),
        ),
      ),
    );
  }
}

class TextBox extends StatelessWidget {
  final TextEditingController controller;
  final String controllerValue;
  final IconData prefixIcon;
  final String hintText;
  // final String initialValue;

  const TextBox({
    super.key,
    required this.controller,
    required this.controllerValue,
    required this.prefixIcon,
    required this.hintText,
    // required this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    controller.text = controllerValue;
    return TextFormField(
      controller: controller,
      // initialValue: initialValue,
      maxLines: null,
      // enabled: false,
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
