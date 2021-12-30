import 'package:flutter/material.dart';
//import 'package:xiaoming/pages/api_test2.dart';
//import 'package:xiaoming/pages/lessons/aba_clone.dart';
import 'package:xiaoming/pages/mptc_home_hr.dart';
//import 'package:xiaoming/pages/mptc_signup_hr.dart';
//import 'package:xiaoming/pages/mptc_forgetpassword_hr.dart';
//import 'package:xiaoming/pages/mptc_dashboard.dart';
//import 'package:xiaoming/pages/mptc_profile2.dart';
//import 'package:xiaoming/pages/mptc_personal_info.dart';
//import 'package:xiaoming/pages/template.dart';
//import 'package:xiaoming/pages/ch00_appbar.dart';
//import 'package:xiaoming/pages/ch05_widget_tree.dart';
//import 'package:xiaoming/pages/ch05_widget_tree_performance.dart';
//import 'package:xiaoming/pages/ch06_basic_widget.dart';
//import 'package:xiaoming/pages/ch06_images.dart';
//import 'package:xiaoming/pages/ch06_form_validation.dart';
//import 'package:xiaoming/pages/ch06_orientation.dart';
//import 'package:xiaoming/pages/ch07_animations.dart';
//import 'package:xiaoming/pages/ch07_animation_controller.dart';
//import 'package:xiaoming/pages/ch07_ac_staggered_animations.dart';
//import 'package:xiaoming/pages/ch08_navigator.dart';
//import 'package:xiaoming/pages/ch08_hero_animation.dart';
//import 'package:xiaoming/pages/ch08_bottom_navigator_bar.dart';
//import 'package:xiaoming/pages/ch08_bottom_app_bar.dart';
//import 'package:xiaoming/pages/ch08_tabbar.dart';
//import 'package:xiaoming/pages/ch08_drawer.dart';
//import 'package:xiaoming/pages/ch09_listview.dart';
//import 'package:xiaoming/pages/ch09_gridview.dart';
//import 'package:xiaoming/pages/ch09_stack.dart';
//import 'package:xiaoming/pages/ch09_customscrollview_slivers.dart';
//import 'package:xiaoming/pages/ch11_gestures_drag_drop.dart';
//import 'package:xiaoming/pages/ch11_dismissible.dart';
//import 'package:xiaoming/pages/ch11_gestures_scale_book.dart';
//import 'package:xiaoming/pages/ch12_platform_channel.dart';
//import 'package:xiaoming/pages/ch13_local_persistence.dart';
//import 'package:xiaoming/pages/ch14_journal.dart';
//import 'package:xiaoming/pages/ming/test.dart';
//import 'package:xiaoming/prius/mpg_kml.dart';
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
