import 'package:flutter/material.dart';

class SubjectInfo extends StatelessWidget {
  SubjectInfo({Key? key}) : super(key: key);

  List<SubInfoObj> subInfoList = [                          // 그냥 예시입니다!!
    SubInfoObj('DB', 3, 30, 30, 30, 10),
    SubInfoObj('Graphics', 3, 15, 15, 50, 20),
    SubInfoObj('Algorithm', 3, 30, 30, 40, 0),
    SubInfoObj('DB', 3, 30, 30, 30, 10),
    SubInfoObj('Graphics', 3, 15, 15, 50, 20),
    SubInfoObj('Algorithm', 3, 30, 30, 40, 0),
    SubInfoObj('DB', 3, 30, 30, 30, 10),
    SubInfoObj('Graphics', 3, 15, 15, 50, 20),
    SubInfoObj('Algorithm', 3, 30, 30, 40, 0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('과목 상세 정보'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.separated(
            itemCount: subInfoList.length,
            itemBuilder: (context, index) {
              return SubInfoObjTile(subInfoList[index]);
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
          ),
        ),
      )
    );
  }
}

class SubInfoObj {
  String title;
  int credit;
  int midTest;
  int finalTest;
  int assignment;
  int attendance;

  SubInfoObj(this.title, this.credit, this.midTest, this.finalTest, this.assignment, this.attendance);
}

class SubInfoObjTile extends StatelessWidget {
  SubInfoObjTile(this._subjectInfoObj);

  final SubInfoObj _subjectInfoObj;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title:
          Container(
            alignment: Alignment.centerLeft,
              child:
              Text(_subjectInfoObj.title + ' (${_subjectInfoObj.credit})',
                  style: const TextStyle(height: 1, fontSize: 15, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
          ),

      onTap: (){        // 리스트 타일이 클릭되면
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) => AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(22.0))),
              title: Text('과목 상세 정보', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3),
              content: Container(
                padding: const EdgeInsets.all(16.0),
                width: 300,
                height: 400,
                child: Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 100,
                            child: Text('과목명')),
                        Container(
                          child: Text(_subjectInfoObj.title),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30,),
                    Row(
                      children: [
                        const SizedBox(
                            width: 100,
                            child: Text('학점')),
                        Container(
                          child: Text(_subjectInfoObj.credit.toString()),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    const Padding(                                      // 평가비율이 앞으로 당겨지면 좋겠는데..흠..
                      padding: EdgeInsets.fromLTRB(0,8.0,0,8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                          child: Text('평가 비율', style: TextStyle(fontWeight: FontWeight.bold))),
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        const SizedBox(
                            width: 100,
                            child: Text('중간고사')),
                        Container(
                          child: Text(_subjectInfoObj.midTest.toString()),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        const SizedBox(
                            width: 100,
                            child: Text('기말고사')),
                        Container(
                          child: Text(_subjectInfoObj.midTest.toString()),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        const SizedBox(
                            width: 100,
                            child: Text('과제')),
                        Container(
                          child: Text(_subjectInfoObj.assignment.toString()),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        const SizedBox(
                            width: 100,
                            child: Text('출결')),
                        Container(
                          child: Text(_subjectInfoObj.attendance.toString()),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            )
        );
      },
    );
  }
}