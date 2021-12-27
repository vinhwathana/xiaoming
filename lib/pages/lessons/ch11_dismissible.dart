//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Trip {
  String id;
  String tripName;
  String tripLocation;
  Trip({this.id, this.tripName, this.tripLocation});
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _trips = <Trip>[];
  @override
  void initState() {
    super.initState();
    _trips
      ..add(Trip(id: '0', tripName: 'Angkor Wat', tripLocation: 'Siem Reap'))
      ..add(Trip(id: '1', tripName: 'Bokor', tripLocation: 'Kompot'))
      ..add(Trip(id: '2', tripName: 'Royal Palace', tripLocation: 'Phnom Penh'))
      ..add(Trip(id: '3', tripName: 'Kouland', tripLocation: 'Siem Reap'))
      ..add(Trip(id: '4', tripName: 'London', tripLocation: 'England'))
      ..add(Trip(id: '5', tripName: 'Sydney', tripLocation: 'Australia'))
      ..add(Trip(
          id: '6', tripName: 'Phnom Kongry', tripLocation: 'Kompong Chhnang'))
      ..add(Trip(id: '7', tripName: 'Rio de Janeiro', tripLocation: 'Brazil'))
      ..add(Trip(id: '8', tripName: 'Cusco', tripLocation: 'Peru'))
      ..add(Trip(id: '9', tripName: 'New Delhi', tripLocation: 'India'))
      ..add(Trip(id: '10', tripName: 'Tokyo', tripLocation: 'Japan'));
  }

  void _markTripCompleted() {
// Mark trip completed in Database or web service
  }
  void _deleteTrip() {
// Delete trip from Database or web service
  }
  Widget build(BuildContext context) {
    ListTile _buildListTile(int index) {
      return ListTile(
        title: Text('${_trips[index].tripName}'),
        subtitle: Text(_trips[index].tripLocation),
        leading: Icon(Icons.flight),
        trailing: Icon(Icons.fastfood),
      );
    }

    Container _buildCompleteTrip() {
      return Container(
        color: Colors.green,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.done,
                color: Colors.white,
              ),
            ],
          ),
        ),
      );
    }

    Container _buildRemoveTrip() {
      return Container(
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: ListView.builder(
        itemCount: _trips.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(_trips[index].id),
            child: _buildListTile(index),
            background: _buildCompleteTrip(),
            secondaryBackground: _buildRemoveTrip(),
            onDismissed: (DismissDirection direction) {
              direction == DismissDirection.startToEnd
                  ? _markTripCompleted()
                  : _deleteTrip();
// Remove item from List
              setState(() {
                _trips.removeAt(index);
              });
            },
          );
        },
      ),
      appBar: AppBar(
        title: Text('Home'),
      ),
    );
  }
}
