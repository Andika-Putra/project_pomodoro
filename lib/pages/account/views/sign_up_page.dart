// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:project_pomodoro/resources/color_choice_resource.dart';
import 'package:project_pomodoro/resources/page_resource.dart';
import 'package:project_pomodoro/resources/screen_size_resource.dart';
import 'package:provider/provider.dart';

import '../../../resources/container_resource.dart';
import '../../../resources/gap_resource.dart';
import '../../../resources/text_resource.dart';
import '../controllers/account_controller.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = '/sign-up';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accountProvider =
        Provider.of<AccountController>(context, listen: false);

    return Scaffold(
      body: TemplatePage(
        defineType: "isParent",
        child: SizedBox(
          height: ScreenSize().heightBody,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SimpleText(
                        text: "Hello there,",
                        size: 30,
                        color: Colors.black87,
                      ),
                      SimpleText(
                        text: "Welcome to Pomodoro!",
                        size: 30,
                        color: Colors.black87,
                      ),
                      MediumGap(),
                      Center(
                        child: SimpleText(
                          text: "Fill the form below to sign up",
                        ),
                      ),
                    ],
                  ),
                  LargeGap(),
                  ContainerParent(
                    child: Column(
                      children: [
                        TextBox(
                          controller: nameController,
                          hintText: "Name",
                          icon: Icons.person_outlined,
                        ),
                        TextBox(
                          controller: emailController,
                          hintText: "E-mail",
                          icon: Icons.mail_outlined,
                        ),
                      ],
                    ),
                  ),
                  LargeGap(),
                  ContainerParent(
                    child: ElevatedButton(
                      onPressed: () async {
                        await accountProvider
                            .addPerson(
                          nameController.text,
                          emailController.text,
                        )
                            .then((_) {
                          // if (accountProvider.returnedAddPerson.isNotEmpty) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: ColorChoice().greenPrimary(),
                              content: SimpleText(
                                text:
                                    "Account has been signed up successfully!",
                                color: ColorChoice().white(),
                                weight: FontWeight.bold,
                              ),
                            ),
                          );
                          // }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorChoice().greenPrimary(),
                      ),
                      child: SimpleText(
                        text: "Sign Up",
                        size: 16,
                        weight: FontWeight.bold,
                        color: ColorChoice().white(),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SimpleText(
                    text: "Already have an account?",
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: SimpleText(
                      text: "Sign In",
                      weight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextBox extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;

  const TextBox({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
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
            icon,
            color: ColorChoice().greenPrimary(),
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: ColorChoice().greenPrimary(),
          ),
        ),
      ),
      enabled: true,
      // autofocus: true,
    );
  }
}
