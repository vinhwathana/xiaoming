import 'package:flutter/material.dart';

class Gratitude extends StatefulWidget {
  final int radioGroupValue;

  const Gratitude({Key key, this.radioGroupValue}) : super(key: key);
  @override
  _GratitudeState createState() => _GratitudeState();
}

class _GratitudeState extends State<Gratitude> {
  List<String> _gratitudeList = List();
  String _selectedGratitude;
  int _radioGroupValue;

  void _radioOnChanged(int index) {
    setState(() {
      _radioGroupValue = index;
      _selectedGratitude = _gratitudeList[index];
      print('_selectedRadioValue $_selectedGratitude');
    });
  }

  @override
  void initState() {
    super.initState();
    _gratitudeList..add('Family')..add('Friend')..add('Coffee');
    _radioGroupValue = widget.radioGroupValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Radio(
                  value: 0,
                  groupValue: _radioGroupValue,
                  onChanged: (index) => _radioOnChanged(index),
                ),
                Text('Family'),
                Radio(
                  value: 1,
                  groupValue: _radioGroupValue,
                  onChanged: (index) => _radioOnChanged(index),
                ),
                Text('Friends'),
                Radio(
                  value: 2,
                  groupValue: _radioGroupValue,
                  onChanged: (index) => _radioOnChanged(index),
                ),
                Text('Coffee'),
              ],
            ),
          )),
      appBar: AppBar(
        title: Text('Gratitude'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () => Navigator.pop(context, _selectedGratitude),
          )
        ],
      ),
    );
  }
}
