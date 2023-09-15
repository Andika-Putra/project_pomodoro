// ignore_for_file: unnecessary_string_interpolations

import '../utilities/shared_prefs_utility.dart';

class API {
  static const hostRealta = "172.16.0.105:81";
  static const hostPublic = "122.102.41.37:81";

  static const addPerson = "person/addPerson";
  static const authenticatePerson = "person/authenticatePerson";
  static const getPersonDetail = "person/getPersonDetail";
  static const updatePerson = "person/updatePerson";

  static const getTargets = "target/getTargets";
  static const getTargetDetail = "target/getTargetDetail";
  static const addTarget = "target/addTarget";
  static const deleteTarget = "target/deleteTarget";
  static const updateTarget = "target/updateTarget";

  static const getPomodoroFAQs = "faq/getPomodoroFAQs";
  static const getOthersFAQs = "faq/getOthersFAQs";

  Map<String, String> headersWithoutAuth = {
    "Content-Type": "application/json",
    // "Host": "localhost:44337",
    "Host": "$hostRealta",
  };

  Map<String, String> headersWithAuth = {
    "Content-Type": "application/json",
    // "Host": "localhost:44337",
    "Host": "$hostRealta",
    "Authorization": "${SharedPrefs(key: 'token').getSharedPrefsValue}",
    "CompanyId": "ABCDE",
    "UserId": "${SharedPrefs(key: "email").getSharedPrefsValue}",
    "Accept-Language": "en",
  };

  Uri baseUri(String linkName) {
    // return Uri.parse("https://projectpomodoro-default-rtdb.asia-southeast1.firebasedatabase.app/$linkName.json");
    // return Uri.parse("http://10.0.2.2:44337/api/v1/$linkName");
    // return Uri.parse("http://172.16.2.51:44337/api/v1/$linkName");
    // return Uri.parse("http://10.17.90.95:44337/api/v1/$linkName");
    return Uri.parse("http://$hostRealta/PomodoroAPI/api/v1/$linkName");
  }
}
