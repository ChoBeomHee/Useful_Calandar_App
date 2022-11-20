import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:team/info.dart';
import 'package:team/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'schedule.dart';

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
                child: const Text('\n    진성 깃 일까??', style: TextStyle(fontSize: 30),),
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
                      return const AlertDialog(
                        title: Text('과목추가'),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(12.0))),
                        content: AddSubjects(),
                      );
                    }
                );
              },
              child: const Text(
                "과목 추가", style: TextStyle(fontSize: 25, color: Colors.black),),
              style: OutlinedButton.styleFrom(
                  primary: Colors.deepPurple,
                  side: const BorderSide(
                    color: Colors.deepPurpleAccent,
                    width: 3.5,
                  )
              ),
            ),
            const SizedBox(height: 20,),
            OutlinedButton(
              onPressed: () {
                showDialog(context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context){
                      return const AlertDialog(
                        title: Text('과제/시험 일정 추가'),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                        content: AddAssignExam(),
                      );
                    });
              },
              child: const Text("과제/시험 일정 추가",
                style: const TextStyle(fontSize: 25, color: Colors.black),),
              style: OutlinedButton.styleFrom(
                primary: Colors.deepPurple,
                side: const BorderSide(
                  color: Colors.deepPurpleAccent,
                  width: 3.5,
                ),
              ),
            ),
            const SizedBox(height: 20,),
            OutlinedButton(
              onPressed: () {
                showDialog(context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context){
                      return const AlertDialog(
                        title: Text('개인 일정 추가'),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                        content: AddPersonal(),
                      );
                });
              },
              child: const Text("개인 일정 추가",
                style: const TextStyle(fontSize: 25, color: Colors.black),),
              style: OutlinedButton.styleFrom(
                  primary: Colors.deepPurple,
                  side: const BorderSide(
                    color: Colors.deepPurpleAccent,
                    width: 3.5,
                  )
              ),
            ),
            const SizedBox(height: 100,),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("닫기",
                style: const TextStyle(fontSize: 25, color: Colors.black),),
              style: OutlinedButton.styleFrom(
                  primary: Colors.deepPurple,
                  side: const BorderSide(
                    color: Colors.deepPurpleAccent,
                    width: 3.5,
                  )
              ),
            ),
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
  bool? _ischecked = false;
  int? MidTest = 0;
  int? FinalTest = 0;
  int? task = 0;
  int? attendance = 0;
  String? Subject = '';
  double? credit = 0;

  @override
  Widget build(BuildContext context) {
    final _controller1 = TextEditingController();
    final _controller2 = TextEditingController();
    final _controller3 = TextEditingController();
    final _controller4 = TextEditingController();
    final _controller5 = TextEditingController();
    final _controller6 = TextEditingController();

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
              controller: _controller1,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '과목명',
              ),
              onChanged: (value) {
                Subject = value;
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 40,
            child: TextFormField(
              controller: _controller2,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '학점',
              ),
              onChanged: (value) {
                credit = double.parse(value);
              },
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
              controller: _controller3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '중간고사',
              ),
              onChanged: (value) {
                MidTest = int.parse(value);
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 40,
            child: TextFormField(
              controller: _controller4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '기말고사',
              ),
              onChanged: (value) {
                FinalTest = int.parse(value);
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 40,
            child: TextFormField(
              controller: _controller5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '과제',
              ),
              onChanged: (value) {
                task = int.parse(value);
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 40,
            child: TextFormField(
              controller: _controller6,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '출결',
              ),
              onChanged: (value) {
                attendance = int.parse(value);
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          CheckboxListTile(
            title: const Text('영어 강의 여부'),
            value: _ischecked,
            onChanged: (value) {
              setState(() {
                _ischecked = value!;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          OutlinedButton(
            onPressed: () async {
             final subjectadd = FirebaseFirestore.instance.collection('Subject').doc(Subject);
              subjectadd.set({
                "Midterm" : MidTest,
                "Finalterm" : FinalTest,
                "task" : task,
                "credit" : credit,
                "attandence" : attendance,
                "English" : _ischecked,
                "SubjectName" : Subject,
              });
             _controller1.clear();
             _controller2.clear();
             _controller3.clear();
             _controller4.clear();
             _controller5.clear();
             _controller6.clear();
             Navigator.of(context).pop();
            },
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }
}

class AddAssignExam extends StatefulWidget {
  const AddAssignExam({Key? key}) : super(key: key);


  @override
  State<AddAssignExam> createState() => _AddAssignExamState();
}

class _AddAssignExamState extends State<AddAssignExam> {
  final _type = ['- Choose -','Exam', 'Assignment', 'Quiz'];
  var _typeSelected = '- Choose -';

  String? Subject = 'Database';
  String? typeAssignExam;
  String? AssignExamName;
  int? rate;
  String? memo;

  String? ymdtStart;
  String? ymdtEnd;
  TextEditingController ymdtStartController = TextEditingController();
  TextEditingController ymdtEndController = TextEditingController();

  startYearMonthDayTimePicker() async {
    final year = DateTime
        .now()
        .year;
    String hour, min;

    final DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(year),
      lastDate: DateTime(year + 10),);

    if (dateTime != null) {
      final TimeOfDay? pickedTime = await showTimePicker(context: context,
          initialTime: TimeOfDay(hour: 0, minute: 0));

      if (pickedTime != null) {
        if (pickedTime.hour < 10) {
          hour = '0' + pickedTime.hour.toString();
        } else {
          hour = pickedTime.hour.toString();
        }
        if (pickedTime.minute < 10) {
          min = '0' + pickedTime.minute.toString();
        } else {
          min = pickedTime.minute.toString();
        }
        ymdtStartController.text = '${dateTime.toString().split(' ')[0]} $hour:$min';
      }
    }
  }

  endYearMonthDayTimePicker() async {
    final year = DateTime
        .now()
        .year;
    String hour, min;

    final DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(year),
      lastDate: DateTime(year + 10),);

    if (dateTime != null) {
      final TimeOfDay? pickedTime = await showTimePicker(context: context,
          initialTime: TimeOfDay(hour: 0, minute: 0));

      if (pickedTime != null) {
        if (pickedTime.hour < 10) {
          hour = '0' + pickedTime.hour.toString();
        } else {
          hour = pickedTime.hour.toString();
        }
        if (pickedTime.minute < 10) {
          min = '0' + pickedTime.minute.toString();
        } else {
          min = pickedTime.minute.toString();
        }
        ymdtEndController.text = '${dateTime.toString().split(' ')[0]} $hour:$min';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left : 8.0),
                child: const Text('과목명'),
              ),
              const SizedBox(width: 15,),

            ],
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: const Text('분류'),
              ),
              const SizedBox(width: 80,),
              DropdownButton(
                  value: _typeSelected,
                  items: _type.map(
                        (value){
                    return DropdownMenuItem(
                        value: value,
                        child: Text(value));
                  }).toList(),
                  onChanged: (value){
                    setState(() {
                      _typeSelected = value as String;
                    });
                  }
              )
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: const Text('이름'),
              ),
              const SizedBox(width: 15,),
              Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '과제/시험 이름',
                    ),
                    onChanged: (value) {
                      AssignExamName = value;
                    },
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: const Text('비율'),
              ),
              const SizedBox(width: 15,),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '숫자만 입력',
                  ),
                  onChanged: (value) {
                    rate = int.parse(value);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: const Text('시작'),
              ),
              const SizedBox(width: 15,),
              Expanded(
                child: GestureDetector(
                  onTap: startYearMonthDayTimePicker,
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: ymdtStartController,
                      decoration: InputDecoration(
                        labelText: '시작 연월일 시간',
                        border: OutlineInputBorder(),
                        filled: true,
                      ),
                      onSaved: (val) {
                        ymdtStart = ymdtStartController.text;
                      },
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return '입력해주세요';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),

            ],
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left : 8.0),
                child: const Text('종료'),
              ),
              const SizedBox(width: 15,),
              Expanded(
                child: GestureDetector(
                  onTap: endYearMonthDayTimePicker,
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: ymdtEndController,
                      decoration: InputDecoration(
                        labelText: '종료 연월일 시간',
                        border: OutlineInputBorder(),
                        filled: true,
                      ),
                      onSaved: (val) {
                        ymdtEnd = ymdtEndController.text;
                      },
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return '입력해주세요';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: const Text('메모'),
              ),
              const SizedBox(width: 15,),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    memo = value;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          OutlinedButton(
            onPressed: () async {
              final assignexamAdd = FirebaseFirestore.instance
                  .collection('Subject').doc(Subject).collection(typeAssignExam!).doc(AssignExamName);
              assignexamAdd.set({
                "subject" : Subject,
                "rate" : rate,
                "startYMDT" : ymdtStart,
                "endYMDT" : ymdtEnd
              });
              ymdtStartController.clear();
              ymdtEndController.clear();
              Navigator.of(context).pop();
              },
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }
}

class AddPersonal extends StatefulWidget {
  const AddPersonal({Key? key}) : super(key: key);
  @override
  State<AddPersonal> createState() => _AddPersonalState();
}

class _AddPersonalState extends State<AddPersonal> {
  final _alramList = ['no alarm','before 30 minutes','before 1 hour', 'before 12 hours',
    'before one day', 'before 3 days'];
  var _alarmSelected = 'no alarm';
  String? personalTitle;
  String? personalTime;
  String? whenAlarm;
  String? memo;
  TextEditingController ymdtPersonalController = TextEditingController();

  personalYearMonthDayTimePicker() async {
    final year = DateTime
        .now()
        .year;
    String hour, min;

    final DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(year),
      lastDate: DateTime(year + 10),);

    if (dateTime != null) {
      final TimeOfDay? pickedTime = await showTimePicker(context: context,
          initialTime: TimeOfDay(hour: 0, minute: 0));

      if (pickedTime != null) {
        if (pickedTime.hour < 10) {
          hour = '0' + pickedTime.hour.toString();
        } else {
          hour = pickedTime.hour.toString();
        }
        if (pickedTime.minute < 10) {
          min = '0' + pickedTime.minute.toString();
        } else {
          min = pickedTime.minute.toString();
        }
        ymdtPersonalController.text = '${dateTime.toString().split(' ')[0]} $hour:$min';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left : 8.0),
                child: const Text('제목'),
              ),
              const SizedBox(width: 15,),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    personalTitle = value;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('약속시간'),
              const SizedBox(width: 25,),
              Expanded(
                child: GestureDetector(
                  onTap: personalYearMonthDayTimePicker,
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: ymdtPersonalController,
                      decoration: InputDecoration(
                        labelText: '약속 연월일 시간',
                        border: OutlineInputBorder(),
                        filled: true,
                      ),
                      onChanged: (val) {
                        ymdtPersonalController.text = val;
                        personalTime = ymdtPersonalController.text;
                      },
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return '입력해주세요';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left : 8.0),
                child: const Text('알림'),
              ),
              const SizedBox(width: 40,),
              DropdownButton(
                  value: _alarmSelected,
                  items: _alramList.map(
                          (value){
                        return DropdownMenuItem(
                            value: value,
                            child: Text(value));
                      }).toList(),
                  onChanged: (value){
                    setState(() {
                      _alarmSelected = value as String;
                    });
                  }
              )
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left : 8.0),
                child: const Text('메모'),
              ),
              const SizedBox(width: 15,),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    memo = value;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          OutlinedButton(
            onPressed: () async {
              final personalAdd = FirebaseFirestore.instance.collection('Personal').doc(personalTitle);
              personalAdd.set({
                "title" : personalTitle,
                "time" : personalTime,
                "alarm" : whenAlarm,
                "memo" : memo,
              });
              Navigator.pop(context);
            },
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }
}
