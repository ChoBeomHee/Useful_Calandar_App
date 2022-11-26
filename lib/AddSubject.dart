import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// 과목 추가 버튼 클릭 시 AddSubjects 나옴
class AddSubjects extends StatefulWidget {
  const AddSubjects({Key? key}) : super(key: key);

  @override
  State<AddSubjects> createState() => _AddSubjectsState();
}

class _AddSubjectsState extends State<AddSubjects> {

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
  // 각각 정보를 저장할 변수
  bool? _ischecked = false; // 영어 강의 여부
  int? MidTest = 0; // 중간고사 평가 비율
  int? FinalTest = 0; // 기말고사 평가 비율
  int? task = 0; // 과제 평가 피율
  int? attendance = 0; // 출결 평가 비율
  String? Subject = ''; // 과목명
  double? credit = 0; // 학점

  @override
  Widget build(BuildContext context) {
    // 각각 칸에 해당하는 컨트롤러
    // input field 로 부터 텍스트를 읽고, 텍스트를 전송한 뒤에 clear 하는데 사용함
    // 값이 입력되는 즉시 해당 값을 가져올 수 있음
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
          // 과목 정보 입력
          const Text('과목'),
          const SizedBox(
            height: 10,
          ),
          // 과목명 입력
          SizedBox(
            height: 40,
            child: TextFormField(
              controller: _controller1,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '과목명',
              ),
              onChanged: (value) {
                // TextFormField 에 입력한 정보를 변수에 저장
                Subject = value;
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // 해당 과목의 학점 입력
          SizedBox(
            height: 40,
            child: TextFormField(
              controller: _controller2,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '학점',
              ),
              onChanged: (value) {
                // TextFormField 에 입력한 정보를 변수에 저장
                // 입력받은 value 를 double 형으로 변환하여 저장
                credit = double.parse(value);
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // 평가 비율 입력
          const Text('평가 비율'),
          const SizedBox(
            height: 10,
          ),
          // 중간고사 평가 비율 입력
          SizedBox(
            height: 40,
            child: TextFormField(
              controller: _controller3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '중간고사',
              ),
              onChanged: (value) {
                // TextFormField 에 입력한 정보를 변수에 저장
                // 입력받은 value 를 int 형으로 변환하여 저장
                MidTest = int.parse(value);
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // 기말고사 평가 비율 입력
          SizedBox(
            height: 40,
            child: TextFormField(
              controller: _controller4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '기말고사',
              ),
              onChanged: (value) {
                // TextFormField 에 입력한 정보를 변수에 저장
                // 입력받은 value 를 int 형으로 변환하여 저장
                FinalTest = int.parse(value);
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // 과제 평가 비율 입력
          SizedBox(
            height: 40,
            child: TextFormField(
              controller: _controller5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '과제',
              ),
              onChanged: (value) {
                // TextFormField 에 입력한 정보를 변수에 저장
                // 입력받은 value 를 int 형으로 변환하여 저장
                task = int.parse(value);
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // 출결 평가 비율 입력
          SizedBox(
            height: 40,
            child: TextFormField(
              controller: _controller6,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '출결',
              ),
              onChanged: (value) {
                // TextFormField 에 입력한 정보를 변수에 저장
                // 입력받은 value 를 int 형으로 변환하여 저장
                attendance = int.parse(value);
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // 영어 강의 여부 체크 박스
          CheckboxListTile(
            title: const Text('영어 강의 여부'),
            value: _ischecked,
            onChanged: (value) {
              setState(() {
                // 기본값: false -> 영어 강의가 아님
                _ischecked = value!;
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          // 확인 버튼 시 FirebaseFirestore 에 저장
          OutlinedButton(
            onPressed: () async {
              // FirebaseFirestore 의 데이터베이스에 연결하여 'Subject' collection 의 'Subject' document 에 접근하겠다.
              final subjectadd = FirebaseFirestore.instance.collection('Subject').doc(Subject);
              // 'Subject' collection 의 'Subject' document 에 현재 입력 받은 정보들을 추가하겠다.
              subjectadd.set({
                "Midterm" : MidTest,
                "Finalterm" : FinalTest,
                "task" : task,
                "credit" : credit,
                "attandence" : attendance,
                "English" : _ischecked,
                "SubjectName" : Subject,
                "uid" : _authentication.currentUser!.uid, // 이 값이 현재 로그인 되어 있는 uid와 같은지 확인
              });
              // 입력 받은 정보들을 추가하고 나면 TextFormField 를 빈칸으로 clear 하겠다.
              _controller1.clear();
              _controller2.clear();
              _controller3.clear();
              _controller4.clear();
              _controller5.clear();
              _controller6.clear();
              // clear 하고 나면 이전 팝업 메세지로 돌아간다.
              Navigator.of(context).pop();
            },
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }
}
