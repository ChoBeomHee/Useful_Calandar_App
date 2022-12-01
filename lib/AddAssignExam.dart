import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:team/info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'schedule.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:team/SubjectsProvider.dart';
import 'package:provider/provider.dart';

// 과제/시험 일정 추가 버튼 클릭 시 AddAssignExam 나옴
class AddAssignExam extends StatefulWidget {
  const AddAssignExam({Key? key}) : super(key: key);


  @override
  State<AddAssignExam> createState() => _AddAssignExamState();
}

class _AddAssignExamState extends State<AddAssignExam> {

  final _type = ['- Choose -','Exam', 'Assignment', 'Quiz'];
  var _typeSelected = '- Choose -';
  dynamic subjectSelected;
  Stream<QuerySnapshot>? _subjectSelect;
  @override

  final _authentication = FirebaseAuth.instance;
  User? loggedUser;
  // 이 페이지가 생성될 그 때만 인스턴스 전달만 해주면 됨

  @override
  // State가 처음 만들어졌을때만 하는 것

  void initState() {
    super.initState(); // 이걸 먼저 해줘야함(부모 클래스로부터 받아옴, Stateful 위젯 안에 initState가 있기때문에)
    // 현재 로그인한 ID가 추가했던 과목들만 불러옴
    _subjectSelect= FirebaseFirestore.instance.collection("Subject").where('uid',isEqualTo: _authentication.currentUser!.uid).snapshots();
    return super.initState();
  }

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

  String? Subject;
  String? AssignExamName;
  int? rate;
  String? memo;

  String? ymdtStart;
  String? ymdtEnd;
  TextEditingController ymdtStartController = TextEditingController();
  TextEditingController ymdtEndController = TextEditingController();

  startYearMonthDayTimePicker() async {
    final year = DateTime.now().year;
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(left : 8.0),
                child: const Text('과목명'),
              ),
              const SizedBox(width: 75,),
              Row(
                children: <Widget>[
                  StreamBuilder<QuerySnapshot>(
                      stream: _subjectSelect,
                      builder: (context, snapshot){
                        return DropdownButton(
                            value: subjectSelected,
                            items: snapshot.data?.docs.map((subjectData){
                              return DropdownMenuItem(
                                value: subjectData.id,
                                child: Text(subjectData.id),);
                            }).toList(),
                            onChanged: (value){
                              setState(() {
                                subjectSelected = value!;
                              });
                            });
                      })
                ],
              ),
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
                  .collection('Subject').doc(subjectSelected).collection(_typeSelected).doc(AssignExamName);
              assignexamAdd.set({
                "subject" : subjectSelected,
                "rate" : rate,
                "startYMDT" : ymdtStartController.text,
                "endYMDT" : ymdtEndController.text,
                "memo" : memo,
                "UID" : _authentication.currentUser!.uid,
              });
              ymdtStartController.clear();
              ymdtEndController.clear();
              context.read<Subs>().prov_subjectname.add(Subject.toString());
              Navigator.pop(context);
            },
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }
}
