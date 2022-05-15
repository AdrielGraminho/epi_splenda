import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:splenda_epi/components/public/base_screen.dart';
import 'package:table_calendar/table_calendar.dart';

import '../components/public/custom_text_label.dart';

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
    List<DateTime> dateMock = [
      now,
      DateTime(now.year, now.month, now.day - 3),
      DateTime(now.year, now.month, now.day - 1),
      DateTime(now.year, now.month, now.day + 5),
      DateTime(now.year, now.month, now.day + 10),
      DateTime(now.year, now.month, now.day + 13),
      DateTime(now.year, now.month, now.day + 25),
      DateTime(now.year, now.month + 1, now.day + 10),
      DateTime(now.year, now.month + 1, now.day + 25),
    ];

    Widget _child = Column(
      children: [
        TableCalendar(
          onDaySelected: ((selectedDay, focusedDay) => {
                Navigator.pushNamed(context, "/day_details_screen",
                    arguments: {"daySelected": focusedDay})
              }),
          calendarBuilders: CalendarBuilders(
            selectedBuilder: (context, day, focusedDay) => Container(
              margin: const EdgeInsets.all(4),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: now.isBefore(day) ? Colors.amber : Colors.red,
                  borderRadius: BorderRadius.circular(10)),
              child: Text(day.day.toString()),
            ),
          ),
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
          focusedDay: now,
          firstDay: firstDay,
          lastDay: lastDay,
          locale: 'pt_BR',
          currentDay: now,
          selectedDayPredicate: (day) {
            late bool isSelectedDate = false;
            for (DateTime dateSelect in dateMock) {
              if (dateSelect.day == day.day &&
                  dateSelect.month == day.month &&
                  dateSelect.year == day.year) {
                isSelectedDate = true;
              }
            }
            return isSelectedDate;
          },
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(color: Colors.red),
              ),
              Container(
                alignment: Alignment.center,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CustomTextLabel(text: "Data com itens em atraso"),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(color: Colors.amber),
              ),
              Container(
                alignment: Alignment.center,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CustomTextLabel(text: "Data com itens em aberto"),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    return BaseScreen(
      child: _child,
      navigation: true,
    );
  }
}
