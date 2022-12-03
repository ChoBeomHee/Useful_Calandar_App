import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:team/LoginPage.dart';
import 'schedule.dart';
import 'package:team/CalendarPage.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'AddAssignExam.dart';
import 'AddPersonal.dart';
import 'AddSubject.dart';
import 'AddList.dart';
import 'info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'SubjectsProvider.dart';
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
  Widget build(BuildContext context) {
    // 메인
    return Scaffold(
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        // this is ignored if animatedIcon is non null
        // child: Icon(Icons.add),
        visible: true,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
            child: Icon(Icons.accessibility),
            backgroundColor: Colors.lightBlueAccent,
            label: '과목',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () =>
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) =>
                      AlertDialog(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(22.0))),
                        title: Container(
                          child: Column(
                            children: const [
                              AddSubjects(),
                            ],
                          ),
                        ),
                        scrollable: true,
                      ),
                ),
          ),
          SpeedDialChild(
            child: Icon(Icons.brush),
            backgroundColor: Colors.lightBlueAccent,
            label: '과제/시험',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () =>
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) =>
                      AlertDialog(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(22.0))),
                        title: Container(
                          child: Column(
                            children: const [
                              AddAssignExam(),
                            ],
                          ),
                        ),
                        scrollable: true,
                      ),
                ),
          ),
          SpeedDialChild(
            child: Icon(Icons.score),
            backgroundColor: Colors.lightBlueAccent,
            label: '개인 일정',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () =>
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) =>
                      AlertDialog(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(22.0))),
                        title: Container(
                          child: Column(
                            children: const [
                              AddPersonal(),
                            ],
                          ),
                        ),
                        scrollable: true,
                      ),
                ),
          ),
          SpeedDialChild(
            child: Icon(Icons.score),
            backgroundColor: Colors.lightBlueAccent,
            label: '로그아웃',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () =>
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) =>
                      AlertDialog(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(22.0))),
                        title: Container(
                          child: Column(
                            children: [
                              const Text('로그아웃'),
                              SizedBox(height: 30,),
                              OutlinedButton(
                                onPressed: () {
                                  FirebaseAuth.instance.signOut(); // 로그아웃
                                },
                                child: const Text('확인')),
                              // 이 부분에 함수 넣으면 됨
                            ],
                          ),
                        ),
                      ),
                ),
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
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

