import 'package:flutter/material.dart';

class SubjectInfo extends StatelessWidget {
  const SubjectInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('과목 정보'),
      ),
      body: Center(
        child: Text('과목 정보 페이지입니다.'),
      ),
    );
  }
}
