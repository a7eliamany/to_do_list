import 'package:flutter/material.dart';

extension TimeFormat on TimeOfDay {
  String to12HourFormat() {
    final hour = hourOfPeriod == 0 ? 12 : hourOfPeriod;
    final minuteStr = minute.toString().padLeft(2, '0');
    final periodStr = period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minuteStr $periodStr';
  }
}

extension StringToTimeOfDay on String {
  TimeOfDay toTimeOfDay12h() {
    final parts = split(' ');
    final hm = parts[0].split(':');
    int hour = int.parse(hm[0]);
    final int minute = int.parse(hm[1]);

    if (parts[1] == 'PM' && hour != 12) hour += 12;
    if (parts[1] == 'AM' && hour == 12) hour = 0;

    return TimeOfDay(hour: hour, minute: minute);
  }
}
// extension StringDate on DateTime{
//   String stringDate(){

//   }
// }
