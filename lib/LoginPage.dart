import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:team/CalendarPage.dart';
import 'RegisterPage.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool showSpinner = false;
  // 얠 통해서 또 로그인 할거야
  final _authentication = FirebaseAuth.instance;
  // Form 위젯을 쓸 땐 global key 를 넣어야 함
  final _formkey = GlobalKey<FormState>();
  String email = '';
  String password = ''; // 입력할때마다 이 변수에 값 넣어줄거야
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('Assets/Images/snow7.gif'),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            // global key를 사용하는 거의 유일한 사용
            key: _formkey,
            child: ListView(
              children: [
                SizedBox(height: 100,),
                Container(
                  child: Text('아.. 맞다!', style: TextStyle(fontSize: 40,
                    fontWeight : FontWeight.bold , color: Color(0xFFFdf6eb
                      ), fontFamily: 'title' ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 40,),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.people, color: Color(0xFF9c9c94),),
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3, color: Color(0xFF9c9c94),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20),
                      ),
                    ),
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Color(0xFF9c9c94),),
                  ),
                  onChanged: (value) { // value를 input 으로 넣음
                    email = value; // 입력할 때 마다 변할거임
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  obscureText: true, // 입력시 ****** 처리
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.password, color: Color(0xFF9c9c94),),
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3, color: Color(0xFF9c9c94),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20),
                      ),
                    ),
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Color(0xFF9c9c94),),
                  ),
                  onChanged: (value) {
                    password = value;
                  },
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 10,
                      backgroundColor: Color(0xFF9c9c94),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                        side: BorderSide(color: Color(0xFFFdf6eb),),
                      ),
                    ),
                    onPressed: () async {
                      try {
                        // onPressed 누르고 직후부터 로그인 되기전까지 돌리고 싶음
                        // onPressed 누르고 바로 하게 하기 위해 setState를 통해 새로 빌드를 해야겠지
                        setState(() {
                          showSpinner = true;
                        });
                        // future Type
                        final currentUser = await _authentication
                            .signInWithEmailAndPassword(
                            email: email, password: password);
                        if (currentUser.user != null) {
                          _formkey.currentState!.reset();
                          if (!mounted) return;
                        }
                      } catch (e) {
                        print(e);
                      }
                    }, child: const Text('로그인', style: TextStyle(fontFamily: 'title'),)),
                SizedBox(height: 20,),
                Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container( height:1.0,
                          width:150.0,
                          color:Color(0xFFFdf6eb),),
                        Text('  또는  ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey),),
                        Container( height:1.0,
                          width:150.0,
                          color:Color(0xFFFdf6eb),),
                      ],
                    )
                ),
                const SizedBox(height: 20,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text('아직 계정이 없으신가요?', style: TextStyle(
                        color: Color(0xFFFdf6eb),
                      ),),
                      TextButton(
                        child: const Text('가입하기', style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'title',
                        ),),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
                          // 페이지 넘어가면 다시 없어지게 해야지
                          setState(() {
                            showSpinner = false;
                          });
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}