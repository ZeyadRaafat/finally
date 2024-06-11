import 'package:flutter/material.dart';
import 'package:Guide/StartPages/home_page.dart';
import 'package:Guide/StartPages/log_in.dart';
import 'package:Guide/StartPages/about_page.dart';
import 'package:Guide/StartPages/sign_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Guide/popular%20destination/Destinations/Alex/info.dart';
import 'package:Guide/popular%20destination/Destinations/Cairo/info.dart';
import 'package:Guide/popular%20destination/Destinations/Hurghada/info.dart';
import 'package:Guide/popular%20destination/Destinations/LuxorAswan/info.dart';
import 'package:Guide/popular%20destination/Destinations/Sinai/info.dart';
import 'package:Guide/popular%20destination/Destinations/Siwa/info.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyBkrE1TxyOZo-BqQaCxe7XtAXGquFFf5bQ",
        appId: "1:783783765577:web:e5bd6545033c9882fa0198",
        messagingSenderId: "783783765577",
        projectId: "tourismproject-21995",
        // Your web Firebase config options
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(flutterproject());
}

class flutterproject extends StatelessWidget {
  const flutterproject({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: MaterialApp(
        title: "tourism guide",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xFFE6969),
        ),
        home: Homepage(),
        initialRoute: 'homepage',
        routes: {
          'alex': (context) => SecRoute(),
          'cairo': (context) => FirstRoute(),
          'hurghad': (context) => FifthRoute(),
          'luxAndAsw': (context) => ThirdRoute(),
          'siwa': (context) => FourthRoute(),
          'sinai': (context) => SixthRoute(),        
          'login': (context) => Login(),
          'homepage': (context) => Homepage(),
          // 'mytrips': (context) => Mytrips(),

          About.screenRoute: (context) => About(),
          Homepage.screenRoute: (context) => Homepage(),
          Signup.screenRoute: (context) => Signup(),
          Login.screenRoute: (context) => Login(),
        },
      ),
    );
  }
}


