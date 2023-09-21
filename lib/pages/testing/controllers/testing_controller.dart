import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../../../configurations/api.dart';
import '../../../utilities/print_debug_utility.dart';

class TestingController with ChangeNotifier {
  Map<String, dynamic> _returnedCreatePhoto = {};
  Map<String, dynamic> get returnedCreatePhoto => _returnedCreatePhoto;

  Future<void> createPhotoTesting(int personId, String base64) async {
    PrintDebug().printCreatePhotoTesting("Start of function createPhoto");

    try {
      _returnedCreatePhoto = {};

      PrintDebug().printCreatePhotoTesting(
          "URI: ${API().baseUri(API.createPhotoTesting)}");

      var requestBody = {
        "personId": personId,
        "base64": base64,
      };

      PrintDebug()
          .printCreatePhotoTesting("Headers: ${API().headersWithoutAuth}");
      PrintDebug()
          .printCreatePhotoTesting("Encoded Body: ${json.encode(requestBody)}");

      await Future.delayed(
        const Duration(milliseconds: 1200),
        () async {
          http.Response response = await http.post(
            API().baseUri(API.createPhotoTesting),
            headers: API().headersWithoutAuth,
            body: json.encode(requestBody),
          );

          if (response.statusCode == 200) {
            PrintDebug().printCreatePhotoTesting("Berhasil");
            // var responseData = json.decode(response.body);
            // if (responseData["status"] == "0") {
            //   PrintDebug().printCreatePhotoTesting(
            //       "createPhoto data is failed to retrieve! Data status code ${responseData["status"]}");
            // } else {
            //   _returnedCreatePhoto = responseData;
            //   PrintDebug()
            //       .printCreatePhotoTesting("Response Data: $responseData");
            //   PrintDebug().printCreatePhotoTesting(
            //       "createPhoto data is successfully retrieved! Data status code ${responseData["status"]}");
            //   notifyListeners();
            // }
          }
          // else {
          //   PrintDebug().printCreatePhotoTesting(
          //       "createPhoto data is failed to retrieve! Response status code ${response.statusCode}");
          // }
        },
      );
    } catch (e) {
      PrintDebug().printCreatePhotoTesting(e);
    } finally {
      PrintDebug().printCreatePhotoTesting("End of function createPhoto");
    }
  }

  String _returnedReadPhoto = "";
  String get returnedReadPhoto => _returnedReadPhoto;

  Future<void> readPhotoTesting(String fileName) async {
    PrintDebug().printReadPhotoTesting("Start of function readPhotoTesting");

    try {
      _returnedReadPhoto = "";

      PrintDebug().printReadPhotoTesting(
          "URI: ${API().baseUri(API.createPhotoTesting)}");

      var requestBody = {"fileName": fileName};

      PrintDebug()
          .printReadPhotoTesting("Headers: ${API().headersWithoutAuth}");
      PrintDebug()
          .printReadPhotoTesting("Encoded Body: ${json.encode(requestBody)}");

      await Future.delayed(
        const Duration(milliseconds: 1200),
        () async {
          http.Response response = await http.post(
            API().baseUri(API.readPhotoTesting),
            headers: API().headersWithoutAuth,
            body: json.encode(requestBody),
          );

          if (response.statusCode == 200) {
            PrintDebug().printReadPhotoTesting("Berhasil");
            _returnedReadPhoto = json.decode(response.body);
            PrintDebug().printReadPhotoTesting(_returnedReadPhoto);
            notifyListeners();
            // var responseData = json.decode(response.body);
            // if (responseData["status"] == "0") {
            //   PrintDebug().printCreatePhotoTesting(
            //       "createPhoto data is failed to retrieve! Data status code ${responseData["status"]}");
            // } else {
            //   _returnedCreatePhoto = responseData;
            //   PrintDebug()
            //       .printCreatePhotoTesting("Response Data: $responseData");
            //   PrintDebug().printCreatePhotoTesting(
            //       "createPhoto data is successfully retrieved! Data status code ${responseData["status"]}");
            //   notifyListeners();
            // }
          }
          // else {
          //   PrintDebug().printCreatePhotoTesting(
          //       "createPhoto data is failed to retrieve! Response status code ${response.statusCode}");
          // }
        },
      );
    } catch (e) {
      PrintDebug().printReadPhotoTesting(e);
    } finally {
      PrintDebug().printReadPhotoTesting("End of function readPhotoTesting");
    }
  }
}
