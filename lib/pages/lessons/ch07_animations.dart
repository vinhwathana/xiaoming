//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiaoming/widgets/animated_container_ch07.dart';
import 'package:xiaoming/widgets/animated_cross_fade_ch07.dart';
import 'package:xiaoming/widgets/animated_opacity07.dart';
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
            AnimatedContainerWidget(),
            Divider(),
            AnimatedCrossFadeWidget(),
            Divider(),
            AnimatedOpacityWidget()
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Home'),
      ),
    );
  }
}
