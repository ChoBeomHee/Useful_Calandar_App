import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:team/SubjectsProvider.dart';

class personalView extends StatefulWidget {
  const personalView({Key? key}) : super(key: key);

  @override
  State<personalView> createState() => _personalViewState();
}

class _personalViewState extends State<personalView> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;
  @override
  // State가 처음 만들어졌을때만 하는 것
  void initState() {
    // TODO: implement initState
    super
        .initState(); // 이걸 먼저 해줘야함(부모 클래스로부터 받아옴, Stateful 위젯 안에 initState가 있기때문에)
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _authentication
          .currentUser; // _authentication 의 currentUser을 대입
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
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60), // 모서리를 둥글게
              border: Border.all(color: Colors.indigo, width: 13)),
          child: Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListTile(
                title: Text('개인 일정', style: TextStyle(fontSize: 20),),
              ),
            ),
          )
        ),
      ),
    );
  }
}
