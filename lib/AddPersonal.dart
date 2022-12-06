import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:team/SubjectsProvider.dart';

class AddPersonal extends StatefulWidget {
  const AddPersonal({Key? key}) : super(key: key);
  @override
  State<AddPersonal> createState() => _AddPersonalState();
}

class _AddPersonalState extends State<AddPersonal> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;
  // 이 페이지가 생성될 그 때만 인스턴스 전달만 해주면 됨

  @override
  // State가 처음 만들어졌을때만 하는 것
  void initState() {
    // TODO: implement initState
    super.initState(); // 이걸 먼저 해줘야함(부모 클래스로부터 받아옴, Stateful 위젯 안에 initState가 있기때문에)
    getCurrentUser();
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

  final _alramList = ['no alarm','before 30 minutes','before 1 hour', 'before 12 hours',
    'before one day', 'before 3 days'];
  var _alarmSelected = 'no alarm';
  bool? autovalidate = false;
  String? personalTitle;
  String? personalTime;
  String? memo;
  String? Time;
  TextEditingController memocontrol = TextEditingController();
  TextEditingController ymdtPersonalController = TextEditingController();
  DateTime? personalDay;
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
        Time = '${dateTime.toString().split(' ')[0]} $hour:$min';
        ymdtPersonalController.text = '${dateTime.toString().split(' ')[0]} $hour:$min';
        personalDay = dateTime.add(new Duration(days: 0, hours: pickedTime.hour, minutes: pickedTime.minute, milliseconds: 0, microseconds: 0));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    memocontrol.text = ' ';
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text('개인 일정 추가'),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left : 8.0),
                child: const Text('제목'),
              ),
              const SizedBox(width: 15,),
              Expanded(
                child: SizedBox(
                  height: 35,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      personalTitle = value;
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('약속시간'),
              const SizedBox(width: 25,),
              Expanded(
                child: SizedBox(
                  height: 35,
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
              ),
            ],
          ),
          const SizedBox(height: 15,),
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
                ),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          OutlinedButton(
            onPressed: () async {
              final personalAdd = FirebaseFirestore.instance.collection('user').doc(_authentication.currentUser!.uid).
              collection('Personal').doc(personalTitle);
              personalAdd.set({
                "title" : personalTitle,
                "time" : ymdtPersonalController.text,
                "date" : personalDay,
                "alarm" : _alarmSelected,
                "memo" : memocontrol.text,
                "uid" : _authentication.currentUser!.uid, // 이 값이 현재 로그인 되어 있는 uid와 같은지 확인
                "comparedate" : ymdtPersonalController.text.substring(0,10)
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
