import 'package:flutter/material.dart';
class Fly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.shortestSide /2;
    return Scaffold(
      body: SafeArea(
        child: Hero(
          tag: 'format_paint',
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Icon(
              Icons.format_paint,
              color: Colors.lightBlue,
              size: _width,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('Fly'),
      ),
    );
  }
}
