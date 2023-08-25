// ignore_for_file: prefer_final_fields

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:project_pomodoro/configurations/api.dart';
import 'package:project_pomodoro/pages/target/models/target.dart';

import '../../../utilities/print_debug_utility.dart';

class TargetController with ChangeNotifier {
  Map<String, dynamic> _returnedGetTargets = {};
  Map<String, dynamic> get returnedGetTargets => _returnedGetTargets;
  int get returnedGetTargetsLength => _returnedGetTargets["data"].length;
  late bool _returnedGetTargetsTrigger;
  bool get returnedGetTargetsTrigger => _returnedGetTargetsTrigger;
  late bool _returnedGetTargetsNoDataFlag;
  bool get returnedGetTargetsNoDataFlag => _returnedGetTargetsNoDataFlag;

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

  Future<void> getTargets() async {
    PrintDebug().printGetTargets("Start of function getTargets");

    try {
      _returnedGetTargetsTrigger = false;
      _returnedGetTargetsNoDataFlag = false;
      _returnedGetTargets = {};

      PrintDebug().printGetTargets(API().baseUri(API.getTargets));

      var requestBody = {"personId": 1};

      PrintDebug().printGetTargets(json.encode(requestBody));
      await Future.delayed(
        const Duration(seconds: 2),
        () async {
          // http.Response response =
          //     await http.get(API().baseUri(API.getTargets));

          http.Response response = await http.post(
            API().baseUri(API.getTargets),
            body: json.encode(requestBody),
          );

          _returnedGetTargets = (json.decode(response.body));

          PrintDebug().printGetTargets(_returnedGetTargets);
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

  Future<void> addTarget(Target target) async {
    await http.post(
      API().baseUri(API.targets),
      body: json.encode(
        {
          "title": target.title,
          "description": target.description,
          "date": target.date,
          "timeFrom": target.timeFrom,
          "timeTo": target.timeTo,
        },
      ),
    );
    notifyListeners();
  }

  Future<void> deleteTarget(String key) async {
    await http.delete(
      API().baseUri("${API.targets}/$key"),
    );
    notifyListeners();
  }
}
