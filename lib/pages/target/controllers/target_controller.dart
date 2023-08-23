import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../utilities/print_debug_utility.dart';

class TargetController with ChangeNotifier {
  Map<String, dynamic> _returnedGetTargets = {};
  Map<String, dynamic> get returnedGetTargets => _returnedGetTargets;
  int get returnedGetTargetsLength => _returnedGetTargets["data"].length;

  Future<void> getTargets() async {
    PrintDebug().printGetTargets("Start of function getTargets");

    try {
      _returnedGetTargets = {};
      await Future.delayed(
        const Duration(seconds: 2),
        () {
          var jsonStringData = ''' 
          {
            "data": [
              {
                "title":"Create Home Page design",
                "dateTimeFrom":"2023-08-23 09:20:00",
                "dateTimeTo":"2023-08-23 12:00:00",
                "description":"create the home business process and its user interface"
              },
              {
                "title":"Think of Pomodoro Feature ideas ",
                "dateTimeFrom":"2023-08-23 12:00:00",
                "dateTimeTo":"2023-08-23 14:00:00",
                "description":"Think of what will you bring to potential user. Make them sure that this application is valuable!"
              }
            ]
          }
          ''';

          _returnedGetTargets = jsonDecode(jsonStringData);
          PrintDebug().printGetTargets(_returnedGetTargets["data"]);
        },
      );

      notifyListeners();
    } catch (e) {
      PrintDebug().printGetTargets(e);
    } finally {
      PrintDebug().printGetTargets("End of function getTargets");
    }
  }
}
