import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:team/main.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
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
    Text('개발 전'),
    Text('개발 전'),
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
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.subject), label: '일정'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: '과목'),
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
        title: Text('팀프로젝트'),
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
                      return AlertDialog(
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

            SizedBox(height: 30,),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50), //모서리를 둥글게
                    border: Border.all(color: Colors.black12, width: 3)), //테두리
                width: 550,
                height: 150,
                child: Text('\n    이나연깃233..일까?', style: TextStyle(fontSize: 30),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class addList extends StatelessWidget {         // 추가
  const addList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () { // 과목
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('과목추가'),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(12.0))),
                        content: AddSubjects(),
                      );
                    }
                );
              },
              child: Text(
                "과목 추가", style: TextStyle(fontSize: 25, color: Colors.black),),
              style: OutlinedButton.styleFrom(
                  primary: Colors.green,
                  side: BorderSide(
                    color: Colors.deepPurpleAccent,
                    width: 3.5,
                  )
              ),
            ),
            const SizedBox(height: 20,),
            OutlinedButton(
              onPressed: () {},
              child: Text("과제/시험 일정 추가",
                style: TextStyle(fontSize: 25, color: Colors.black),),
              style: OutlinedButton.styleFrom(
                primary: Colors.green,
                side: BorderSide(
                  color: Colors.deepPurpleAccent,
                  width: 3.5,
                ),
              ),
            ),
            const SizedBox(height: 20,),
            OutlinedButton(
              onPressed: () {},
              child: Text("개인 일정 추가",
                style: TextStyle(fontSize: 25, color: Colors.black),),
              style: OutlinedButton.styleFrom(
                  primary: Colors.green,
                  side: BorderSide(
                    color: Colors.deepPurpleAccent,
                    width: 3.5,
                  )
              ),
            ),
            SizedBox(height: 20,),
          ]
      ),
    );
  }
}

class AddSubjects extends StatefulWidget {
  const AddSubjects({Key? key}) : super(key: key);

  @override
  State<AddSubjects> createState() => _AddSubjectsState();
}

class _AddSubjectsState extends State<AddSubjects> {
  bool _ischecked = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('과목'),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 40,
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '과목명',
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 40,
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '학점',
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text('평가 비율'),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 40,
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '중간고사',
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 40,
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '기말고사',
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 40,
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '과제',
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 40,
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '출결',
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          CheckboxListTile(
            title: const Text('영어 강의 여부'),
            value: _ischecked,
            onChanged: (value){
              setState(() {
                _ischecked = value!;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          OutlinedButton(
            onPressed: (){},
            child:const Text('확인'),
          ),
        ],
      ),
    );
  }
}

