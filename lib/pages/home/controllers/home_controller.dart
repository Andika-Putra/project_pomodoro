// ignore_for_file: prefer_final_fields

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:project_pomodoro/utilities/print_debug_utility.dart';

class HomeController with ChangeNotifier {
  Map<String, dynamic> _returnedGetPomodoroFaqs = {};
  Map<String, dynamic> get returnedGetPomodoroFaqs => _returnedGetPomodoroFaqs;
  int get returnedGetPomodoroFaqsLength =>
      _returnedGetPomodoroFaqs["data"].length;
  List<bool> _returnedGetPomodoroFaqsIsExpanded = [];
  List<bool> get returnedGetPomodoroFaqsIsExpanded =>
      _returnedGetPomodoroFaqsIsExpanded;

  Future<void> getPomodoroFaqs() async {
    PrintDebug().printGetPomodoroFaqs("Start of function getPomodoroFaqs");

    try {
      _returnedGetPomodoroFaqs = {};
      _returnedGetPomodoroFaqsIsExpanded = [];
      await Future.delayed(
        const Duration(seconds: 2),
        () {
          var jsonStringData = ''' 
          {
            "data": [
              {"question":"What is Pomodoro Technique?", "answer":"Pomodoro Technique is a time management method based on 25 minutes of focused target followed with 5 minutes of break", "isExpanded":0},
              {"question":"Why using Pomodoro Technique?", "answer":"Pomodoro Technique focuses on breaking down large tasks into smaller, more manageable ones. Ultimately, it allows you to focus better and spread out your productivity levels throughout the day", "isExpanded":0}
            ]
          }
          ''';

          _returnedGetPomodoroFaqs = jsonDecode(jsonStringData);
          for (int i = 0; i < _returnedGetPomodoroFaqs["data"].length; i++) {
            _returnedGetPomodoroFaqsIsExpanded.add(false);
          }
          PrintDebug().printGetPomodoroFaqs(_returnedGetPomodoroFaqs["data"]);
          PrintDebug().printGetPomodoroFaqs(_returnedGetPomodoroFaqsIsExpanded);
        },
      );

      notifyListeners();
    } catch (e) {
      PrintDebug().printGetPomodoroFaqs(e);
    } finally {
      PrintDebug().printGetPomodoroFaqs("End of function getPomodoroFaqs");
    }
  }

  Map<String, dynamic> _returnedGetOtherFaqs = {};
  Map<String, dynamic> get returnedGetOtherFaqs => _returnedGetOtherFaqs;
  int get returnedGetOtherFaqsLength => _returnedGetPomodoroFaqs["data"].length;
  List<bool> _returnedGetOtherFaqsIsExpanded = [];
  List<bool> get returnedGetOtherFaqsIsExpanded =>
      _returnedGetPomodoroFaqsIsExpanded;

  Future<void> getOtherFaqs() async {
    PrintDebug().printGetPomodoroFaqs("Start of function getOtherFaqs");

    try {
      _returnedGetOtherFaqs = {};
      _returnedGetOtherFaqsIsExpanded = [];
      await Future.delayed(
        const Duration(seconds: 2),
        () {
          var jsonStringData = ''' 
          {
            "data": [
              {"question":"Who created this application?", "answer":"This application is created by Andika Putra, a Developer whom had graduated (3.5 years) from Bina Nusantara University, majoring Computer Science, specializing Software Engineering with GPA 3.28 out of 4.00. He had done making application with Android Studio (Java) and is currently pursuing his dream by learning Flutter (Dart) in order to create another amazing apps!", "isExpanded":0},
              {"question":"Why the developer wanted to create this application?", "answer":"He wanted to help people (mainly student) who doesn’t have a good time management so that they could do their task little by little until its task done", "isExpanded":0}
            ]
          }
          ''';

          _returnedGetOtherFaqs = jsonDecode(jsonStringData);
          for (int i = 0; i < _returnedGetOtherFaqs["data"].length; i++) {
            _returnedGetPomodoroFaqsIsExpanded.add(false);
          }
          PrintDebug().printGetPomodoroFaqs(_returnedGetOtherFaqs["data"]);
          PrintDebug().printGetPomodoroFaqs(_returnedGetOtherFaqsIsExpanded);
        },
      );

      notifyListeners();
    } catch (e) {
      PrintDebug().printGetPomodoroFaqs(e);
    } finally {
      PrintDebug().printGetPomodoroFaqs("End of function getPomodoroFaqs");
    }
  }
}
