import 'package:flutter/material.dart';
import 'package:xiaoming/pages/mptc_home_hr.dart';
//import 'package:xiaoming/pages/mptc_signup_hr.dart';
//import 'package:xiaoming/pages/mptc_forgetpassword_hr.dart';
//import 'package:xiaoming/pages/mptc_dashboard.dart';
//import 'package:xiaoming/pages/mptc_profile2.dart';
//import 'package:xiaoming/pages/mptc_personal_info.dart';
void main() {
  runApp(MyApp());}

class MyApp extends StatelessWidget {
  Map<int, Color> color =
  {
    50:Color.fromRGBO(51, 153, 255, .1),
    100:Color.fromRGBO(51, 153, 255, .2),
    200:Color.fromRGBO(51, 153, 255, .3),
    300:Color.fromRGBO(51, 153, 255, .4),
    400:Color.fromRGBO(51, 153, 255, .5),
    500:Color.fromRGBO(51, 153, 255, .6),
    600:Color.fromRGBO(51, 153, 255, .7),
    700:Color.fromRGBO(51, 153, 255, .8),
    800:Color.fromRGBO(51, 153, 255, .9),
    900:Color.fromRGBO(51, 153, 255, 1),
  };
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Starter Template',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF003D7C, color),
        primaryColor: MaterialColor(0xFF003D7C, color),
        //primaryColor: Color(0xFF005D86),
        accentColor: Color(0xFF024466),
        fontFamily: 'KhmerOSBattambong',
        //canvasColor: Colors.blue,
      ),
      home: Home(),
    );
  }
}
