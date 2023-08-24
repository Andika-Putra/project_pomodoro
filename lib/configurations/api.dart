class API {
  static const targets = "targets";
  static const profile = "profile";

  Uri baseUri(String linkName) {
    return Uri.parse(
        "https://projectpomodoro-default-rtdb.asia-southeast1.firebasedatabase.app/$linkName.json");
  }
}
