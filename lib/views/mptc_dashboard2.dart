//Homepage dashboard for gridview
import 'package:flutter/material.dart';
import 'package:xiaoming/components/mptc_gridview_builder.dart';
import 'package:xiaoming/components/mptc_left_drawer.dart';

class Dashboard2 extends StatefulWidget {
  @override
  _Dashboard2State createState() => _Dashboard2State();
}

class _Dashboard2State extends State<Dashboard2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ប្រព័ន្ធព័ត៌មានមន្ត្រីរាជការ'),
      ),
      drawer: const MPTCLeftDrawerWidget(),
      body: SafeArea(
        child: const MPTCGridViewBuilderWidget(),
      ),
    );
  }
}
