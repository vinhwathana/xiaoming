//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiaoming/pages/lessons/birthdays_08.dart';
import 'package:xiaoming/pages/lessons/gratitude_08.dart';
import 'package:xiaoming/pages/reminders_08.dart';

class MenuListTileWidget extends StatefulWidget {
  const MenuListTileWidget({
    Key key,
  }) : super (key: key);
  @override
  _MenuListTileWidgetState createState() => _MenuListTileWidgetState();
}

class _MenuListTileWidgetState extends State<MenuListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.cake),
          title: Text('Birthdays'),
          onTap: (){
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Birthdays(),
                )
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.sentiment_satisfied),
          title: Text('Gratitude'),
          onTap: (){
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Gratitude(),
                )
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.alarm),
          title: Text('Reminders'),
          onTap: (){
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Reminders(),
                )
            );
          },
        ),
        Divider(color: Colors.grey,),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Setting'),
          onTap: (){
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
