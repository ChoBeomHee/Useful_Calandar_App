import 'package:flutter/material.dart';

class Subs with ChangeNotifier {
  List<String> prov_subjectname = [];           // 이름 저장 리스트
  List<String> prov_memo = [];
  List<String> start = [];
  List<String> end = [];
  List<String> type = [];

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
  List<DateTime> startDay = [];
  List<DateTime> endDay = [];
}
