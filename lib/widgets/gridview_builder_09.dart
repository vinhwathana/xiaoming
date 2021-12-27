import 'package:flutter/material.dart';
import 'package:xiaoming/widgets/grid_icons_09.dart';

class GridViewBuilderWidget extends StatelessWidget {
  const GridViewBuilderWidget({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<IconData> _iconList = GridIcons().getIconList();
    return GridView.builder(
      itemCount: 20,
      padding: EdgeInsets.all(8.0),
      gridDelegate:
          SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 150.0),
      itemBuilder: (BuildContext context, int index) {
        print('_buildGridViewBuilder $index');
        return Card(
          color: Colors.lightBlue.shade50,
          margin: EdgeInsets.all(8.0),
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  _iconList[index],
                  size: 48.0,
                  color: Colors.lightBlue,
                ),
                Divider(),
                Text(
                  'Index $index',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                )
              ],
            ),
            onTap: () {
              print('Row $index');
            },
          ),
        );
      },
    );
  }
}
