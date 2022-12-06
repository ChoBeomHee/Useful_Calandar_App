import 'package:flutter/material.dart';

class SuccessRegisterPage extends StatelessWidget {
  const SuccessRegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('Assets/Images/olaf.gif'),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('회원가입을 축하합니다!!', style: TextStyle(
                  fontFamily: 'title', fontSize: 25),),
              const SizedBox(height: 200,),
              FloatingActionButton(
                backgroundColor: Color(0xffdd6b35),
                  child: const Text('시작', style: TextStyle(
                    fontFamily: 'title',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  ),
                  onPressed: (){
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
              ),
              const SizedBox(height: 220,),
            ],
          ),
        ),
      ),
    );
  }
}