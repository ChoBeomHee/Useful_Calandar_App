import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_calendar/table_calendar.dart';
import 'schedule.dart';
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


class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {         // 메인 페이지
  // 달력 정보를 저장할 변수
  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focuseDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('팀프로젝트'),
        actions: [
          IconButton(
              onPressed: (){
                FirebaseAuth.instance.signOut();
                //Navigator.pop(context);
              },
              icon: const Icon(Icons.logout)),
          // 오른쪽 상단에 add 버튼
          IconButton(
              icon: const Icon(
                Icons.add,
              ),
              onPressed: () {
                // add 버튼을 눌렀을 때 팝업창 뜸
                // 팝업 메세지를 뜨게 하려면, showDialog 와 AlertDialog 2개를 써야함
                showDialog(
                    context: context,
                    // barrierDismissible 는 팝업 메세지가 띄어졌을 때 뒷 배경의 touchEvent 가능 여부에 대한 값
                    // true: 뒷 배경 touch 하면 팝업 메세지가 닫힘, false: 안 닫힘
                    barrierDismissible: true,
                    builder: (BuildContext context){
                      return const AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(22.0))), // 모서리를 둥글게
                        // 팝업 메세지에 addList 를 불러옴
                        content: addList(),
                      );
                    }
                );
              }
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            // 달력 위젯
            TableCalendar(
              // 달력에서 나타날 최소 날짜와 최대 날짜 설정
              firstDay: DateTime(2022, 10, 1),
              lastDay: DateTime(2023, 1, 31),
              focusedDay: focuseDay,

              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  this.selectedDay = selectedDay;
                  this.focuseDay = focusedDay;
                });
              },
              selectedDayPredicate: (DateTime day) {
                return isSameDay(selectedDay, day);
              },
            ),

            const SizedBox(height: 30,),
            // 상세 과목 일정을 나타냄
            // 상세 과목 일정 나타내야함 ◀◀◀◀◀◀
            Center(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50), // 모서리를 둥글게
                    border: Border.all(color: Colors.black12, width: 3)), // 테두리
                width: 550,
                height: 150,
                child: const Text('\n    깃 브랜치 나누기 연습 ', style: TextStyle(fontSize: 30),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}