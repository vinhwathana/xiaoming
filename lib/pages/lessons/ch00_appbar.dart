import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            //Company Logo
            //leading: IconButton( icon: Icon(Icons.menu, color: Colors.white,), onPressed: null),
            leading: Image.network(
                'https://mptc.gov.kh/wp-content/uploads/2020/05/PTC-HD-LOGO.png'),
            title: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('News'),
                  Text('Hot News'),
                ],
              ),
            ),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.settings, color: Colors.white,),
                onPressed: () {
                  print('Hello World');
                },)
            ],
          ),
        )
    );
  }
}