import 'package:flutter/material.dart';
import 'AddSubject.dart';
import 'AddAssignExam.dart';
import 'AddPersonal.dart';

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
