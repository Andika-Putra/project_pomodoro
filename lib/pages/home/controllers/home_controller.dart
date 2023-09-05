// ignore_for_file: prefer_final_fields

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:project_pomodoro/utilities/print_debug_utility.dart';

import '../../../configurations/api.dart';

class HomeController with ChangeNotifier {
  Map<String, dynamic> _returnedGetPomodoroFAQs = {};
  Map<String, dynamic> get returnedGetPomodoroFAQs => _returnedGetPomodoroFAQs;
  int get returnedGetPomodoroFAQsLength =>
      _returnedGetPomodoroFAQs["data"].length;
  List<bool> _returnedGetPomodoroFAQsIsExpanded = [];
  List<bool> get returnedGetPomodoroFAQsIsExpanded =>
      _returnedGetPomodoroFAQsIsExpanded;

  Future<void> getPomodoroFAQs() async {
    PrintDebug().printGetPomodoroFAQs("Start of function getPomodoroFAQs");

    try {
      _returnedGetPomodoroFAQs = {};
      _returnedGetPomodoroFAQsIsExpanded = [];
      PrintDebug()
          .printGetPomodoroFAQs("URI: ${API().baseUri(API.getPomodoroFAQs)}");

      var requestBody = {};

      PrintDebug().printGetPomodoroFAQs("Headers: ${API().headersWithAuth}");
      PrintDebug()
          .printGetPomodoroFAQs("Encoded Body: ${json.encode(requestBody)}");

      await Future.delayed(
        const Duration(milliseconds: 1200),
        () async {
          http.Response response = await http.post(
            API().baseUri(API.getPomodoroFAQs),
            headers: API().headersWithAuth,
            // body: json.encode(requestBody),
          );

          if (response.statusCode == 200) {
            var responseData = json.decode(response.body);
            if (responseData["status"] == "0") {
              PrintDebug().printGetPomodoroFAQs(
                  "getPomodoroFAQs data is failed to retrieve! Data status code ${responseData["status"]}");
            } else {
              _returnedGetPomodoroFAQs = responseData;
              for (int i = 0;
                  i < _returnedGetPomodoroFAQs["data"].length;
                  i++) {
                _returnedGetPomodoroFAQsIsExpanded.add(false);
              }

              PrintDebug().printGetPomodoroFAQs("Response Data: $responseData");
              PrintDebug().printGetPomodoroFAQs(
                  "getPomodoroFAQs data is successfully retrieved! Data status code ${responseData["status"]}");
              notifyListeners();
            }
          } else {
            PrintDebug().printGetPomodoroFAQs(
                "getPomodoroFAQs data is failed to retrieve! Data status code ${response.statusCode}");
          }
        },
      );
    } catch (e) {
      PrintDebug().printGetPomodoroFAQs(e);
    } finally {
      PrintDebug().printGetPomodoroFAQs("End of function getPomodoroFAQs");
    }
  }

  Map<String, dynamic> _returnedGetOthersFAQs = {};
  Map<String, dynamic> get returnedGetOthersFAQs => _returnedGetOthersFAQs;
  int get returnedGetOthersFAQsLength => _returnedGetOthersFAQs["data"].length;
  List<bool> _returnedGetOthersFAQsIsExpanded = [];
  List<bool> get returnedGetOthersFAQsIsExpanded =>
      _returnedGetOthersFAQsIsExpanded;

  Future<void> getOthersFAQs() async {
    PrintDebug().printGetOthersFAQs("Start of function getOthersFAQs");

    try {
      _returnedGetOthersFAQs = {};
      _returnedGetOthersFAQsIsExpanded = [];
      PrintDebug()
          .printGetOthersFAQs("URI: ${API().baseUri(API.getOthersFAQs)}");

      var requestBody = {};

      PrintDebug().printGetOthersFAQs("Headers: ${API().headersWithAuth}");
      PrintDebug()
          .printGetOthersFAQs("Encoded Body: ${json.encode(requestBody)}");

      await Future.delayed(
        const Duration(milliseconds: 1200),
        () async {
          http.Response response = await http.post(
            API().baseUri(API.getOthersFAQs),
            headers: API().headersWithAuth,
            // body: json.encode(requestBody),
          );

          if (response.statusCode == 200) {
            var responseData = json.decode(response.body);
            if (responseData["status"] == "0") {
              PrintDebug().printGetOthersFAQs(
                  "getOthersFAQs data is failed to retrieve! Data status code ${responseData["status"]}");
            } else {
              _returnedGetOthersFAQs = responseData;
              for (int i = 0; i < _returnedGetOthersFAQs["data"].length; i++) {
                _returnedGetOthersFAQsIsExpanded.add(false);
              }

              PrintDebug().printGetOthersFAQs("Response Data: $responseData");
              PrintDebug().printGetOthersFAQs(
                  "getOthersFAQs data is successfully retrieved! Data status code ${responseData["status"]}");
              notifyListeners();
            }
          } else {
            PrintDebug().printGetOthersFAQs(
                "getPomodoroFAQs data is failed to retrieve! Response status code ${response.statusCode}");
          }
        },
      );
    } catch (e) {
      PrintDebug().printGetOthersFAQs(e);
    } finally {
      PrintDebug().printGetOthersFAQs("End of function getOthersFAQs");
    }
  }
}
