import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPersonal extends StatefulWidget {
  const AddPersonal({Key? key}) : super(key: key);
  @override
  State<AddPersonal> createState() => _AddPersonalState();
}

class _AddPersonalState extends State<AddPersonal> {
  final _alramList = ['no alarm','before 30 minutes','before 1 hour', 'before 12 hours',
    'before one day', 'before 3 days'];
  var _alarmSelected = 'no alarm';
  bool? autovalidate = false;
  String? personalTitle;
  String? personalTime;
  String? memo;
  String? Time;
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
        Time = '${dateTime.toString().split(' ')[0]} $hour:$min';
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
                  onChanged: (String? value){
                    setState(() {
                      _alarmSelected = value!;
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
                "time" : ymdtPersonalController.text,
                "alarm" : _alarmSelected,
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
