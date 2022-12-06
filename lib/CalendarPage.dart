import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
<<<<<<< HEAD
=======
import 'package:syncfusion_flutter_core/core.dart';
import 'package:team/AddList.dart';
>>>>>>> f9cb5c46b55d88ff47fa801fc1dd9c8b869ba996
import 'package:table_calendar/table_calendar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:team/calendar/meeting_data_source.dart';
import 'calendar/meeting.dart';
import 'package:provider/provider.dart';
import 'package:team/SubjectsProvider.dart';
import 'calendar/meeting.dart';
import 'dart:math';
import 'calendar/meeting_data_source.dart';

User? loggedUser;

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}



class _CalendarPageState extends State<CalendarPage> {
  // 메인 페이지
  final _authentication = FirebaseAuth.instance;

  Future<void> setSchedure_Assingment() async {
    var sub = FirebaseFirestore.instance.collection('user').doc(_authentication.currentUser!.uid).collection('Subject').get();
    var check = await sub;
    for (int i = 0; i < check.docs.length; i++) {
      var todayAssingn = FirebaseFirestore.instance.collection('user').doc(_authentication.currentUser!.uid).collection('Subject').
      doc(check.docs[i]['SubjectName']).collection('Assignment').get();
      var list = await todayAssingn;
      for (int i = 0; i < list.docs.length; i++) {
        context
            .read<Subs>()
            .startDay
            .add(list.docs[i]['startDate'].toDate());
        context
            .read<Subs>()
            .endDay
            .add(list.docs[i]['endDate'].toDate());
        context
            .read<Subs>()
            .prov_subjectname
            .add(list.docs[i]['subject']);
        context
            .read<Subs>()
            .type
            .add('과제');
      }
    }
    for (int i = 0; i < check.docs.length; i++) {
      var todayExam = FirebaseFirestore.instance.collection('user').doc(_authentication.currentUser!.uid).collection('Subject').
      doc(check.docs[i]['SubjectName']).collection('Exam').get();

<<<<<<< HEAD
      var list = await todayExam;
      print('시험 수 ${list.docs.length}');
      print('${context.read<Subs>().startDay}');
      for (int i = 0; i < list.docs.length; i++) {
        context
            .read<Subs>()
            .startDay
            .add(list.docs[i]['startDate'].toDate());
        context
            .read<Subs>()
            .endDay
            .add(list.docs[i]['endDate'].toDate());
        context
            .read<Subs>()
            .prov_subjectname
            .add(list.docs[i]['subject']);
        context
            .read<Subs>()
            .type
            .add('시험');
      }
    }
    
    for (int i = 0; i < check.docs.length; i++) {
      var todayQuiz = FirebaseFirestore.instance.collection('user').doc(_authentication.currentUser!.uid).collection('Subject').
      doc(check.docs[i]['SubjectName']).collection('Quiz').get();

      var list = await todayQuiz;
      print('퀴즈 수 ${list.docs.length}');

      for (int i = 0; i < list.docs.length; i++) {
        context
            .read<Subs>()
            .startDay
            .add(list.docs[i]['startDate'].toDate());
        context
            .read<Subs>()
            .endDay
            .add(list.docs[i]['endDate'].toDate());
        context
            .read<Subs>()
            .prov_subjectname
            .add(list.docs[i]['subject']);
        context
            .read<Subs>()
            .type
            .add('퀴즈');
      }
    }
=======
  List<Color> _colorCollection = <Color>[];
  MeetingDataSource? events;
  final List<String> subOptions = <String>['Assignment', 'Exam', 'Quiz'];
  final databaseReference = FirebaseFirestore.instance;

  @override
  void initState() {
    _initializeEventColor();
    getDataFromFireStore().then((results) {
      SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
        setState(() {});
      });
    });
    super.initState();
  }

  Future<void> getDataFromFireStore() async {
    var snapShotsValue = await databaseReference.collection(subOptions[0]).get();

    final Random random = new Random();
    List<Meeting> list = snapShotsValue.docs
        .map((e) => Meeting(
        eventName: e.data()['Subject'],
        from:
        DateFormat('dd/MM/yyyy HH:mm:ss').parse(e.data()['StartTime']),
        to: DateFormat('dd/MM/yyyy HH:mm:ss').parse(e.data()['EndTime']),
        background: _colorCollection[random.nextInt(9)],
        isAllDay: false))
        .toList();
    setState(() {
      events = MeetingDataSource(list);
    });
>>>>>>> f9cb5c46b55d88ff47fa801fc1dd9c8b869ba996
  }

  void _initializeEventColor() {
    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));
    _colorCollection.add(const Color(0xFFD20100));
    _colorCollection.add(const Color(0xFFFC571D));
    _colorCollection.add(const Color(0xFF36B37B));
    _colorCollection.add(const Color(0xFF01A1EF));
    _colorCollection.add(const Color(0xFF3D4FB5));
    _colorCollection.add(const Color(0xFFE47C73));
    _colorCollection.add(const Color(0xFF636363));
    _colorCollection.add(const Color(0xFF0A8043));
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(
        today.year, today.month, today.day, 0, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 5));


    for (int i = 0; i < context.read<Subs>().startDay.length; i++) {
      int typeColor = 0;

      if (context.read<Subs>().type[i] == '시험'){
        typeColor = 0xFF745c54;
      }
      else if (context.read<Subs>().type[i] == '과제'){
        typeColor = 0xFFA89b92;
      }
      else if (context.read<Subs>().type[i] == '퀴즈'){
        typeColor = 0xFF867464;
      }

      meetings.add(Meeting(context
          .read<Subs>()
          .prov_subjectname[i], context
          .read<Subs>()
          .startDay[i], context
          .read<Subs>()
          .endDay[i], Color(typeColor)));
    }
    print(context.read<Subs>().prov_subjectname.length);
    return meetings;
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<Subs>()
        .prov_subjectname
        .clear();
    context
        .read<Subs>()
        .startDay
        .clear();
    context
        .read<Subs>()
        .endDay
        .clear();
    context
        .read<Subs>()
        .type
        .clear();
    return Scaffold(
      body: FutureBuilder(
        future: setSchedure_Assingment(),
        builder: (context, snapshot){
          if (snapshot.hasData) {
            return Text('');
          }
          else {
            return SafeArea(
              child: SfCalendar( // 캘린더 위젯
                //showDatePickerButton: true,
                //todayHighlightColor: Colors. amber, // 오늘 날짜 하이라이트 컬러
                cellBorderColor: Colors.white,
                // 달력 셀 테두리 색상
                showNavigationArrow: true,
                // 달력 화살표; 달력을 스와이프로 넘기지 않고 버튼으로 넘김
                view: CalendarView.month,
                // 달력을 월별로 본다.
                initialSelectedDate: DateTime.now(),
                // 프로그랩 켰을 때 처음 선택된 날짜
                initialDisplayDate: DateTime.now(),
                // 처음에 달력에서 지정된 날짜로 이동해서 표시
                cellEndPadding: 1,
                // 캘린더의 약속 패딩 사이즈 설정
                todayHighlightColor: Color(0xFF343434),
                headerStyle: const CalendarHeaderStyle( // December 2022 위치
                    textAlign: TextAlign.center,
                    textStyle: TextStyle(fontSize: 21)
                ),
                dataSource: MeetingDataSource(_getDataSource()),
                // 약속 일정 받아오기
                // 일정 위젯에는 약속 모음을 기반으로 내부적으로 약속 정렬을 처리하는 기본 제공 기능이 있습니다. 생성된 컬렉션을 dataSource 속성 에 할당해야 합니다 .
                // 맞춤 약속 데이터를 캘린더에 매핑할 수도 있습니다.
                monthViewSettings: const MonthViewSettings(
                  // 달력 월 보기에는 선택한 날짜의 약속을 월 아래에 표시하는 데 사용되는 분할된 안건 보기가 표시됩니다.
                  //numberOfWeeksInView: 4, // 달력에 몇 주 나오게 하는지 설정
                  appointmentDisplayCount: 3,
                  // 해당 날짜에 최대 몇개의 약속이 나오게 하는지 설정 (default:4)
                  // appointmentDisplayMode: 디스플레이 모드 속성을 사용하여 달력 월 보기 약속 표시를 처리할 수 있습니다
                  // MonthAppointmentDisplayMode.appointment(사각형), indicator(원), none(약속 표시X)
                  appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                  navigationDirection: MonthNavigationDirection.horizontal,
                  // December 2022 옆에 화살표 방향을 < > 로 설정
                  agendaViewHeight: 170,
                  // 일정 보기(아래)에 뜨는 컨테이너 틀의 높이 조절
                  agendaItemHeight: 50,
                  // 일정 보기(아래)에 뜨는 약속(사각형) 높이 조절
                  showAgenda: true,
                  // MonthViewSettings 에서 showAgenda 속성을 true로 설정하여 안건 보기를 표시할 수 있습니다
                  // 캘린더 스타일 설정
                ),
              ),
            );
          }
        },
      )
    );
  }
}