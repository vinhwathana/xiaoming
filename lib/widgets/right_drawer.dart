//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiaoming/widgets/menu_list_title.dart';

class RightDrawerWidget extends StatefulWidget {
  const RightDrawerWidget({
    Key key,
  }) : super(key: key);
  @override
  _RightDrawerWidgetState createState() => _RightDrawerWidgetState();
}

class _RightDrawerWidgetState extends State<RightDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: Icon(
              Icons.face,
              size: 128.0,
              color: Colors.white54,
            ),
            decoration: BoxDecoration(color: Colors.blue),
          ),
          const MenuListTileWidget(),
        ],
      ),
    );
  }
}
