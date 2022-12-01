import 'package:flutter/material.dart';

class Subs with ChangeNotifier {
  List<String> prov_subjectname = [];           // 이름 저장 리스트
  List<String> prov_memo = [];
  List<String> start = [];
  List<String> end = [];

  List<String> prov_subjectname_exam = [];           // 이름 저장 리스트
  List<String> prov_memo_exam = [];
  List<String> start_exam = [];
  List<String> end_exam = [];
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
