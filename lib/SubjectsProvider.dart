import 'package:flutter/material.dart';

class Subs with ChangeNotifier {
  List<String> prov_subjectname = [];           // 이름 저장 리스트
  List<String> prov_memo = [];
  List<String> start = [];
  List<String> end = [];
  List<String> type = [];
  List<String> quizname = [];
  List<bool> progress = [];
  List<String> personalname = [];
  List<DateTime> personalday = [];
  List<DateTime> startDay = [];
  List<DateTime> endDay = [];

  List<String> anoder_prov_subjectname = [];           // 이름 저장 리스트
  List<String> anoder_prov_memo = [];
  List<String> anoder_start = [];
  List<String> anoder_end = [];
  List<String> anoder_type = [];
  List<String> anoder_quizname = [];

  List<String> anoder_personalname = [];
  List<DateTime> anoder_personalday = [];
  List<DateTime> anoder_startDay = [];
  List<DateTime> anoder_endDay = [];


  /*increaseMember(){
    MemeberCnt += 1;
    notifyListeners();
  }
  decreaseMember(){
    MemeberCnt -= 1;
    notifyListeners();
  }

  setter(String str){
    Name.add(str);
    notifyListeners();
  }*/
}

class dates with ChangeNotifier {

}
