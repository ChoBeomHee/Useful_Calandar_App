import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:team/main.dart';
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
        primarySwatch: Colors.blue,
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
    Text(
      '개발 전',
    ),
    Text(
      '개발 전',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          showDialog(

              context: context,
            barrierDismissible: true,
            builder: (BuildContext context){
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(22.0))),
                  content: const addList(),

                );
            }
          );
        },
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _selectedDay;
  var _focusedDay = DateTime.now();
  var _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('팀프로젝트'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TableCalendar(
              firstDay: DateTime(2022, 11, 1),
              lastDay: DateTime(2022, 12, 1),
              focusedDay: _focusedDay,

              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
            ),

            SizedBox(height: 30,),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50), //모서리를 둥글게
                    border: Border.all(color: Colors.black12, width: 3)), //테두리
                width: 550,
                height: 180,
                child: Text('\n     여기에 일정', style: TextStyle(fontSize: 30),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class addList extends StatelessWidget {
  const addList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () {},
              child: Text("과목 추가", style: TextStyle(fontSize: 25, color: Colors.black), ),
              style: OutlinedButton.styleFrom(
                  primary: Colors.green,
                  side: BorderSide(
                    color: Colors.deepPurpleAccent,
                    width: 3.5,
                  )
              ),
            ),
            SizedBox(height: 20,),
            OutlinedButton(
              onPressed: () {},
              child: Text("과제/시험 일정 추가", style: TextStyle(fontSize: 25, color: Colors.black), ),
              style: OutlinedButton.styleFrom(
                  primary: Colors.green,
                  side: BorderSide(
                      color: Colors.deepPurpleAccent,
                      width: 3.5,
                  )
              ),
            ),
            SizedBox(height: 20,),
            OutlinedButton(
              onPressed: () {},
              child: Text("개인 일정 추가", style: TextStyle(fontSize: 25, color: Colors.black), ),
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
