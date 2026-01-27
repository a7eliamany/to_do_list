import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_list/Extensions/time_of_day_ext.dart';

class MyCleneder extends StatelessWidget {
  const MyCleneder({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
            ),
            AnimatedButton(
              color: Colors.blueGrey,
              pressEvent: () async {
                TimeOfDay time = TimeOfDay.now();
                final parts = time.to12HourFormat();
                print(parts.split(" "));
              },
            ),
          ],
        ),
      ),
    );
  }
}
