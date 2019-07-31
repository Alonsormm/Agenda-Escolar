import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
class Calendario extends StatefulWidget {
  @override
  _CalendarioState createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: TableCalendar(
              builders: CalendarBuilders(),
              events: {
                DateTime.now(): [Text("hola")]
              },
              availableGestures: AvailableGestures.none,
              daysOfWeekStyle: DaysOfWeekStyle(
                  weekendStyle:
                      TextStyle(color: Color(0xFF00FFF7).withAlpha(100))),
              calendarStyle: CalendarStyle(
                  weekendStyle: TextStyle(
                    color: Color(0xFF00FFF7),
                  ),
                  outsideDaysVisible: false,
                  selectedColor: Color(0xFF00FFF7),
                  selectedStyle: TextStyle(color: Colors.black),
                  todayColor: Colors.transparent,
                  markersColor: Colors.white,
                  markersAlignment: Alignment.topCenter),
              headerStyle: HeaderStyle(
                  centerHeaderTitle: true,
                  formatButtonVisible: false,
                  leftChevronIcon: Icon(Icons.navigate_before),
                  rightChevronIcon: Icon(Icons.navigate_next)),
            ),
            color: Color(0xFF2A3A4D),
          ),
        );
  }
}