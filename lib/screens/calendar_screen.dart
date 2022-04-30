import 'package:flutter/material.dart';
import 'package:splenda_epi/components/public/base_screen.dart';
import 'package:table_calendar/table_calendar.dart';

var now = DateTime.now();
var firstDay = DateTime(now.year, now.month - 3, now.day);
var lastDay = DateTime(now.year, now.month + 3, now.day);

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    Widget _child = Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TableCalendar(
            focusedDay: now,
            firstDay: firstDay,
            lastDay: lastDay,
            locale: 'pt_BR',
            currentDay: now,
          ),
        )
      ],
    );

    return BaseScreen(
      child: _child,
      navigation: true,
    );
  }
}
