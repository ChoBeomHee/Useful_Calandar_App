import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:team/AddList.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:team/calendar/meeting_data_source.dart';
import 'calendar/meeting.dart';
import 'package:provider/provider.dart';
import 'package:team/SubjectsProvider.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {         // 메인 페이지
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;
  void getCurrentUser() {
    try {
      final user = _authentication.currentUser; // _authentication 의 currentUser을 대입
      if (user != null) {
        loggedUser = user;
      }
    } catch (e) {
      print(e);
    }
  }



  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
    DateTime(today.year, today.month, today.day, 0, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));

    meetings.add(Meeting('Conference', startTime, endTime, const Color(0xFF7D9DE2)));

    if(context.read<Subs>().day.length != 0){
      meetings.add(Meeting('TTEXT', startTime, endTime, const Color(0xFF7D9DE2)));
    }
    print(context.read<Subs>().day.length);
    return meetings;
  }

  @override
  Widget build(BuildContext context) {
    print('캘린더페이지 빌드');
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Scaffold(
        body: SafeArea(
          child: SfCalendar(
            //showDatePickerButton: true,
            showNavigationArrow: true,
            view: CalendarView.month ,
            initialSelectedDate: DateTime.now(),
            initialDisplayDate: DateTime.now(),
            headerStyle: const CalendarHeaderStyle(
              textAlign: TextAlign.center,
              textStyle: TextStyle(fontSize: 21)
            ),
            dataSource: MeetingDataSource(_getDataSource()),
            monthViewSettings: const MonthViewSettings(
                appointmentDisplayCount: 3,
                appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                navigationDirection: MonthNavigationDirection.horizontal,
                agendaViewHeight: 120,
                agendaItemHeight: 50,
                showAgenda: true),
          ),
        ),
      ),
    );
  }
}