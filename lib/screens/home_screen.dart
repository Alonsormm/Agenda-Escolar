import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Card(color: Colors.blueGrey, child: TableCalendar(calendarStyle: CalendarStyle(selectedColor: Colors.red),),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        ],
      ),
    );
  }
}