//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:xiaoming/widgets/menu_list_title.dart';
import 'package:xiaoming/widgets/mptc_menu_list_title.dart';

class MPTCLeftDrawerWidget extends StatefulWidget {
  const MPTCLeftDrawerWidget({
    Key key,
  }) : super(key: key);
  @override
  _MPTCLeftDrawerWidgetState createState() => _MPTCLeftDrawerWidgetState();
}

class _MPTCLeftDrawerWidgetState extends State<MPTCLeftDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        //color: Theme.of(context).primaryColor,
        child: ListView(
          children: [
            // UserAccountsDrawerHeader(
            //   currentAccountPicture: CircleAvatar(
            //     radius: 45,
            //     backgroundColor: Colors.black45,
            //     child: CircleAvatar(
            //       radius: 43,
            //       backgroundImage:
            //           AssetImage('assets/images/cambodia_flag.jpg'),
            //     ),
            //   ),
            //   accountName: Text('វិញ វឌ្ឍនា'),
            //   accountEmail: Text('wathana.luct@gmail.com'),
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage('assets/images/mptc_logo.png'),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),
            CircleAvatar(
              radius: 45,
              backgroundColor: Colors.black45,
              child: CircleAvatar(
                radius: 43,
                backgroundImage: AssetImage('assets/images/cambodia_flag.jpg'),
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Text(
              'វិញ វឌ្ឍនា',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Divider(),
            const MPTCMenuListTileWidget(),
          ],
        ),
      ),
    );
  }
}
