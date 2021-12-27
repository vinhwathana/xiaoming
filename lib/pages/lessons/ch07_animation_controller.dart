//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiaoming/widgets/animated_balloon_ch07.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                AnimatedBalloonWidget(),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('Home'),
      ),
    );
  }
}
