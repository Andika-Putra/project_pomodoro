import 'package:flutter/material.dart';

class API {
  Uri baseUri(String linkName) {
    return Uri.parse(
        "https://projectpomodoro-default-rtdb.asia-southeast1.firebasedatabase.app/${linkName}.json");
  }
}
