import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

myFlushBar({
  required BuildContext context,
  required String message,
  Duration? duration,
  Color? color,
}) {
  Flushbar(
    message: message,
    duration: (duration == null) ? Duration(seconds: 2) : duration,
    backgroundColor: (color == null) ? Colors.green : color,
    margin: EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(8),
    flushbarPosition: FlushbarPosition.TOP,
    animationDuration: Duration(milliseconds: 500),
  ).show(context);
}
