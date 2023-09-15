// ignore_for_file: use_key_in_widget_constructors

import 'dart:io';

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_pomodoro/resources/container_resource.dart';
import 'package:project_pomodoro/resources/font_size_resource.dart';
import 'package:project_pomodoro/resources/page_resource.dart';
import 'package:project_pomodoro/resources/text_resource.dart';

import '../../../resources/image_processing_resource.dart';
import '../../../resources/screen_size_resource.dart';

class TestingPage extends StatefulWidget {
  static const routeName = '/testing';

  @override
  State<TestingPage> createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContainerDefault(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () async {
                await ImageProcessing().takePicureCamera().then(
                  (value) {
                    setState(() {
                      image = value;
                      print(image);
                    });
                  },
                );
              },
              child: Icon(
                Icons.camera_alt,
                size: FontSize().adjustFont(50),
              ),
            ),
            Container(
              child: TextButton(
                onPressed: () {},
                child: photoLocalPreview(
                  image!,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget photoLocalPreview(File path) {
    if (path != "") {
      return Container(
        margin: EdgeInsets.all(ScreenSize().width / 100),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 0.7,
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5,
              offset: Offset(3, 5),
            ),
          ],
        ),
        height: ScreenSize().heightBody / 2,
        width: ScreenSize().width / 1.3,
        child: TextButton(
          onPressed: () {
            showImageViewer(
              context,
              Image.file(path).image,
              swipeDismissible: true,
              doubleTapZoomable: true,
            );
          },
          child: Image.file(path),
        ),
      );
    } else {
      return Container();
    }
  }
}
