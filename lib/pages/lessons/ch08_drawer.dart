//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiaoming/pages/lessons/birthdays_08.dart';
import 'package:xiaoming/pages/lessons/gratitude.dart';
import 'package:xiaoming/pages/reminders_08.dart';
import 'package:xiaoming/widgets/left_drawer.dart';
import 'package:xiaoming/widgets/right_drawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(),
      ),
      appBar: AppBar(
        title: Text('Drawer'),
      ),
      drawer: const LeftDrawerWidget(),
      endDrawer: const RightDrawerWidget(),
    );
  }
}
