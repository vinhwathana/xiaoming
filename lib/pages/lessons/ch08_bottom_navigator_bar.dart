//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'gratitude_08.dart';
import '../reminders_08.dart';
import 'birthdays_08.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  int _currentIndex = 0;
  List _listPages = List();
  Widget _currentPage;

  @override
  void initState() {
    _listPages..add(Birthdays())..add(Gratitude())..add(Reminders());
    _currentPage = Birthdays();
  }

  void _changePage(int selectedIndex) {
    setState(() {
      _currentIndex = selectedIndex;
      _currentPage = _listPages[selectedIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _currentPage,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.cake),
            title: Text('Birthdays'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sentiment_satisfied),
            title: Text('Gratitude'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_alarm),
            title: Text('Reminders'),
          ),
        ],
        onTap: (selectedIndex) => _changePage(selectedIndex),
      ),
      appBar: AppBar(
        title: Text('Home'),
      ),
    );
  }
}
