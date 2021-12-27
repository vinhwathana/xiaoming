//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiaoming/widgets/animated_balloon_stagger_ch07.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            AnimatedBalloonWidget(),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Home'),
      ),
    );
  }
}
