import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

const Color pColor = Color.fromARGB(255, 22, 202, 28);
const Color sColor = Colors.blue;
const Color rejectColor = Colors.red;
const Color pendingColor = Colors.orange;
const Color acceptColor = Colors.green;
const Color doneColor = Colors.pink;
const Color backgroundColor = Colors.white;
const Color cardbackground = Color.fromARGB(255, 240, 237, 237);
const Color backgroundColorIamge = Color.fromARGB(60, 126, 125, 125);
const Color backgroundColorIamgeText = Colors.green;
Color getStatusColor(int statusReport) {
  if (statusReport == 0) {
    return Colors.orange;
  } else if (statusReport == 1) {
    return Colors.green;
  } else {
    return Colors.red;
  }
}

Color getStatusReverseColor(int statusReverse) {
  if (statusReverse == 0) {
    return Colors.orange;
  } else if (statusReverse == 1) {
    return Colors.green;
  } else {
    if (statusReverse == 2) {
      return Colors.red;
    }
    return Colors.pink;
  }
}

void message(BuildContext context, String msg, {int longTime = 3}) {
  ToastContext toastContext = ToastContext();
  toastContext.init(context);
  Toast.show(msg, duration: longTime);
}
