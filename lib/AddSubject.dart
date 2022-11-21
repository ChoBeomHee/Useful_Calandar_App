import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
