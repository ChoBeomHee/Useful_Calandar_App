import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:team/SubjectsProvider.dart';
<<<<<<< HEAD

import 'package:team/personalView.dart';

User? loggedUser;

=======
List<Subject> Daylist = [];
>>>>>>> f9cb5c46b55d88ff47fa801fc1dd9c8b869ba996
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
<<<<<<< HEAD
=======

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
>>>>>>> f9cb5c46b55d88ff47fa801fc1dd9c8b869ba996
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;
  // 이 페이지가 생성될 그 때만 인스턴스 전달만 해주면 됨
<<<<<<< HEAD
  Future<void> setSchedure_Assingment() async {
    var sub = FirebaseFirestore.instance.collection('user').doc(_authentication.currentUser!.uid)
        .collection('Subject')
        .get();
    var check = await sub;

    for (int i = 0; i < check.docs.length; i++) {
      var todayAssingn = FirebaseFirestore.instance.collection('user').doc(_authentication.currentUser!.uid)
          .collection('Subject')
          .doc(check.docs[i]['SubjectName'])
          .collection('Assignment')
          .get();

      var list = await todayAssingn;
      for (int i = 0; i < list.docs.length; i++) {
        if (intoDay(list.docs[i]['startYMDT'], list.docs[i]['endYMDT']) ==
            true) {
          context.read<Subs>().prov_subjectname.add(list.docs[i]['subject']);
          context.read<Subs>().prov_memo.add(list.docs[i]['memo']);
          context.read<Subs>().start.add(list.docs[i]['startYMDT']);
          context.read<Subs>().end.add(list.docs[i]['endYMDT']);
          context.read<Subs>().type.add('과제');
        }
      }
    }
    for (int i = 0; i < check.docs.length; i++) {
      var todayExam = FirebaseFirestore.instance.collection('user').doc(_authentication.currentUser!.uid)
          .collection('Subject')
          .doc(check.docs[i]['SubjectName'])
          .collection('Exam')
          .get();

      var list = await todayExam;
      for (int i = 0; i < list.docs.length; i++) {
        if (intoDay(list.docs[i]['startYMDT'], list.docs[i]['endYMDT']) ==
            true) {
          context.read<Subs>().prov_subjectname.add(list.docs[i]['subject']);
          context.read<Subs>().prov_memo.add(list.docs[i]['memo']);
          context.read<Subs>().start.add(list.docs[i]['startYMDT']);
          context.read<Subs>().end.add(list.docs[i]['endYMDT']);
          context.read<Subs>().type.add('시험');
        }
      }
    }
    for (int i = 0; i < check.docs.length; i++) {
      var todayQuiz = FirebaseFirestore.instance.collection('user').doc(_authentication.currentUser!.uid)
          .collection('Subject')
          .doc(check.docs[i]['SubjectName'])
          .collection('Quiz')
          .get();

      var list = await todayQuiz;
      for (int i = 0; i < list.docs.length; i++) {
        if (intoDay(list.docs[i]['startYMDT'], list.docs[i]['endYMDT']) ==
            true) {
          context.read<Subs>().prov_subjectname.add(list.docs[i]['subject']);
          context.read<Subs>().prov_memo.add(list.docs[i]['memo']);
          context.read<Subs>().start.add(list.docs[i]['startYMDT']);
          context.read<Subs>().end.add(list.docs[i]['endYMDT']);
          context.read<Subs>().type.add('퀴즈');
        }
      }
    }
  }

  String slicedDate(String d) {
    // 연도를 제거한 문자열(월,일,시간) 리턴
    return d.substring(5);
  }

=======

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
>>>>>>> f9cb5c46b55d88ff47fa801fc1dd9c8b869ba996
  @override
  // State가 처음 만들어졌을때만 하는 것
  void initState() {
    // TODO: implement initState
    super.initState(); // 이걸 먼저 해줘야함(부모 클래스로부터 받아옴, Stateful 위젯 안에 initState가 있기때문에)
    getCurrentUser();

  }

  void getCurrentUser() {
    try {
<<<<<<< HEAD
      final user =
          _authentication.currentUser; // _authentication 의 currentUser을 대입
=======
      final user = _authentication.currentUser; // _authentication 의 currentUser을 대입
>>>>>>> f9cb5c46b55d88ff47fa801fc1dd9c8b869ba996
      if (user != null) {
        loggedUser = user;
      }
    } catch (e) {
      print(e);
    }
  }
<<<<<<< HEAD

  bool intoDay(String startDay, String endDay) {
    String newToDay = getcompareDay().substring(0, 11);
    String newStartDay = startDay.substring(0, 11);
    String newendDay = endDay.substring(0, 11);
    int resultstart = newStartDay.compareTo(newToDay);
    int resultend = newendDay.compareTo(newToDay);

    if (resultstart <= 0 && resultend >= 0) {
      return true;
    } else
      return false;
  }

  bool intoDay_per(String startDay, String endDay) {
    String newToDay = getcompareDay().substring(0, 11);
    String newStartDay = startDay.substring(0, 11);
    String newendDay = endDay.substring(0, 11);
    int resultstart = newStartDay.compareTo(newToDay);
    int resultend = newendDay.compareTo(newToDay);

    if (resultstart <= 0 && resultend >= 0) {
      return true;
    } else
      return false;
    /*
      if(result == 0){
        print('같음');
      }

      else if (result > 0){
        print('스타트데이가 큼');
      }
      else if (result < 0){
        print('엔드데이가 큼');
      }
*/
  }

  @override
  Widget build(BuildContext context) {
    context.read<Subs>().prov_subjectname.clear();
    context.read<Subs>().prov_memo.clear();
    context.read<Subs>().start.clear();
    context.read<Subs>().end.clear();
    context.read<Subs>().type.clear();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBar(
              backgroundColor: Color(0xFFF6F9FD),
              bottom: TabBar(tabs: [
                Tab(
                  icon: Icon(Icons.schedule),
                ),
                Tab(
                  icon: Icon(Icons.book),
                ),
              ],
                indicatorColor: Color(0xFF343434),
                labelColor: Color(0xFF343434),
                unselectedLabelColor: Color(0xFFA1A3A8),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              //////////////////////////////////////////////////////////// 개인 일정
              SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60), // 모서리를 둥글게
                      border: Border.all(color: Color(0xFF343434), width: 10)),
                  child: Column(
                    children: <Widget>[
                      Text('\n\n오늘 일정 (${getToday()})', // 제목
                          style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'title')),
                      const SizedBox(
                        height: 15,
                      ),
                      Text('개인 일정',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance.collection('user').doc(_authentication.currentUser!.uid)
                              .collection('Personal')
                              .where('comparedate',
                                  isEqualTo: getcompareDay().substring(0, 10))
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            final docs = snapshot.data!.docs;
                            return ListView.separated(
                              itemCount: docs.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: ListTile(
                                    title: Text(
                                        '     ${slicedDate(docs[index]['time'])} :    ${docs[index]['title'].toString()}',
                                        style: const TextStyle(
                                          height: 3,
                                        ),
                                        textAlign: TextAlign.start),
                                    onTap: () {
                                      // 개인 일정이 클릭되면 메모 띄우기
                                      showDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    22.0))),
                                                content: Container(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  width: 300,
                                                  height: 300,
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Center(
                                                            child: Text(
                                                                '${docs[index]['title']}',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        22,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        'title'))),
                                                      ),
                                                      Container(
                                                        height: 3.0,
                                                        width: 200.0,
                                                      ), // 실선
                                                      const Text('\n메모',
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Container(
                                                        width: 250,
                                                        height: 150,
                                                        padding: EdgeInsets.all(
                                                            16.0),
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            22.0)),
                                                                border:
                                                                    Border.all(
                                                                  width: 1,
                                                                  color: Color(0xFF343434),
                                                                )),
                                                        child: Text(
                                                          '${docs[index]['memo']}',
                                                          style: TextStyle(
                                                              fontSize: 17),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ));
                                    },
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider(
                                  thickness: 3.0,
                                );
                              },
=======
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
>>>>>>> f9cb5c46b55d88ff47fa801fc1dd9c8b869ba996
                            );
                          },
                        );
                      },
                    )*/
                  ),
                ),
              ),
<<<<<<< HEAD
              // 개인
              //////////////////////////////////////////////////////////// 공부 일정
              SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60), // 모서리를 둥글게
                      border: Border.all(color: Color(0xFF343434), width: 10)),
                  child: Column(
                    children: <Widget>[
                      Text('\n\n오늘 일정(${getToday()})',
                          style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'title')),
                      const SizedBox(
                        height: 15,
                      ),
                      Text('공부 일정',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      FutureBuilder(
                          future: setSchedure_Assingment(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text('');
                            } else {
                              return Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: ListView.separated(
                                    itemCount: context
                                        .read<Subs>()
                                        .prov_subjectname
                                        .length,
                                    itemBuilder: (context, index) {
                                      return SubjectTile(Subject(
                                          context
                                              .read<Subs>()
                                              .prov_subjectname[index],
                                          context.read<Subs>().start[index],
                                          context.read<Subs>().end[index],
                                          context.read<Subs>().prov_memo[index],
                                          context.read<Subs>().type[index]));
                                    },
                                    separatorBuilder: (context, index) {
                                      return const Divider(
                                        thickness: 3.0,
                                      );
                                    },
                                  ),
                                ),
                              );
                            }
                          }),
                    ],
                  ),
                ),
              ),
              // 공부
            ],
          )),
=======
            ],
          )
>>>>>>> f9cb5c46b55d88ff47fa801fc1dd9c8b869ba996
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
<<<<<<< HEAD
  double _currentSliderValue = 25;
  bool _check = false;

  @override
  Widget build(BuildContext context) {
    String _endTime = widget._subject.end.substring(5,16);

    return ListTile(
      trailing: SizedBox(
        width: 20,
        child: Icon(Icons.check, color: _check ? Colors.green : Colors.grey),     // 진행도 100% 되면 체크!!!!
      ),
      title: Row(
        children: [
          SizedBox(
              width: 80,
              child: Text(widget._subject.title,
                  style: const TextStyle(
                      height: 1, fontSize: 15, fontFamily: 'title'),
                  textAlign: TextAlign.center)),
          Text('  마감일 : '),
          Expanded(child: Text(_endTime)), // '할 일' 잘리는 것 방지
          Text(widget._subject.type),
=======
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          SizedBox(
            width: 70,
              child:
                Text(widget._subject.title,
<<<<<<< HEAD
                  style: const TextStyle(height: 1, fontSize: 13, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center)
          ),
          const SizedBox(width: 20,),
          Text('마감일 : '),
=======
                  style: const TextStyle(height: 1, fontSize: 15, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center)
          ),
>>>>>>> cfcf2bda5f8f5eef28e4d14042ad58f2dba06d60
          const SizedBox(width: 30,),
          Text(widget._subject.time),
          const SizedBox(width: 30,),
          Expanded(child: Text(widget._subject.todo,)),            // '할 일' 잘리는 것 방지
          Text(widget._subject.memo),
          const SizedBox(width: 30,),
>>>>>>> f9cb5c46b55d88ff47fa801fc1dd9c8b869ba996
        ],
      ),
      onTap: () {
        // 리스트 타일이 클릭되면
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) => AlertDialog(
<<<<<<< HEAD
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(22.0))),
                  title: Padding(   // 제목 + 메모
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Text(widget._subject.title,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3),
                        const SizedBox(width: 15),
                        Expanded(
                          // '할 일' 잘리는 것 방지
                          child: Text(
                            widget._subject.memo,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
=======
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
>>>>>>> f9cb5c46b55d88ff47fa801fc1dd9c8b869ba996
                          ),
                        ),
                      ],
                    ),
                  ),
                  content: StatefulBuilder(
                    builder: (__, StateSetter setDialogState){
                      return Container(
                        padding: const EdgeInsets.all(16.0),
                        width: 300,
                        height: 300,
                        child: Column(
                          children: [
                            const Text('진행도'),                      ////////////////// 슬라이더
                            Slider(
                                    value: _currentSliderValue.toDouble(),
                                    max: 100,
                                    min: 0,
                                    divisions: 5,
                                    label: _currentSliderValue.round().toString(),
                                    onChanged: (double value) {
                                      _currentSliderValue = value;
                                      setDialogState(()=>_currentSliderValue = value);
                                      setState(() {     // Widget build(BuildContext context) 시 빌드
                                        if (_currentSliderValue == 100){
                                          _check = true;
                                          print("yesyesyes it's 100%");
                                        }
                                        else
                                          _check = false;
                                      });
                                    },
                                  ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                const Text('날짜'),
                                SizedBox(
                                  width: 30,
                                ),
                                Container(
                                  child: Text(getToday()),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                const Text('시작'),
                                SizedBox(
                                  width: 30,
                                ),
                                Container(
                                  child:
                                  Text(widget._subject.start.substring(11,16)), // 시작 시간만 잘라서 넣기
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                const Text('종료'),
                                SizedBox(
                                  width: 30,
                                ),
                                Container(
                                  child:
                                  Text(widget._subject.end.substring(11,16)), // 끝나는 시간만 잘라서 넣기
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  )
                ));
      },
    );
  }
}

<<<<<<< HEAD
String getToday() {
  // 오늘 날짜 가져오는 함수
=======
String getToday(){      // 오늘 날짜 가져오는 함수
>>>>>>> f9cb5c46b55d88ff47fa801fc1dd9c8b869ba996
  var now = DateTime.now();
  String formatDate = DateFormat('MM/dd').format(now);
  return formatDate;
}

String getcompareDay() {
  var now = DateTime.now();
  return now.toString();
}
