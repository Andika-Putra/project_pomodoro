// ignore_for_file: avoid_print

class PrintDebug {
  String functionName = "getTargets";

  void printGetPomodoroFaqs(message) {
    if (functionName == "getPomodoroFaqs") {
      print(message);
    }
  }

  void printGetTargets(message) {
    if (functionName == "getTargets") {
      print(message);
    }
  }
}
