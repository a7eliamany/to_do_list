import 'package:flutter/material.dart';
import 'package:todo_list/views/EditTaskPage/edit_custom_buttom_sheet.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("About", style: textStyle()),
        const SizedBox(height: 16),
        const ListTile(
          leading: Icon(Icons.info_outline),
          title: Text("Version"),
          trailing: Text(
            "1.0.0",
            style: TextStyle(color: Colors.teal, fontSize: 17),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
