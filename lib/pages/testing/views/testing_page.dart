// ignore_for_file: use_key_in_widget_constructors

import 'dart:convert';
import 'dart:io';

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_pomodoro/pages/testing/controllers/testing_controller.dart';
import 'package:project_pomodoro/resources/container_resource.dart';
import 'package:project_pomodoro/resources/font_size_resource.dart';
import 'package:project_pomodoro/resources/page_resource.dart';
import 'package:project_pomodoro/resources/text_resource.dart';
import 'package:provider/provider.dart';

import '../../../resources/image_processing_resource.dart';
import '../../../resources/screen_size_resource.dart';

class TestingPage extends StatefulWidget {
  static const routeName = '/testing';

  @override
  State<TestingPage> createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  File? image;

  String? encodedValue;
  Uint8List? decodedValue;

  TextEditingController? encodedValueController;

  @override
  Widget build(BuildContext context) {
    final testingProvider =
        Provider.of<TestingController>(context, listen: false);

    // final targetProvider =
    //     Provider.of<TargetController>(context, listen: false);

    return Scaffold(
      body: TemplatePage(
        defineType: "",
        child: ContainerDefault(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () async {
                  await ImageProcessing().takePicureCamera().then(
                    (value) {
                      setState(() {
                        image = value;
                        // print(image);
                      });
                    },
                  );
                },
                child: Icon(
                  Icons.camera_alt,
                  size: FontSize().adjustFont(50),
                ),
              ),
              image != null
                  ? Column(
                      children: [
                        Container(
                          child: TextButton(
                            onPressed: () {},
                            child: photoLocalPreview(
                              image!,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            getBase64Value(image!);
                            await testingProvider
                                .createPhotoTesting(1, encodedValue!)
                                .then((value) =>
                                    testingProvider.readPhotoTesting(
                                        "1_21-09-2023_143571695281707324.png"));
                          },
                          child: Icon(
                            Icons.upload,
                          ),
                        ),
                      ],
                    )
                  : Container(),
              Consumer<TestingController>(
                builder: (context, value, child) => value
                        .returnedReadPhoto.isNotEmpty
                    ? Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(ScreenSize().width / 100),
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
                                  blurRadius: 5,
                                  offset: Offset(3, 5),
                                ),
                              ],
                            ),
                            height: ScreenSize().heightBody / 3,
                            width: ScreenSize().width / 2,
                            child: TextButton(
                              onPressed: () {},
                              child: Image.memory(
                                  base64Decode(value.returnedReadPhoto)),
                            ),
                          ),
                        ],
                      )
                    : Container(),
              ),
              // encodedValue != null
              //     ? SingleChildScrollView(
              //         child: Column(
              //           children: [
              //             Container(
              //               margin: EdgeInsets.all(ScreenSize().width / 100),
              //               decoration: BoxDecoration(
              //                 color: Colors.white,
              //                 border: Border.all(
              //                   width: 0.7,
              //                   color: Colors.grey,
              //                 ),
              //                 borderRadius: BorderRadius.circular(5),
              //                 boxShadow: const [
              //                   BoxShadow(
              //                     color: Colors.grey,
              //                     blurRadius: 5,
              //                     offset: Offset(3, 5),
              //                   ),
              //                 ],
              //               ),
              //               height: ScreenSize().heightBody / 3,
              //               width: ScreenSize().width / 2,
              //               child: TextButton(
              //                 onPressed: () {},
              //                 child: Image.memory(decodedValue!),
              //               ),
              //             ),
              //           ],
              //         ),
              //       )
              //     : Container(),
            ],
          ),
        ),
      ),
    );
  }

  void getBase64Value(File file) {
    List<int> imageBytes = File(file.path).readAsBytesSync();
    setState(() {
      encodedValue = base64Encode(imageBytes);
      // print("Encoded value : $encodedValue");
      // print("Encoded length : ${encodedValue!.length.toString()}");

      // decodedValue = base64Decode(encodedValue!);
      // print("Decoded value : $decodedValue");
    });
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
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5,
              offset: Offset(3, 5),
            ),
          ],
        ),
        height: ScreenSize().heightBody / 3,
        width: ScreenSize().width / 2,
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
