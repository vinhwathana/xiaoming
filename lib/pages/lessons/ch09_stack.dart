//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiaoming/widgets/stack.dart';
import 'package:xiaoming/widgets/stack_favorite.dart';
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
          itemCount: 7,
          itemBuilder: (BuildContext context, int index) {
            if (index.isEven) {
              return const StackWidget();
            } else {
              return const StackFavoriteWidget();
            }
          },
        ),
      ),
    );
  }
}