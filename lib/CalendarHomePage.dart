import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_calendar/table_calendar.dart';
import 'schedule.dart';
import 'package:team/CalendarPage.dart';
import 'AddAssignExam.dart';
import 'AddPersonal.dart';
import 'AddSubject.dart';
import 'AddList.dart';
import 'info.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CalendarHomePage extends StatefulWidget {
  const CalendarHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<CalendarHomePage> createState() => _CalendarHomePageState();
}

class _CalendarHomePageState extends State<CalendarHomePage> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    CalendarPage(),
    ScheduleDetail(),
    SubjectInfo(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {    // 메인
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.subject), label: '상세 일정'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: '과목 정보'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

