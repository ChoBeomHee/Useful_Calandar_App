import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:team/SubjectsProvider.dart';

class SubjectInfo extends StatefulWidget {
  SubjectInfo({Key? key}) : super(key: key);

  @override
  State<SubjectInfo> createState() => _SubjectInfoState();
}

class _SubjectInfoState extends State<SubjectInfo> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;
  // 이 페이지가 생성될 그 때만 인스턴스 전달만 해주면 됨
  num totalCredit = 0;

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60), // 모서리를 둥글게
              border: Border.all(color: Colors.indigo, width: 10)),
          child: Column(
            children: [
              Text('\n과목 상세 정보\n',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('Subject').where('uid',isEqualTo: _authentication.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final docs = snapshot.data!.docs;
                    return ListView.separated(
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        return ListTile(title: Text(
                          '      ${docs[index]['SubjectName']}(${docs[index]['credit'].toString()})',
                            style: const TextStyle(height: 1, fontSize: 15, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left
                          ),
                          onTap: (){        // 리스트 타일이 클릭되면
                            showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: AlertDialog(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(22.0))),
                                    title: Text('   과목 상세 정보', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                                    content: Container(
                                      padding: const EdgeInsets.all(16.0),
                                      width: 300,
                                      height: 400,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              const SizedBox(
                                                  width: 80,
                                                  child: Text('과목명')),
                                              Expanded(
                                                child: Container(
                                                  child: Text(docs[index]['SubjectName']),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 30,),
                                          Row(
                                            children: [
                                              const SizedBox(
                                                  width: 80,
                                                  child: Text('학점')),
                                              Container(
                                                child: Text(docs[index]['credit'].toString()),
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
                                                child: Text(docs[index]['Midterm'].toString()+'%'),
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
                                                child: Text(docs[index]['Finalterm'].toString()+'%'),
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
                                                child: Text(docs[index]['task'].toString()+'%'),
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
                                                child: Text(docs[index]['attandence'].toString()+'%'),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 20,),
                                          Row(
                                            children: [
                                              const SizedBox(
                                                  width: 100,
                                                  child: Text('영어 강의1')),
                                              Container(
                                                child: Text(docs[index]['English'].toString()),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                  ),
                                )
                            );
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          thickness: 3.0,
                        );
                      },
                    );
                  },
                ),
              ),
              Container(
                height: 30,
              child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Subject').where('uid',isEqualTo: _authentication.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final docs = snapshot.data!.docs;

                docs.forEach((element) { totalCredit += element['credit']; });

                return Text('총 학점: $totalCredit',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),);
              })
              ),
          ],
          ),
        ),
      ),
    );
  }
}