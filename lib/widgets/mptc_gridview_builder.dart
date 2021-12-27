import 'package:flutter/material.dart';
import 'package:xiaoming/pages/mptc_personal_info.dart';
import 'package:xiaoming/pages/mptc_statistics.dart';
import 'package:xiaoming/widgets/mptc_grid_icons.dart';

class MPTCGridViewBuilderWidget extends StatefulWidget {
  const MPTCGridViewBuilderWidget({
    Key key,
  }) : super(key: key);

  @override
  _MPTCGridViewBuilderWidgetState createState() => _MPTCGridViewBuilderWidgetState();
}

class _MPTCGridViewBuilderWidgetState extends State<MPTCGridViewBuilderWidget> {
  List _listPages = [];
  
  @override
  void initState() {
    _listPages..add(PersonalInfo())..add(Statistics())..add(Statistics())..add(Statistics());
  }

  @override
  Widget build(BuildContext context) {
    List<IconData> _iconList = GridIcons().getIconList();
    List<String> _iconText = GridIcons().getIconText();

      return GridView.builder(
      itemCount: 4,
      padding: EdgeInsets.all(20.0),
      gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).primaryColor),
          margin: EdgeInsets.all(8.0),
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  _iconList[index],
                  size: 70.0,
                  color: Colors.white,
                ),
                Divider(),
                Text(
                  _iconText[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                )
              ],
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> _listPages[index]));
            }
          ),
        );
      },
    );
  }
}
