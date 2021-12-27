import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _mpgValue = TextEditingController();
  double _result = 0;

  void _convert() {
    _result = double.parse(_mpgValue.text) * 1.61 / 3.79;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.menu, color: Colors.white)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Cambodia Prius KM/L'),
          ],
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {})
        ],
      ),
      body: SafeArea(
          child: Container(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage("assets/images/cambodia_flag.jpg"),
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width / 4,
              ),
              Image(
                image: AssetImage("assets/images/prius_text.jpg"),
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width / 2,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                textAlign: TextAlign.center,
                controller: _mpgValue,
                style: TextStyle(fontSize: 30),
                textInputAction: TextInputAction.go,
                decoration: InputDecoration(
                  hintText: 'សូមបញ្ចូលលេខ MPG ដើម្បីគណនា',
                  hintStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 15,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _convert();
                      });
                    },
                    child: Text(
                      'គណនា',
                      style: TextStyle(fontSize: 20),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '100 KM ចំណាយសាំង ${(100 / _result).toStringAsFixed(2)} L\n'
                '1L រថយន្តអ្នកអាចបើកបាន ${_result.toStringAsFixed(2)} KM',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
