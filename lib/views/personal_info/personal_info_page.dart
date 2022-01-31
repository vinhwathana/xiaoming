//This is the main page for expansionTile
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiaoming/views/personal_info/additional_position_page.dart';
import 'package:xiaoming/views/personal_info/education_info_page.dart';
import 'package:xiaoming/views/personal_info/family_info_page.dart';
import 'package:xiaoming/views/personal_info/krob_khan_page.dart';
import 'package:xiaoming/views/personal_info/language_info_page.dart';
import 'package:xiaoming/views/personal_info/merit_info_page.dart';
import 'package:xiaoming/views/personal_info/work_history_page.dart';
import 'package:xiaoming/views/personal_info/profile_expansion_card.dart';

class PersonalInfoPage extends StatelessWidget {
  const PersonalInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ព័ត៌មានផ្ទាល់ខ្លួន'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Card(
                child: ExpansionTile(
                  title: Text('ព័ត៌មានផ្ទាល់ខ្លួន'),
                  children: [
                    ProfileExpansionCard(),
                  ],
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('ព័ត៌មានគ្រួសារ'),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () => Get.to(
                    () => const FamilyInfoPage(),
                    arguments: "ព័ត៌មានគ្រួសារ",
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('ប្រវត្តិការងារ'),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () => Get.to(() => const WorkHistoryPage(),
                      arguments: "ប្រវត្តិការងារ"),
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('មុខងារបន្ថែម'),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () => Get.to(() => const AdditionalPositionPage(),
                      arguments: "មុខងារបន្ថែម"),
                ),
              ),

              Card(
                child: ListTile(
                  title: const Text('ប្រវត្តិការរសិក្សា'),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () => Get.to(() => const EducationInfoPage(),
                      arguments: "ប្រវត្តិការរសិក្សា"),
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('ភាសា'),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () => Get.to(
                    () => const LanguageInfoPage(),
                    arguments: "ភាសា",
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('កាំបៀវត្ស'),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () => Get.to(
                    () => const KrobKhanPage(),
                    arguments: "កាំបៀវត្ស",
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('ឥស្សរិយយស្ស'),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () =>
                      Get.to(() => const MeritInfoPage(), arguments: "ឥស្សរិយយស្ស"),
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
