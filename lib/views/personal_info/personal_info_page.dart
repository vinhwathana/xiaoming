//This is the main page for expansionTile
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiaoming/views/personal_info/additional_position_page.dart';
import 'package:xiaoming/views/personal_info/education_info_page.dart';
import 'package:xiaoming/views/personal_info/family_info_page.dart';
import 'package:xiaoming/views/personal_info/work_history_page.dart';
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
              // Card(
              //   child: ExpansionTile(
              //     title: Text('ព័ត៌មានគ្រួសារ'),
              //     children: [
              //       FamilyInfoExpansionCard(),
              //     ],
              //   ),
              // ),

              Card(
                child: ListTile(
                  title: Text('ព័ត៌មានគ្រួសារ'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () => Get.to(() => FamilyInfoPage(),
                      arguments: "ព័ត៌មានគ្រួសារ"),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('ប្រវត្តិការងារ'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () => Get.to(() => WorkHistoryPage(),
                      arguments: "ប្រវត្តិការងារ"),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('មុខងារបន្ថែម'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () => Get.to(() => AdditionalPositionPage(),
                      arguments: "មុខងារបន្ថែម"),
                ),
              ),

              Card(
                child: ListTile(
                  title: Text('ប្រវត្តិការរសិក្សា'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () => Get.to(() => EducationInfoPage(),
                      arguments: "ប្រវត្តិការរសិក្សា"),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('ភាសា'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () =>
                      Get.to(() => FamilyInfoPage(), arguments: "ភាសា"),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('កាំបៀវត្ស'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () =>
                      Get.to(() => FamilyInfoPage(), arguments: "កាំបៀវត្ស"),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('ឥស្សរិយយស្ស'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () =>
                      Get.to(() => FamilyInfoPage(), arguments: "ឥស្សរិយយស្ស"),
                ),
              ),
              // Card(
              //   child: ExpansionTile(
              //     title: Text('ប្រវត្តិការងារ'),
              //     children: [
              //       FamilyInfoPage(),
              //     ],
              //   ),
              // ),
              // Card(
              //   child: ExpansionTile(
              //     title: Text('ប្រវត្តិការរសិក្សា'),
              //     children: [
              //       FamilyInfoPage(),
              //     ],
              //   ),
              // ),
              // Card(
              //   child: ExpansionTile(
              //     title: Text('ភាសា'),
              //     children: [
              //       FamilyInfoPage(),
              //     ],
              //   ),
              // ),
              // Card(
              //   child: ExpansionTile(
              //     title: Text('កាំបៀវត្ស'),
              //     children: [
              //       FamilyInfoPage(),
              //     ],
              //   ),
              // ),
              // Card(
              //   child: ExpansionTile(
              //     title: Text('ឥស្សរិយយស្ស'),
              //     children: [
              //       FamilyInfoPage(),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
