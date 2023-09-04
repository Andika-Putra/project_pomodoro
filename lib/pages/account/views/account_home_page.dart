// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:project_pomodoro/pages/account/models/person.dart';
import 'package:project_pomodoro/resources/container_resource.dart';
import 'package:project_pomodoro/resources/page_resource.dart';
import 'package:project_pomodoro/resources/screen_size_resource.dart';
import 'package:project_pomodoro/resources/text_resource.dart';
import 'package:project_pomodoro/utilities/shared_prefs_utility.dart';
import 'package:provider/provider.dart';

import '../../../resources/appbar_resource.dart';
import '../../../resources/color_choice_resource.dart';
import '../../../resources/gap_resource.dart';
import '../../../resources/skeleton_resourse.dart';
import '../../home/views/home_page.dart';
import '../controllers/account_controller.dart';

class AccountHomePage extends StatefulWidget {
  int? id;
  AccountHomePage({
    super.key,
    this.id,
  });
  static const routeName = '/account/home';

  @override
  State<AccountHomePage> createState() => _AccountHomePageState();
}

class _AccountHomePageState extends State<AccountHomePage> {
  late final TextEditingController emailController;
  late final TextEditingController nameController;
  late final TextEditingController dreamController;

  bool getPersonDetailTrigger = true;
  bool isEditingMode = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    nameController = TextEditingController();
    dreamController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    dreamController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final receivedArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, int>;
    final accountProvider =
        Provider.of<AccountController>(context, listen: false);

    if (getPersonDetailTrigger == true) {
      accountProvider.getPersonDetail(receivedArguments["id"] as int);
      getPersonDetailTrigger = !getPersonDetailTrigger;
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: AppBarLeading(
          iconColor: ColorChoice().greenPrimary(),
        ),
        title: AppBarTitle(
          title: "Account",
          color: ColorChoice().greenPrimary(),
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
                color: ColorChoice().greenPrimary(),
              ),
            ),
          ),
        ],
      ),
      body: TemplatePage(
        defineType: "",
        arguments: {"id": receivedArguments["id"] as int},
        colorRefresh: ColorChoice().greenPrimary(),
        child: Column(
          children: [
            // ContainerParent(
            //   child: ),
            //
            ContainerParent(
              child: Consumer<AccountController>(
                builder: (context, value, child) => value
                        .returnedGetPersonDetail.isNotEmpty
                    ? Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Stack(
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: Container(
                                    // margin: EdgeInsets.all(ScreenSize().width / 10),
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
                                          blurRadius: 1,
                                          offset: Offset(1, 1),
                                        ),
                                      ],
                                    ),
                                    height: ScreenSize().heightBody / 5,
                                    width: ScreenSize().width / 2.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          LargeGap(),
                          TextBox(
                            controller: emailController,
                            prefixIcon: Icons.mail_outlined,
                            controllerValue:
                                '${value.returnedGetPersonDetail["data"]["email"]}',
                            hintText: 'Insert your e-mail here..',
                            isEditingMode: false,
                          ),
                          TextBox(
                            controller: nameController,
                            prefixIcon: Icons.person_outlined,
                            controllerValue:
                                '${value.returnedGetPersonDetail["data"]["name"]}',
                            hintText: 'Insert your name here..',
                            isEditingMode: isEditingMode,
                          ),
                          TextBox(
                            controller: dreamController,
                            prefixIcon: Icons.wb_incandescent_outlined,
                            controllerValue:
                                '${value.returnedGetPersonDetail["data"]["dream"]}',
                            hintText:
                                'What would you want to be in the future?',
                            isEditingMode: isEditingMode,
                          ),
                        ],
                      )
                    : const Column(
                        children: [
                          SkeletonForm(),
                        ],
                      ),
              ),
            ),
          ],
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
                    backgroundColor: ColorChoice().greenPrimary(),
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
                                                ColorChoice().greenPrimary(),
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
                                            accountProvider
                                                .updatePerson(
                                              Person(
                                                id: int.parse(
                                                    SharedPrefs(key: 'id')
                                                        .getSharedPrefsValue),
                                                name: nameController.text,
                                                dream: dreamController.text,
                                              ),
                                            )
                                                .then((_) {
                                              Navigator.popUntil(
                                                context,
                                                ModalRoute.withName(
                                                  HomePage.routeName,
                                                ),
                                              );
                                              Navigator.of(context)
                                                  .pushReplacementNamed(
                                                HomePage.routeName,
                                              );
                                              Navigator.of(context).pushNamed(
                                                AccountHomePage.routeName,
                                                arguments: {
                                                  "id": receivedArguments["id"]
                                                      as int
                                                },
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  backgroundColor: ColorChoice()
                                                      .greenPrimary(),
                                                  content: SimpleText(
                                                    text:
                                                        "Account has been successfully updated!",
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
          color: ColorChoice().greenPrimary(),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(0),
          child: Icon(
            prefixIcon,
            color: isEditingMode == true
                ? ColorChoice().greenPrimary()
                : Colors.black54,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ColorChoice().greenPrimary()),
        ),
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
              height: ScreenSize().heightBody / 5,
              width: ScreenSize().width / 2.5,
            ),
          ),
          LargeGap(),
          Center(
            child: Bone(
              height: ScreenSize().heightBody / 20,
              width: ScreenSize().width,
            ),
          ),
          MediumGap(),
          Center(
            child: Bone(
              height: ScreenSize().heightBody / 20,
              width: ScreenSize().width,
            ),
          ),
          MediumGap(),
          Center(
            child: Bone(
              height: ScreenSize().heightBody / 20,
              width: ScreenSize().width,
            ),
          ),
        ],
      ),
    );
  }
}
