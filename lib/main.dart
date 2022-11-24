import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:team/info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'schedule.dart';
import 'AddAssignExam.dart';
import 'AddPersonal.dart';
import 'AddSubject.dart';
import 'AddList.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: '팀프로젝트'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    Home(),
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

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {         // 메인 페이지
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
        actions: [ // 오른쪽에 버튼 추가
          IconButton(
              icon: const Icon(
                Icons.add,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context){
                      return const AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(22.0))),
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
            TableCalendar(
              firstDay: DateTime(2022, 11, 1),
              lastDay: DateTime(2022, 12, 30),
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
            Center(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50), //모서리를 둥글게
                    border: Border.all(color: Colors.black12, width: 3)), //테두리
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
