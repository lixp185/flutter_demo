import 'package:flutter/material.dart';

/// 自定义日历组件
class CalendarDemo extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<CalendarDemo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CalendarDatePicker(
        initialDate: DateTime.now(),
        //初始化选中日期
        firstDate: DateTime(2000),
        lastDate: DateTime(2024),
        initialCalendarMode: DatePickerMode.day,
        onDateChanged: (dateTime) {
          print("onChange $dateTime");
        },
        selectableDayPredicate: (date) {
          if (date == DateTime(2023, 1, 15) ||
              date == DateTime(2023, 1, 16) ||
              date == DateTime(2023, 1, 17)) {
            return false;
          }
          return true;
        },
      ),
    );
  }
}
