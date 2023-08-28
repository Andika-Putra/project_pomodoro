// ignore_for_file: prefer_final_fields

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:project_pomodoro/configurations/api.dart';
import 'package:project_pomodoro/pages/target/models/target.dart';

import '../../../utilities/print_debug_utility.dart';

class TargetController with ChangeNotifier {
  // Future<void> getTargets() async {
  //   PrintDebug().printGetTargets("Start of function getTargets");
  //   try {
  //     _returnedGetTargets = {};
  //     await Future.delayed(
  //       const Duration(seconds: 2),
  //       () {
  //         var jsonStringData = '''
  //         {
  //           "data": [
  //             {
  //               "title":"Create Home Page design",
  //               "dateTimeFrom":"2023-08-23 09:20:00",
  //               "dateTimeTo":"2023-08-23 12:00:00",
  //               "description":"create the home business process and its user interface"
  //             },
  //             {
  //               "title":"Think of Pomodoro Feature ideas ",
  //               "dateTimeFrom":"2023-08-23 12:00:00",
  //               "dateTimeTo":"2023-08-23 14:00:00",
  //               "description":"Think of what will you bring to potential user. Make them sure that this application is valuable!"
  //             }
  //           ]
  //         }
  //         ''';
  //         _returnedGetTargets = jsonDecode(jsonStringData);
  //         PrintDebug().printGetTargets(_returnedGetTargets["data"]);
  //       },
  //     );
  //     notifyListeners();
  //   } catch (e) {
  //     PrintDebug().printGetTargets(e);
  //   } finally {
  //     PrintDebug().printGetTargets("End of function getTargets");
  //   }
  // }

  Map<String, dynamic> _returnedGetTargets = {};
  Map<String, dynamic> get returnedGetTargets => _returnedGetTargets;
  int get returnedGetTargetsLength => _returnedGetTargets["data"].length;
  late bool _returnedGetTargetsTrigger;
  bool get returnedGetTargetsTrigger => _returnedGetTargetsTrigger;
  late bool _returnedGetTargetsNoDataFlag;
  bool get returnedGetTargetsNoDataFlag => _returnedGetTargetsNoDataFlag;

  Future<void> getTargets() async {
    PrintDebug().printGetTargets("Start of function getTargets");

    try {
      _returnedGetTargetsTrigger = false;
      _returnedGetTargetsNoDataFlag = false;
      _returnedGetTargets = {};

      PrintDebug().printGetTargets("URI: ${API().baseUri(API.getTargets)}");

      var requestBody = {"personId": 1};

      PrintDebug().printGetTargets("Headers: ${API.headers}");
      PrintDebug().printGetTargets("Encoded Body: ${json.encode(requestBody)}");

      await Future.delayed(
        const Duration(seconds: 2),
        () async {
          http.Response response = await http.post(
            API().baseUri(API.getTargets),
            headers: API.headers,
            body: json.encode(requestBody),
          );

          if (response.statusCode == 200) {
            var responseData = json.decode(response.body);
            if (responseData["status"] == "0") {
              PrintDebug().printGetTargets(
                  "getTargets data is failed to retrieve! Data status code ${responseData["status"]}");
            } else {
              _returnedGetTargets = responseData;
              PrintDebug().printGetTargets("Response Data: $responseData");
              PrintDebug().printGetTargets(
                  "getTargets data is successfully retrieved! Data status code ${responseData["status"]}");
              notifyListeners();
            }
          } else {
            PrintDebug().printGetTargets(
                "getCares data is successfully retrieved! Data status code ${response.statusCode}");
          }
        },
      );
    } catch (e) {
      PrintDebug().printGetTargets(e);
    } finally {
      _returnedGetTargetsTrigger = true;
      if (_returnedGetTargets.isEmpty) {
        _returnedGetTargetsNoDataFlag = true;
      }
      notifyListeners();
      PrintDebug().printGetTargets("End of function getTargets");
    }
  }

  Map<String, dynamic> _returnedGetTargetDetail = {};
  Map<String, dynamic> get returnedGetTargetDetail => _returnedGetTargetDetail;

  Future<void> getTargetDetail(int id) async {
    PrintDebug().printGetTargetDetail("Start of function getTargetDetail");

    try {
      _returnedGetTargetDetail = {};

      PrintDebug()
          .printGetTargetDetail("URI: ${API().baseUri(API.getTargetDetail)}");

      var requestBody = {"id": id};

      PrintDebug().printGetTargetDetail("Headers: ${API.headers}");
      PrintDebug()
          .printGetTargetDetail("Encoded Body: ${json.encode(requestBody)}");

      http.Response response = await http.post(
        API().baseUri(API.getTargetDetail),
        headers: API.headers,
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        if (responseData["status"] == "0") {
          PrintDebug().printGetTargetDetail(
              "getTargetDetail data is failed to retrieve! Data status code ${responseData["status"]}");
        } else {
          _returnedAddTarget = responseData;
          PrintDebug().printGetTargetDetail("Response Data: $responseData");
          PrintDebug().printGetTargetDetail(
              "getTargetDetail data is successfully retrieved! Data status code ${responseData["status"]}");
          notifyListeners();
        }
      } else {
        PrintDebug().printGetTargetDetail(
            "getTargetDetail data is successfully retrieved! Data status code ${response.statusCode}");
      }
    } catch (e) {
      PrintDebug().printGetTargetDetail(e);
    } finally {
      PrintDebug().printGetTargetDetail("End of function getTargetDetail");
    }
  }

  Map<String, dynamic> _returnedAddTarget = {};
  Map<String, dynamic> get returnedAddTarget => _returnedAddTarget;

  Future<void> addTarget(Target target) async {
    PrintDebug().printAddTarget("Start of function addTarget");

    try {
      _returnedAddTarget = {};

      PrintDebug().printAddTarget("URI: ${API().baseUri(API.addTarget)}");

      var requestBody = {
        "personId": target.personId,
        "title": target.title,
        "description": target.description,
        "dateChosen": target.dateChosen,
        "timeFrom": target.timeFrom,
        "timeTo": target.timeTo,
      };

      PrintDebug().printAddTarget("Headers: ${API.headers}");
      PrintDebug().printAddTarget("Encoded Body: ${json.encode(requestBody)}");

      http.Response response = await http.post(
        API().baseUri(API.addTarget),
        headers: API.headers,
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        if (responseData["status"] == "0") {
          PrintDebug().printAddTarget(
              "addTarget data is failed to retrieve! Data status code ${responseData["status"]}");
        } else {
          _returnedAddTarget = responseData;
          PrintDebug().printAddTarget("Response Data: $responseData");
          PrintDebug().printAddTarget(
              "addTarget data is successfully retrieved! Data status code ${responseData["status"]}");
          notifyListeners();
        }
      } else {
        PrintDebug().printAddTarget(
            "addTarget data is successfully retrieved! Data status code ${response.statusCode}");
      }
    } catch (e) {
      PrintDebug().printAddTarget(e);
    } finally {
      PrintDebug().printAddTarget("End of function addTarget");
    }
  }

  Map<String, dynamic> _returnedDeleteTarget = {};
  Map<String, dynamic> get returnedDeleteTarget => _returnedDeleteTarget;

  Future<void> deleteTarget(int id) async {
    PrintDebug().printDeleteTarget("Start of function deleteTarget");

    try {
      _returnedDeleteTarget = {};

      PrintDebug().printDeleteTarget("URI: ${API().baseUri(API.deleteTarget)}");

      var requestBody = {"id": id};

      PrintDebug().printDeleteTarget("Headers: ${API.headers}");
      PrintDebug()
          .printDeleteTarget("Encoded Body: ${json.encode(requestBody)}");

      http.Response response = await http.post(
        API().baseUri(API.deleteTarget),
        headers: API.headers,
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        if (responseData["status"] == "0") {
          PrintDebug().printDeleteTarget(
              "deleteTarget data is failed to retrieve! Data status code ${responseData["status"]}");
        } else {
          _returnedGetTargets = responseData;
          PrintDebug().printDeleteTarget("Response Data: $responseData");
          PrintDebug().printDeleteTarget(
              "deleteTarget data is failed to retrieve! Response status code ${responseData["status"]}");

          notifyListeners();
        }
      } else {
        PrintDebug().printDeleteTarget(
            "deleteTarget data is successfully retrieved! Data status code ${response.statusCode}");
      }
    } catch (e) {
      PrintDebug().printDeleteTarget(e);
    } finally {
      PrintDebug().printDeleteTarget("End of function deleteTarget");
    }
  }
}
