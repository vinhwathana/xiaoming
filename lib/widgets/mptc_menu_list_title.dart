
import 'package:flutter/material.dart';
import 'package:xiaoming/pages/mptc_dashboard2.dart';
import 'package:xiaoming/pages/mptc_home_hr.dart';
import 'package:xiaoming/pages/mptc_personal_info.dart';
import 'package:xiaoming/pages/mptc_profile2.dart';

class MPTCMenuListTileWidget extends StatefulWidget {
  const MPTCMenuListTileWidget({
    Key key,
  }) : super (key: key);
  @override
  _MPTCMenuListTileWidgetState createState() => _MPTCMenuListTileWidgetState();
}

class _MPTCMenuListTileWidgetState extends State<MPTCMenuListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.home),
          title: Text('ទំព័រដើម'),
          onTap: (){
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Dashboard2(),
                )
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('ព័ត៌មានផ្ទាល់ខ្លួន'),
          onTap: (){
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PersonalInfo(),
                )
            );
          },
        ),
        // ListTile(
        //   leading: Icon(Icons.cast_for_education),
        //   title: Text('CV'),
        // ),
        ListTile(
          leading: Icon(Icons.calendar_today),
          title: Text('វត្តមាន'),
        ),
        ListTile(
          leading: Icon(Icons.insert_drive_file),
          title: Text('ឯកសារ'),
        ),
        // ListTile(
        //   leading: Icon(Icons.print),
        //   title: Text('Print'),
        // ),
        Divider(),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('ចាកចេញ'),
          onTap: (){
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Home(),
                )
            );
          },
        )
      ],
    );
  }
}
