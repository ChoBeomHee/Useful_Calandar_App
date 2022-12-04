import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:team/SubjectsProvider.dart';
List<Subject> Daylist = [];
class Subject {
  String title;
  String time;
  String todo;
  String memo;

  Subject(this.title, this.time, this.todo, this.memo);
}

class ScheduleDetail extends StatefulWidget {
  ScheduleDetail({Key? key}) : super(key: key);

  @override
  State<ScheduleDetail> createState() => _ScheduleDetailState();
}

class _ScheduleDetailState extends State<ScheduleDetail> {

  /*List<Subject> todoList = [                          // 그냥 예시입니다!!
    Subject('DB','13:00-14:30','DB레포트 작성'),
    Subject('Graphics', '15:00-18:00', 'Texture, Lighting, 할거 짱 많네 아오'),
    Subject('Algorithm', '21:00-23:00', 'BFS'),
    Subject('DB','13:00-14:30','DB레포트 작성'),
    Subject('Graphics', '15:00-18:00', 'Texture, Lighting'),
    Subject('Algorithm', '21:00-23:00', 'BFS'),
    Subject('DB','13:00-14:30','DB레포트 작성'),
    Subject('Grahics', '15:00-18:00', 'Texture, Lighting'),
  ];*/
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;
  // 이 페이지가 생성될 그 때만 인스턴스 전달만 해주면 됨

  void setSchedure() async{
     var sub = FirebaseFirestore.instance.collection('Subject').
      where('uid', isEqualTo: _authentication.currentUser!.uid).get();
      var check = await sub;

      for(int i = 0; i < check.docs.length; i++) {
        var today = FirebaseFirestore.instance.collection('Subject').
        doc(check.docs[i]['SubjectName']).collection('Assignment').get();

        var list = await today;
        Daylist.add(Subject(list.docs[0]['subject'], '시작',
            '끝', list.docs[0]['memo']));
      }
 }
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
  Widget build(BuildContext context)  {

    setSchedure();
    return Scaffold (
        appBar: AppBar(
           title: const Text('상세 일정'),
        ),
      body:
          Column(
            children: [
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView.separated(
                      itemCount: Daylist.length,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Padding (
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                            child: Text('오늘 일정(${getToday()})', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                          );
                        }
                        return SubjectTile(Daylist[index]);
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          thickness: 3.0,
                        );
                      },
                    ),
                    /*StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('Subject').
                      doc().
                      collection('Assignment').
                      where('UID', isEqualTo: _authentication.currentUser!.uid).snapshots(),
                      builder: (context, snapshot){
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return const Center(child: CircularProgressIndicator(),);
                        }
                        final docs = snapshot.data!.docs;
                        return ListView.separated(
                          itemCount: docs.length,
                          itemBuilder: (context, index) {
                            return SubjectTile(Subject(docs[index]['subject'], docs[index]['subject'], docs[index]['subject']));
                          },
                          separatorBuilder: (context, index) {
                            if (index == 0) {
                              return SizedBox.shrink();
                            }
                            return const Divider(
                              thickness: 3.0,
                            );
                          },
                        );
                      },
                    )*/
                  ),
                ),
              ),
            ],
          )
    );
  }
}

class SubjectTile extends StatefulWidget {
  SubjectTile(this._subject);
  final Subject _subject;

  @override
  State<SubjectTile> createState() => _SubjectTileState();
}

class _SubjectTileState extends State<SubjectTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          SizedBox(
            width: 70,
              child:
                Text(widget._subject.title,
                  style: const TextStyle(height: 1, fontSize: 15, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center)
          ),
          const SizedBox(width: 30,),
          Text(widget._subject.time),
          const SizedBox(width: 30,),
          Expanded(child: Text(widget._subject.todo,)),            // '할 일' 잘리는 것 방지
          Text(widget._subject.memo),
          const SizedBox(width: 30,),
        ],
      ),
      onTap: (){        // 리스트 타일이 클릭되면
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) => AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(22.0))),
                title: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Text(widget._subject.title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3),
                      const SizedBox(width: 15),
                      Expanded(                                 // '할 일' 잘리는 것 방지
                        child: Text(widget._subject.todo,
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                      ),
                    ],
                  ),
                ),
                content: Container(
                  padding: const EdgeInsets.all(16.0),
                  width: 300,
                  height: 300,
                  child: Column(
                    children: [
                       const Text(''),
                      const Text('진행도'),
                      const SizedBox(                   // 이 곳엔 진행바가 들어갈 예정!!!!!!!!!!!
                        height: 100,
                      ),
                      Row(
                        children: [
                          const Text('날짜'),
                          SizedBox(width: 30,),
                          Container(
                            child: Text(getToday()),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30,),
                      Row(
                        children: [
                          const Text('시작'),
                          SizedBox(width: 30,),
                          Container(
                            child: Text(widget._subject.time),       // 시작 시간만 잘라서 넣기
                          ),
                        ],
                      ),
                      const SizedBox(height: 30,),
                      Row(
                        children: [
                          const Text('종료'),
                          SizedBox(width: 30,),
                          Container(
                            child: Text(widget._subject.time),       // 끝나는 시간만 잘라서 넣기
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

String getToday(){      // 오늘 날짜 가져오는 함수
  var now = DateTime.now();
  String formatDate = DateFormat('MM/dd').format(now);
  return formatDate;
}