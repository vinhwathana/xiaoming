//This is the main page for expansionTile
import 'package:flutter/material.dart';
import 'package:xiaoming/views/mptc_family_info.dart';
import 'package:xiaoming/views/profile_expansion_card.dart';

class PersonalInfo extends StatelessWidget {

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
                    ProfileExpansionCard(),
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
