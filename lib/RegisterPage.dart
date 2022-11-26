import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team/CalendarPage.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: const RegisterForm(),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  // 파이어베이스랑 연동을 시킬 뭔가 주체가 될 만한 걸 만들어 놓음
  final _authentication = FirebaseAuth.instance;
  // Form 위젯을 쓸 땐 global key 를 넣어야 함
  final _formkey = GlobalKey<FormState>();
  String email = '';
  String password = ''; // 입력할때마다 이 변수에 값 넣어줄거야
  String userName = '';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        // global key를 사용하는 거의 유일한 사용
        key: _formkey,
        child: ListView(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              onChanged: (value) { // value를 input 으로 넣음
                email = value; // 입력할 때 마다 변할거임
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              obscureText: true, // 입력시 ****** 처리
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              onChanged: (value) {
                password = value;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              // 생성후 터미널에 flutter pub add cloud_firestore 치기
              decoration: const InputDecoration(
                labelText: 'User Name',
              ),
              onChanged: (value) {
                userName = value;
              },
            ),
            ElevatedButton(
              // 버튼 눌렀을 때 register 하는 기능
              // create를 하면 파이어 베이스랑 연동시키는 부분은 이거 하나임
              // 주의해야할 점: 함수가 future 타입(비동기 방식)
              // 우리는 로그인 하고 무언가 되길 원하는데(동기적인걸), 이게 등록이 된 다음에 뭔가가 되길 원하고 있음
              // 따라서 await 를 붙여줌 -> 붙여주려면 async 함수에서만 쓸 수 있음
                onPressed: () async {
                  try {
                    final newUser = await _authentication.createUserWithEmailAndPassword(email: email, password: password);
                    // set은 futuer type 이므로 비동기적 방식으로 불러와지는데, 우린 동기적 방식으로 사용할거야
                    await FirebaseFirestore.instance.collection('user').doc(newUser.user!.uid).set({
                      'userName' : userName,
                      'email' : email,
                    });
                    if (newUser.user != null) { // null이 아니면 입력한 폼들을 다 비울 것이다.(빈칸으로)
                      _formkey.currentState!.reset(); // 빨간줄 -> null이 되면 안된다 -> ! 붙여주기
                      if (!mounted) return;
                      // state가 tree에 마운트가 되었다를 확인하고 push를 하는게 좋음(오류 없음)
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const CalendarPage()));
                    }
                  } catch (e) { // 익명함수 e를 받음
                    print(e);
                  }
                },
                child: const Text('Enter')),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text('If you already registered, '),
                TextButton(
                  child: const Text('Login with your email'),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}