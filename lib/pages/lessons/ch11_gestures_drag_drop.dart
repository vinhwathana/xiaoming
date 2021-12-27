//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _gestureDetected;
  GestureDetector _buildGestureDetector() {
    return GestureDetector(
      onTap: () {
        print('onTap');
        _displayGestureDetected('onTap');
      },
      onDoubleTap: () {
        print('onDoubleTap');
        _displayGestureDetected('onDoubleTap');
      },
      onLongPress: () {
        print('onLongPress');
        _displayGestureDetected('onLongPress');
      },
      onPanUpdate: (DragUpdateDetails details) {
        print('onPanUpdate: $details');
        _displayGestureDetected('onPanUpdate:\n$details');
      },
      onVerticalDragUpdate: ((DragUpdateDetails details) {
        print('onVerticalDragUpdate: $details');
        _displayGestureDetected('onVerticalDragUpdate:\n$details');
      }),
      child: Container(
        color: Colors.lightBlue.shade100,
        width: double.infinity,
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: <Widget>[
            Icon(
              Icons.access_alarm,
              size: 98.0,
            ),
            Text('$_gestureDetected'),
          ],
        ),
      ),
    );
  }

  Draggable<int> _buildDraggable() {
    return Draggable(
      child: Column(
        children: <Widget>[
          Icon(
            Icons.palette,
            color: Colors.deepOrange,
            size: 48.0,
          ),
          Text(
            'Drag Me below to change color',
          ),
        ],
      ),
      childWhenDragging: Icon(
        Icons.palette,
        color: Colors.grey,
        size: 48.0,
      ),
      feedback: Icon(
        Icons.brush,
        color: Colors.deepOrange,
        size: 80.0,
      ),
      data: Colors.deepOrange.value,
    );
  }

  DragTarget<int> _buildDragTarget() {
    var _paintedColor;
    return DragTarget<int>(
      onAccept: (colorValue) {
        _paintedColor = Color(colorValue);
      },
      builder: (BuildContext context, List<dynamic> acceptedData,
          List<dynamic> rejectedData) =>
      acceptedData.isEmpty
          ? Text(
        'Drag To and see color change',
        style: TextStyle(color: _paintedColor),
      )
          : Text(
        'Painting Color: $acceptedData',
        style: TextStyle(
          color: Color(acceptedData[0]),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _displayGestureDetected(String gesture) {
    setState(() {
      _gestureDetected = gesture;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _buildGestureDetector(),
            Divider(
              color: Colors.black,
              height: 44.0,
            ),
            _buildDraggable(),
            Divider(
              height: 44.0,
            ),
            _buildDragTarget(),
            Divider(
              color: Colors.black,
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Home'),
      ),
    );
  }
}
