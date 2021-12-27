//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiaoming/widgets//header09.dart';
import 'package:xiaoming/widgets/row_with_card09.dart';
import 'package:xiaoming/widgets/row09.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return HeaderWidget(index: index);
            } else if (index >= 1 && index <= 3) {
              return RowWithCardWidget(index: index);
            } else {
              return RowWidget(index: index);
            }
          },
        ),
      ),
      appBar: AppBar(
        title: Text('Home'),
      ),
    );
  }
}
