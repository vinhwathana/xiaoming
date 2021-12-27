//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiaoming/pages/lessons/birthdays_08.dart';
import 'package:xiaoming/pages/lessons/gratitude_08.dart';
import 'package:xiaoming/pages/reminders_08.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_tabChanged);
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  void _tabChanged() {
    // Check if Tab Controller index is changing, otherwise we get the notice twice
    if (_tabController.indexIsChanging) {
      print('tabChanged: ${_tabController.index}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
          child: TabBar(
        controller: _tabController,
        labelColor: Colors.black54,
        unselectedLabelColor: Colors.black38,
        tabs: [
          Tab(
            icon: Icon(Icons.cake),
            text: 'Birthdays',
          ),
          Tab(
            icon: Icon(Icons.sentiment_satisfied),
            text: 'Gratitude',
          ),
          Tab(
            icon: Icon(Icons.access_alarm),
            text: 'Reminders',
          )
        ],
      )),
      body: SafeArea(
          child: TabBarView(
        controller: _tabController,
        children: [
          Birthdays(),
          Gratitude(),
          Reminders(),
        ],
      )),
      appBar: AppBar(
        title: Text('Home'),
      ),
    );
  }
}
