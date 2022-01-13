import 'package:flutter/material.dart';
import 'package:xiaoming/views/mptc_education_info.dart';
import 'package:xiaoming/views/family_info_page.dart';
import 'package:xiaoming/views/mptc_krobkhan.dart';
import 'package:xiaoming/views/mptc_language.dart';
import 'package:xiaoming/views/mptc_merits.dart';
import 'package:xiaoming/views/personal_info_page.dart';
import 'package:xiaoming/views/statistics_page.dart';
import 'package:xiaoming/views/mptc_work_info.dart';
import 'package:xiaoming/components/custom_drawer.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
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
        drawer: const CustomDrawer(),
        body: SafeArea(
            child: TabBarView(
          children: [
            PersonalInfoPage(),
            FamilyInfoPage(),
            WorkInfo(),
            EducationInfo(),
            Language(),
            Krobkhan(),
            Merits(),
            StatisticsPage(),
          ],
        )),
      ),
    );
  }
}
