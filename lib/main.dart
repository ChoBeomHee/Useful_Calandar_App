import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:team/SubjectsProvider.dart';
import 'package:team/info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'schedule.dart';
import 'AddAssignExam.dart';
import 'AddPersonal.dart';
import 'AddSubject.dart';
import 'CalendarHomePage.dart';
import 'LoginPage.dart';
import 'RegisterPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/material/colors.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';


void main() async { // 1. await이 있기 떄문에 main 옆에 async 선언
  WidgetsFlutterBinding.ensureInitialized(); // 2. 이 문장 추가

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => Subs(),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false, //오른쪽 상단 DEBUG 배너 비활성화
        color: Color(0xFF343434),
        title: 'Flutter Demo',
        theme: ThemeData(fontFamily: 'text',// 기본 폰트 설정
            primaryColorLight: Color(0xFFA89b92),
            primaryColor: Color(0xFF343434),
            primarySwatch: MaterialColor(0xFF343434, {
              50 : Color(0xFF343434),
              100 : Color(0xFF343434),
              200 : Color(0xFF343434),
              300 : Color(0xFF343434),
              400 : Color(0xFF343434),
              500 : Color(0xFF343434),
              600 : Color(0xFF343434),
              700 : Color(0xFF343434),
              800 : Color(0xFF343434),
              900 : Color(0xFF343434),

            })),
        // 로그인 되었을 때는, Success Page 가 Home 화면이 되도록 해보겠다
        // StreamBuilder 사용, 파이어베이스에서 어떤 변화가 생겼을 때 변화를 감지할 수 있도록 도와주는 stream을 받아옴
        // 변화가 생겼다는게 감지가 되는 순간 반응을 할 수 있는 클래스
        home: AnimatedSplashScreen(
          splash: Image.asset('Assets/Images/cau1.png'),
          duration: 3000,
          splashTransition: SplashTransition.fadeTransition,
          nextScreen: StreamBuilder(
            // 2개 속성이 필요
            // 1. stream: 어떤 것을 계속 듣고 싶어 하냐 Stream<user?> Type
            // 로그인 되었는지, 로그아웃 되었는지 변화 감지해서 알려줌
              stream: FirebaseAuth.instance.authStateChanges(),
              // 전달되었을 때 어떤걸 할거냐 어떤걸 빌드할거냐
              builder: (context, snapshot) {
                // change 감지 하면 잠깐 스냅샷을 찍고 그 상태를 빌더에 전달하는거라고 생각
                // 스냅샷 전달 받은 이후 이 상황에서 내가 무얼 할거냐. 스냅샷을 통해 액션을 취하게 됨
                // 12강 11분 40초 ★★★★★★
                if (snapshot.hasData) { // 스냅샷이 hasData가 있다면(로그인 된 상태)면
                  // chat 페이지를 navigator.push를 통해 했었는데, 바뀐 다음엔 제거 해야됩니다. 중복성때문에
                  // chat 페이지와 로그인 페이지의 navigator에 해당하는 부분(push,pop)을 지워야 함
                  return const CalendarHomePage(title: '',);
                } else {
                  return const LoginPage();
                }
              }
          ),
        ),
      ),
    );
  }
}

/* 푸시 알림 함수
_initFirebaseMessaging(BuildContext context) {
  FirebaseMessaging.onMessage.listen((RemoteMessage event) {
    print(event.notification!.title);
    print(event.notification!.body);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("알림"),
            content: Text(event.notification!.body!),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  });
}
_getToken() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  print("messaging.getToken(), ${await messaging.getToken()}");
}
*/