import 'package:flutter/material.dart';

Map<String, Color?> categoryColors = {
  "general": Colors.green,
  "work": Colors.orange,
  "study": Colors.blue,
  "important": Colors.red[400],
  "personal": Colors.blueGrey,
  "special": Colors.purple,
};

class FastPopUpMenu extends PopupMenuItem<String> {
  FastPopUpMenu({super.key, required String value})
    : super(value: value, child: Text(value));
}

List<PopupMenuItem> categoryitems = [
  FastPopUpMenu(value: "general"),
  FastPopUpMenu(value: "personal"),
  FastPopUpMenu(value: "important"),
  FastPopUpMenu(value: "study"),
  FastPopUpMenu(value: "special"),
  FastPopUpMenu(value: "work"),
];
