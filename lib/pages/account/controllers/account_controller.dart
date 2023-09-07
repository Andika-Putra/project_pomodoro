// ignore_for_file: prefer_final_fields

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:project_pomodoro/pages/account/models/person.dart';
import 'package:project_pomodoro/utilities/shared_prefs_utility.dart';

import '../../../configurations/api.dart';
import '../../../utilities/print_debug_utility.dart';

class AccountController with ChangeNotifier {
  Map<String, dynamic> _returnedAuthenticatePerson = {};
  Map<String, dynamic> get returnedAuthenticatePerson =>
      _returnedAuthenticatePerson;

  Future<void> authenticatePerson(String email) async {
    PrintDebug()
        .printAuthenticatePerson("Start of function authenticatePerson");

    try {
      _returnedAuthenticatePerson = {};

      PrintDebug().printAuthenticatePerson(
          "URI: ${API().baseUri(API.authenticatePerson)}");

      var requestBody = {"email": email};

      PrintDebug()
          .printAuthenticatePerson("Headers: ${API().headersWithoutAuth}");
      PrintDebug()
          .printAuthenticatePerson("Encoded Body: ${json.encode(requestBody)}");

      await Future.delayed(
        const Duration(seconds: 2),
        () async {
          http.Response response = await http.post(
            API().baseUri(API.authenticatePerson),
            headers: API().headersWithoutAuth,
            body: json.encode(requestBody),
          );

          if (response.statusCode == 200) {
            var responseData = json.decode(response.body);
            if (responseData["status"] == "0") {
              PrintDebug().printAuthenticatePerson(
                  "authenticatePerson data is failed to retrieve! Data status code ${responseData["status"]}");
            } else {
              _returnedAuthenticatePerson = responseData;
              PrintDebug()
                  .printAuthenticatePerson("Response Data: $responseData");
              PrintDebug().printAuthenticatePerson(
                  "authenticatePerson data is successfully retrieved! Data status code ${responseData["status"]}");

              SharedPrefs().deleteSharedPrefs('id');
              SharedPrefs().deleteSharedPrefs('email');
              SharedPrefs().deleteSharedPrefs('token');

              SharedPrefs()
                  .setSharedPrefs('id', responseData["data"]["id"].toString());
              SharedPrefs().setSharedPrefs('email', email);
              SharedPrefs()
                  .setSharedPrefs('token', responseData["data"]["token"]);

              PrintDebug().printAuthenticatePerson(
                  "SharedPreferences id: ${SharedPrefs(key: 'id').getSharedPrefsValue}");
              PrintDebug().printAuthenticatePerson(
                  "SharedPreferences email: ${SharedPrefs(key: 'email').getSharedPrefsValue}");
              PrintDebug().printAuthenticatePerson(
                  "SharedPreferences token: ${SharedPrefs(key: 'token').getSharedPrefsValue}");

              notifyListeners();
            }
          } else {
            PrintDebug().printAuthenticatePerson(
                "authenticatePerson data is failed to retrieve! Response status code ${response.statusCode}");
          }
        },
      );
    } catch (e) {
      PrintDebug().printAuthenticatePerson(e);
    } finally {
      PrintDebug()
          .printAuthenticatePerson("End of function authenticatePerson");
    }
  }

  Map<String, dynamic> _returnedAddPerson = {};
  Map<String, dynamic> get returnedAddPerson => _returnedAddPerson;

  Future<void> addPerson(String name, String email) async {
    PrintDebug().printAddPerson("Start of function addPerson");

    try {
      _returnedAddPerson = {};

      PrintDebug().printAddPerson("URI: ${API().baseUri(API.addPerson)}");

      var requestBody = {
        "name": name,
        "email": email,
      };

      PrintDebug().printAddPerson("Headers: ${API().headersWithoutAuth}");
      PrintDebug().printAddPerson("Encoded Body: ${json.encode(requestBody)}");

      await Future.delayed(
        const Duration(seconds: 2),
        () async {
          http.Response response = await http.post(
            API().baseUri(API.addPerson),
            headers: API().headersWithoutAuth,
            body: json.encode(requestBody),
          );

          if (response.statusCode == 200) {
            var responseData = json.decode(response.body);
            if (responseData["status"] == "0") {
              PrintDebug().printAddPerson(
                  "addPerson data is failed to retrieve! Data status code ${responseData["status"]}");
            } else {
              _returnedAuthenticatePerson = responseData;
              PrintDebug().printAddPerson("Response Data: $responseData");
              PrintDebug().printAddPerson(
                  "addPerson data is successfully retrieved! Data status code ${responseData["status"]}");

              notifyListeners();
            }
          } else {
            PrintDebug().printAddPerson(
                "addPerson data is failed to retrieve! Response status code ${response.statusCode}");
          }
        },
      );
    } catch (e) {
      PrintDebug().printAddPerson(e);
    } finally {
      PrintDebug().printAddPerson("End of function addPerson");
    }
  }

  Map<String, dynamic> _returnedGetPersonDetail = {};
  Map<String, dynamic> get returnedGetPersonDetail => _returnedGetPersonDetail;

  Future<void> getPersonDetail(int id) async {
    PrintDebug().printGetPersonDetail("Start of function getPersonDetail");

    try {
      _returnedGetPersonDetail = {};

      PrintDebug()
          .printGetPersonDetail("URI: ${API().baseUri(API.getPersonDetail)}");

      var requestBody = {"id": id};

      PrintDebug().printGetPersonDetail("Headers: ${API().headersWithAuth}");
      PrintDebug()
          .printGetPersonDetail("Encoded Body: ${json.encode(requestBody)}");

      await Future.delayed(
        const Duration(milliseconds: 1200),
        () async {
          http.Response response = await http.post(
            API().baseUri(API.getPersonDetail),
            headers: API().headersWithAuth,
            body: json.encode(requestBody),
          );

          if (response.statusCode == 200) {
            var responseData = json.decode(response.body);
            if (responseData["status"] == "0") {
              PrintDebug().printGetPersonDetail(
                  "getPersonDetail data is failed to retrieve! Data status code ${responseData["status"]}");
            } else {
              _returnedGetPersonDetail = responseData;
              PrintDebug().printGetPersonDetail("Response Data: $responseData");
              PrintDebug().printGetPersonDetail(
                  "getPersonDetail data is successfully retrieved! Data status code ${responseData["status"]}");
              notifyListeners();
            }
          } else {
            PrintDebug().printGetPersonDetail(
                "getPersonDetail data is failed to retrieve! Response status code ${response.statusCode}");
          }
        },
      );
    } catch (e) {
      PrintDebug().printGetPersonDetail(e);
    } finally {
      PrintDebug().printGetPersonDetail("End of function getPersonDetail");
    }
  }

  Map<String, dynamic> _returnedUpdatePerson = {};
  Map<String, dynamic> get returnedUpdatePerson => _returnedUpdatePerson;

  Future<void> updatePerson(Person person) async {
    PrintDebug().printUpdatePerson("Start of function updatePerson");

    try {
      _returnedUpdatePerson = {};

      PrintDebug().printUpdatePerson("URI: ${API().baseUri(API.updatePerson)}");

      var requestBody = {
        "id": int.parse(SharedPrefs(key: 'id').getSharedPrefsValue),
        "name": person.name,
        "dream": person.dream,
      };

      PrintDebug().printUpdatePerson("Headers: ${API().headersWithoutAuth}");
      PrintDebug()
          .printUpdatePerson("Encoded Body: ${json.encode(requestBody)}");

      http.Response response = await http.post(
        API().baseUri(API.updatePerson),
        headers: API().headersWithAuth,
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        if (responseData["status"] == "0") {
          PrintDebug().printUpdatePerson(
              "updatePerson data is failed to retrieve! Data status code ${responseData["status"]}");
        } else {
          _returnedUpdatePerson = responseData;
          PrintDebug().printUpdatePerson("Response Data: $responseData");
          PrintDebug().printUpdatePerson(
              "updatePerson data is successfully retrieved! Data status code ${responseData["status"]}");

          notifyListeners();
        }
      } else {
        PrintDebug().printUpdatePerson(
            "updatePerson data is failed to retrieve! Response status code ${response.statusCode}");
      }
    } catch (e) {
      PrintDebug().printUpdatePerson(e);
    } finally {
      PrintDebug().printUpdatePerson("End of function updatePerson");
    }
  }

  Future<void> signOut() async {
    SharedPrefs().clearSharedPrefs();

    PrintDebug().printSignOut("All prefs is successfully removed.");
  }
}
