import 'package:flutter/material.dart';
import 'package:xiaoming/pages/mptc_education_info.dart';
import 'package:xiaoming/pages/mptc_family_info.dart';
import 'package:xiaoming/pages/mptc_krobkhan.dart';
import 'package:xiaoming/pages/mptc_language.dart';
import 'package:xiaoming/pages/mptc_merits.dart';
import 'package:xiaoming/pages/mptc_personal_info.dart';
import 'package:xiaoming/pages/mptc_statistics.dart';
import 'package:xiaoming/pages/mptc_work_info.dart';
import 'package:xiaoming/widgets/mptc_left_drawer.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Dashboard'),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                icon: Icon(Icons.person),
                text: 'Personal Info',
              ),
              Tab(icon: Icon(Icons.group), text: 'Family Info'),
              Tab(
                icon: Icon(Icons.work),
                text: 'Work Info',
              ),
              Tab(
                icon: Icon(Icons.school),
                text: 'Education Info',
              ),
              Tab(
                icon: Icon(Icons.language),
                text: 'Language(s)',
              ),
              Tab(text: 'Krob Khan'),
              Tab(
                text: 'Merits',
              ),
              Tab(
                text: 'Statistics',
              ),
            ],
          ),
        ),
        drawer: const MPTCLeftDrawerWidget(),
        body: SafeArea(
            child: TabBarView(
          children: [
            PersonalInfo(),
            FamilyInfo(),
            WorkInfo(),
            EducationInfo(),
            Language(),
            Krobkhan(),
            Merits(),
            Statistics(),
          ],
        )),
      ),
    );
  }
}
