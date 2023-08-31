// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:project_pomodoro/pages/account/views/sign_up_page.dart';
import 'package:project_pomodoro/pages/home/views/home_page.dart';
import 'package:project_pomodoro/resources/color_choice_resource.dart';
import 'package:project_pomodoro/resources/container_resource.dart';
import 'package:project_pomodoro/resources/loading_resource.dart';
import 'package:project_pomodoro/resources/page_resource.dart';
import 'package:project_pomodoro/resources/screen_size_resource.dart';
import 'package:project_pomodoro/resources/text_resource.dart';
import 'package:provider/provider.dart';

import '../../../resources/gap_resource.dart';
import '../controllers/account_controller.dart';

class SignInPage extends StatefulWidget {
  static const routeName = '/sign-in';

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late final TextEditingController emailController;
  bool signInTrigger = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
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
                        text: "Welcome back",
                        size: 30,
                        color: Colors.black87,
                      ),
                      MediumGap(),
                      Center(
                        child: SimpleText(
                          text:
                              "Sign in with your email to start using Pomodoro",
                        ),
                      ),
                    ],
                  ),
                  LargeGap(),
                  ContainerParent(
                    child: Column(
                      children: [
                        TextBox(
                          controller: emailController,
                          hintText: "E-mail",
                          icon: Icons.person_outlined,
                        ),
                      ],
                    ),
                  ),
                  LargeGap(),
                  ContainerParent(
                    child: signInTrigger == false
                        ? ElevatedButton(
                            onPressed: () async {
                              setState(
                                () {
                                  signInTrigger = true;
                                },
                              );
                              await accountProvider
                                  .authenticatePerson(emailController.text)
                                  .then(
                                (_) {
                                  if (accountProvider
                                      .returnedAuthenticatePerson.isNotEmpty) {
                                    if (accountProvider
                                                .returnedAuthenticatePerson[
                                            "data"]["token"] !=
                                        null) {
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              HomePage.routeName);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor:
                                              ColorChoice().greenPrimary(),
                                          content: SimpleText(
                                            text: "Sign in succeed",
                                            color: ColorChoice().white(),
                                            weight: FontWeight.bold,
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                },
                              );
                              setState(
                                () {
                                  if (accountProvider
                                      .returnedAuthenticatePerson.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor:
                                            ColorChoice().brownPrimary(),
                                        content: SimpleText(
                                          text:
                                              "Sign in failed, please check your e-mail again",
                                          color: ColorChoice().white(),
                                          weight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                    signInTrigger = false;
                                  }
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorChoice().greenPrimary(),
                            ),
                            child: SimpleText(
                              text: "Sign In",
                              size: 16,
                              weight: FontWeight.bold,
                              color: ColorChoice().white(),
                            ),
                          )
                        : Loading().indicatorCircleStrokeSpinOnly(),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SimpleText(
                    text: "Haven't create any account yet?",
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(SignUpPage.routeName);
                    },
                    child: SimpleText(
                      text: "Sign Up",
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
