// ignore_for_file: avoid_print

class PrintDebug {
  String functionName = "getTargetDetail";

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

  void printGetTargetDetail(message) {
    if (functionName == "getTargetDetail") {
      print(message);
    }
  }

  void printAddTarget(message) {
    if (functionName == "addTarget") {
      print(message);
    }
  }

  void printDeleteTarget(message) {
    if (functionName == "deleteTarget") {
      print(message);
    }
  }
}
