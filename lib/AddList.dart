import 'package:flutter/material.dart';
import 'AddSubject.dart';
import 'AddAssignExam.dart';
import 'AddPersonal.dart';

// 과목을 추가하는 페이지

class addList extends StatelessWidget {         // 추가
  const addList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 과목 추가 버튼
            OutlinedButton(
              onPressed: () {
                // 팝업 메세지를 뜨게 하려면, showDialog 와 AlertDialog 2개를 써야함
                showDialog(
                    context: context,
                    // barrierDismissible 는 팝업 메세지가 띄어졌을 때 뒷 배경의 touchEvent 가능 여부에 대한 값
                    // true: 뒷 배경 touch 하면 팝업 메세지가 닫힘, false: 안 닫힘
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return const AlertDialog(
                        title: Text('과목 추가'),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(12.0))), //모서리를 둥글게
                        // 팝업 메시지에 AddSubjects 를 불러옴
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
            // 과제/시험 일정 추가 버튼
            OutlinedButton(
              onPressed: () {
                // 팝업 메세지를 뜨게 하려면, showDialog 와 AlertDialog 2개를 써야함
                showDialog(context: context,
                    // barrierDismissible 는 팝업 메세지가 띄어졌을 때 뒷 배경의 touchEvent 가능 여부에 대한 값
                    // true: 뒷 배경 touch 하면 팝업 메세지가 닫힘, false: 안 닫힘
                    barrierDismissible: true,
                    builder: (BuildContext context){
                      return const AlertDialog(
                        title: Text('과제/시험 일정 추가'),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))), //모서리를 둥글게
                        // 팝업 메시지에 AddAssignExam 을 불러옴
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
            // 개인 일정 추가 버튼
            OutlinedButton(
              onPressed: () {
                // 팝업 메세지를 뜨게 하려면, showDialog 와 AlertDialog 2개를 써야함
                showDialog(context: context,
                    // barrierDismissible 는 팝업 메세지가 띄어졌을 때 뒷 배경의 touchEvent 가능 여부에 대한 값
                    // true: 뒷 배경 touch 하면 팝업 메세지가 닫힘, false: 안 닫힘
                    barrierDismissible: true,
                    builder: (BuildContext context){
                      return const AlertDialog(
                        title: Text('개인 일정 추가'),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))), //모서리를 둥글게
                        // 팝업 메시지에 AddPersonal 을 불러옴
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
            // 닫기 버튼
            OutlinedButton(
              onPressed: () {
                // 버튼 클릭 시 메인 화면으로 돌아감
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
