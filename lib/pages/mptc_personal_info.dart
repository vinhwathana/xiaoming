//This is the main page for expansionTile
import 'package:flutter/material.dart';
import 'package:xiaoming/pages/mptc_family_info.dart';
import 'package:xiaoming/pages/mptc_profile.dart';

class PersonalInfo extends StatefulWidget {
  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ព័ត៌មានផ្ទាល់ខ្លួន'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: ExpansionTile(
                  title: Text('ព័ត៌មានផ្ទាល់ខ្លួន'),
                  children: [
                    Profile(),
                  ],
                ),
              ),
              Card(
                child: ExpansionTile(
                  title: Text('ព័ត៌មានគ្រួសារ'),
                  children: [
                    FamilyInfo(),
                  ],
                ),
              ),
              Card(
                child: ExpansionTile(
                  title: Text('ប្រវត្តិការងារ'),
                  children: [
                    FamilyInfo(),
                  ],
                ),
              ),
              Card(
                child: ExpansionTile(
                  title: Text('ប្រវត្តិការរសិក្សា'),
                  children: [
                    FamilyInfo(),
                  ],
                ),
              ),
              Card(
                child: ExpansionTile(
                  title: Text('ភាសា'),
                  children: [
                    FamilyInfo(),
                  ],
                ),
              ),
              Card(
                child: ExpansionTile(
                  title: Text('កាំបៀវត្ស'),
                  children: [
                    FamilyInfo(),
                  ],
                ),
              ),
              Card(
                child: ExpansionTile(
                  title: Text('ឥស្សរិយយស្ស'),
                  children: [
                    FamilyInfo(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}