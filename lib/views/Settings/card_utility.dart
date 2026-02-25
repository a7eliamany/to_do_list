import 'package:flutter/material.dart';
import 'package:todo_list/services/local_storage.dart';

class CardUtilty extends StatefulWidget {
  const CardUtilty({super.key, required this.title, required this.iconData});
  final String title;
  final IconData iconData;

  @override
  State<CardUtilty> createState() => _CardUtiltyState();
}

class _CardUtiltyState extends State<CardUtilty> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Icon(widget.iconData),
        title: Text(widget.title),
        trailing: Switch(
          value: LocalStorage.instance.getBool(widget.title) ?? false,
          onChanged: (val) {
            LocalStorage.instance.setBool(widget.title, val);
            setState(() {});
          },
          activeThumbColor: Colors.teal,
        ),
      ),
    );
  }
}
