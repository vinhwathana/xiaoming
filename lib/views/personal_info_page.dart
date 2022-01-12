//This is the main page for expansionTile
import 'package:flutter/material.dart';
import 'package:xiaoming/views/family_info_expansion_card.dart';
import 'package:xiaoming/views/profile_expansion_card.dart';

class PersonalInfoPage extends StatelessWidget {

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
                    FamilyInfoExpansionCard(),
                  ],
                ),
              ),
              Card(
                child: ExpansionTile(
                  title: Text('ប្រវត្តិការងារ'),
                  children: [
                    FamilyInfoExpansionCard(),
                  ],
                ),
              ),
              Card(
                child: ExpansionTile(
                  title: Text('ប្រវត្តិការរសិក្សា'),
                  children: [
                    FamilyInfoExpansionCard(),
                  ],
                ),
              ),
              Card(
                child: ExpansionTile(
                  title: Text('ភាសា'),
                  children: [
                    FamilyInfoExpansionCard(),
                  ],
                ),
              ),
              Card(
                child: ExpansionTile(
                  title: Text('កាំបៀវត្ស'),
                  children: [
                    FamilyInfoExpansionCard(),
                  ],
                ),
              ),
              Card(
                child: ExpansionTile(
                  title: Text('ឥស្សរិយយស្ស'),
                  children: [
                    FamilyInfoExpansionCard(),
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
