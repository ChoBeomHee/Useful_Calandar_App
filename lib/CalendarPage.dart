import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:team/AddList.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:team/calendar/meeting_data_source.dart';
import 'calendar/meeting.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {         // 메인 페이지

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
    DateTime(today.year, today.month, today.day, 0, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    //final DateTime endTime = DateTime(2022,12,25, 12, 0, 0);
    meetings.add(Meeting('Conference', startTime, endTime, const Color(0xFF7D9DE2)));
    meetings.add(Meeting('Conference2', startTime, endTime, const Color(0xFF7D9DE2)));
    return meetings;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Scaffold(
        body: SfCalendar(
          //showDatePickerButton: true,
          showNavigationArrow: true,
          view: CalendarView.month ,
          initialSelectedDate: DateTime.now(),
          initialDisplayDate: DateTime.now(),
          headerStyle: CalendarHeaderStyle(
            textAlign: TextAlign.center,
            textStyle: TextStyle(fontSize: 21)
          ),
          dataSource: MeetingDataSource(_getDataSource()),
          monthViewSettings: MonthViewSettings(
              appointmentDisplayCount: 3,
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
              navigationDirection: MonthNavigationDirection.horizontal,
              agendaViewHeight: 120,
              agendaItemHeight: 50,
              showAgenda: true),
        ),
      ),
    );
  }
}