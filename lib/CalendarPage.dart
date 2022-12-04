import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:team/calendar/meeting_data_source.dart';
import 'calendar/meeting.dart';
import 'package:provider/provider.dart';
import 'package:team/SubjectsProvider.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {         // 메인 페이지
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;
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

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
    DateTime(today.year, today.month, today.day, 0, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 5));

    meetings.add(Meeting('Conference', startTime, endTime, const Color(0xFF7D9DE2)));
    meetings.add(Meeting('what', startTime, endTime, const Color(0xFFcc0066)));

    /*
    if(context.read<Subs>().day.length != 0){
      meetings.add(Meeting('TTEXT', startTime, endTime, const Color(0xFF7D9DE2)));
    }
    print(context.read<Subs>().day.length);
    */

    return meetings;
  }

  @override
  Widget build(BuildContext context) {
    print('캘린더페이지 빌드');
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Scaffold(
        body: SafeArea(
          child: SfCalendar( // 캘린더 위젯
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
                // 캘린더 스타일 설정
                monthCellStyle: MonthCellStyle(
                    backgroundColor: Color(0xFFF5875e),
                    trailingDatesBackgroundColor: Color(0xffF9b658),
                    leadingDatesBackgroundColor: Color(0xffF9b658),
                    todayBackgroundColor: Color(0xFFF99e94),
                    textStyle: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Arial'),
                    todayTextStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Arial'),
                    trailingDatesTextStyle: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                        fontFamily: 'Arial'),
                    leadingDatesTextStyle: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                        fontFamily: 'Arial')),
              // 일정 보기(아래) 스타일 설정
              agendaStyle: AgendaStyle(
                backgroundColor: Color(0xFF066cccc),
                appointmentTextStyle: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF0ffcc00)),
                dateTextStyle: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Colors.black),
                dayTextStyle: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }
}