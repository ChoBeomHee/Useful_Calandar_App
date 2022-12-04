import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:team/calendar/meeting_data_source.dart';
import 'calendar/meeting.dart';
import 'package:provider/provider.dart';
import 'package:team/SubjectsProvider.dart';

User? loggedUser;

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}



class _CalendarPageState extends State<CalendarPage> {         // 메인 페이지
  final _authentication = FirebaseAuth.instance;
  Future<void> setSchedure_Assingment() async {
    var sub = FirebaseFirestore.instance.collection('Subject').
    where('uid', isEqualTo: _authentication.currentUser!.uid).get();
    var check = await sub;

    for (int i = 0; i < check.docs.length; i++) {
      var todayAssingn = FirebaseFirestore.instance.collection('Subject').
      doc(check.docs[i]['SubjectName']).collection('Assignment').get();

      var list = await todayAssingn;
      for (int i = 0; i < list.docs.length; i++) {
        context.read<dates>().
        startDay.
        add(list.docs[i]['startDate']);
        context.read<dates>().endDay.
        add(list.docs[i]['endDate']);
        context
            .read<Subs>()
            .prov_subjectname
            .add(list.docs[i]['subject']);
        context
            .read<Subs>()
            .prov_memo
            .add(list.docs[i]['memo']);
        context
            .read<Subs>()
            .start
            .add(list.docs[i]['startYMDT']);
        context
            .read<Subs>()
            .end
            .add(list.docs[i]['endYMDT']);
        context
            .read<Subs>()
            .type
            .add('과제');
      }
    }
    for (int i = 0; i < check.docs.length; i++) {
      var todayExam = FirebaseFirestore.instance.collection('Subject').
      doc(check.docs[i]['SubjectName']).collection('Exam').get();

      var list = await todayExam;
      for (int i = 0; i < list.docs.length; i++) {
        context.read<dates>().
        startDay.
        add(list.docs[i]['startDate']);
        context.read<dates>().endDay.
        add(list.docs[i]['endDate']);
        context
            .read<Subs>()
            .prov_subjectname
            .add(list.docs[i]['subject']);
        context
            .read<Subs>()
            .prov_memo
            .add(list.docs[i]['memo']);
        context
            .read<Subs>()
            .start
            .add(list.docs[i]['startYMDT']);
        context
            .read<Subs>()
            .end
            .add(list.docs[i]['endYMDT']);
        context
            .read<Subs>()
            .type
            .add('시험');
      }
    }
    for (int i = 0; i < check.docs.length; i++) {
      var todayQuiz = FirebaseFirestore.instance.collection('Subject').
      doc(check.docs[i]['SubjectName']).collection('Quiz').get();

      var list = await todayQuiz;
      for (int i = 0; i < list.docs.length; i++) {
        context.read<dates>().
        startDay.
        add(list.docs[i]['startDate']);
        context.read<dates>().endDay.
        add(list.docs[i]['endDate']);
        context
            .read<Subs>()
            .prov_subjectname
            .add(list.docs[i]['subject']);
        context
            .read<Subs>()
            .prov_memo
            .add(list.docs[i]['memo']);
        context
            .read<Subs>()
            .start
            .add(list.docs[i]['startYMDT']);
        context
            .read<Subs>()
            .end
            .add(list.docs[i]['endYMDT']);
        context
            .read<Subs>()
            .type
            .add('퀴즈');
      }
    }
  }


  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 0, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 5));
    String subject = '';

    for (int i = 0;i<context.read<Subs>().prov_subjectname.length;i++){
      meetings.add(Meeting(context.read<Subs>().prov_subjectname[i], context.read<dates>().startDay[i], context.read<dates>().endDay[i], const Color(0xFF7D9DE2)));

    }

    meetings.add(Meeting('what', startTime, endTime, const Color(0xFFcc0066)));


    return meetings;
  }

  @override
  Widget build(BuildContext context) {
    setSchedure_Assingment();
    print('캘린더페이지 빌드');
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Scaffold(
        body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Personal').where('uid',isEqualTo: _authentication.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final docs = snapshot.data!.docs;

                return SfCalendar( // 캘린더 위젯
                  //showDatePickerButton: true,
                  //todayHighlightColor: Colors. amber, // 오늘 날짜 하이라이트 컬러
                  cellBorderColor: Colors.white, // 달력 셀 테두리 색상
                  showNavigationArrow: true, // 달력 화살표; 달력을 스와이프로 넘기지 않고 버튼으로 넘김
                  view: CalendarView.month, // 달력을 월별로 본다.
                  initialSelectedDate: DateTime.now(), // 프로그랩 켰을 때 처음 선택된 날짜
                  initialDisplayDate: DateTime.now(), // 처음에 달력에서 지정된 날짜로 이동해서 표시
                  cellEndPadding: 1, // 캘린더의 약속 패딩 사이즈 설정
                  todayHighlightColor: Color(0xFFcc0066),
                  headerStyle: const CalendarHeaderStyle( // December 2022 위치
                      textAlign: TextAlign.center,
                      textStyle: TextStyle(fontSize: 21)
                  ),
                  dataSource: MeetingDataSource(_getDataSource()), // 약속 일정 받아오기
                  // 일정 위젯에는 약속 모음을 기반으로 내부적으로 약속 정렬을 처리하는 기본 제공 기능이 있습니다. 생성된 컬렉션을 dataSource 속성 에 할당해야 합니다 .
                  // 맞춤 약속 데이터를 캘린더에 매핑할 수도 있습니다.
                  monthViewSettings: const MonthViewSettings(
                    // 달력 월 보기에는 선택한 날짜의 약속을 월 아래에 표시하는 데 사용되는 분할된 안건 보기가 표시됩니다.
                    //numberOfWeeksInView: 4, // 달력에 몇 주 나오게 하는지 설정
                    appointmentDisplayCount: 3, // 해당 날짜에 최대 몇개의 약속이 나오게 하는지 설정 (default:4)
                    // appointmentDisplayMode: 디스플레이 모드 속성을 사용하여 달력 월 보기 약속 표시를 처리할 수 있습니다
                    // MonthAppointmentDisplayMode.appointment(사각형), indicator(원), none(약속 표시X)
                    appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                    navigationDirection: MonthNavigationDirection.horizontal, // December 2022 옆에 화살표 방향을 < > 로 설정
                    agendaViewHeight: 170, // 일정 보기(아래)에 뜨는 컨테이너 틀의 높이 조절
                    agendaItemHeight: 50, // 일정 보기(아래)에 뜨는 약속(사각형) 높이 조절
                    showAgenda: true, // MonthViewSettings 에서 showAgenda 속성을 true로 설정하여 안건 보기를 표시할 수 있습니다
                  ),
                );
              }
          ),
        ),
      ),
    );
  }
}