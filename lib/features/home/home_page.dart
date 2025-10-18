import 'package:dayboss/core/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:awesome_calendart/awesome_calendart.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.cardBackground,
      appBar: AppBar(
        backgroundColor: ColorManager.primaryColor,
        title: Row(
          children: [
            Text("أهلاً بك ", style: TextStyle(color: ColorManager.secColor)),
            Text("محمد علي النعيمي"),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: ColorManager.lightPrimaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                border: BoxBorder.all(color: ColorManager.primaryColor),
              ),
              child: TableCalendar(
                firstDay: DateTime.utc(2025, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: DateTime.now(),
                calendarFormat: CalendarFormat.week,
                headerStyle: const HeaderStyle(
                  titleTextStyle: TextStyle(color: ColorManager.secColor),
                ),
                calendarStyle: const CalendarStyle(
                  defaultTextStyle: TextStyle(color: ColorManager.primaryDark),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
