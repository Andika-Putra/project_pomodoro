class API {
  static const targets = "targets";
  static const profile = "profile";
  static const getTargets = "target/getTargets";
  static const getTargetDetail = "target/getTargetDetail";
  static const addTarget = "target/addTarget";
  static const deleteTarget = "target/deleteTarget";

  static const headers = {
    "Content-Type": "application/json",
    "Host": "localhost:44337",
  };

  Uri baseUri(String linkName) {
    // return Uri.parse("https://projectpomodoro-default-rtdb.asia-southeast1.firebasedatabase.app/$linkName.json");
    return Uri.parse("http://10.0.2.2:44337/api/v1/$linkName");
  }
}
