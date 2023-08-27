class API {
  static const targets = "targets";
  static const profile = "profile";

  Uri baseUri(String linkName) {
    // return Uri.parse("https://projectpomodoro-default-rtdb.asia-southeast1.firebasedatabase.app/$linkName.json");
    return Uri.parse("http://10.0.2.2:44337/api/v1/$linkName");
  }

  static const getTargets = "target/getTargets";
}
