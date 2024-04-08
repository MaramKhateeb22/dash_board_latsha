import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

const Color pColor = Colors.green;
const Color sColor = Colors.blue;
const Color backgroundColor = Color.fromARGB(255, 187, 245, 189);

void message(BuildContext context, String msg, {int longTime = 3}) {
  ToastContext toastContext = ToastContext();
  toastContext.init(context);
  Toast.show(msg, duration: longTime);
}
