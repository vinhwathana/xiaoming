//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiaoming/widgets/gridview_builder_09.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: const GridViewBuilderWidget(),
      ),
      appBar: AppBar(
        title: Text('Home'),
      ),
    );
  }
}
