// //This is the main page for expansionTile
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:xiaoming/views/personal_info/additional_position_info_page.dart';
// import 'package:xiaoming/views/personal_info/education_history_info_page.dart';
// import 'package:xiaoming/views/personal_info/family_history_info_page.dart';
// import 'package:xiaoming/views/personal_info/krob_khan_info_page.dart';
// import 'package:xiaoming/views/personal_info/language_info_page.dart';
// import 'package:xiaoming/views/personal_info/merit_info_page.dart';
// import 'package:xiaoming/views/personal_info/work_history_info_page.dart';
// import 'package:xiaoming/views/personal_info/personal_info_page.dart';
//
// class UserInfoPage extends StatelessWidget {
//   const UserInfoPage({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('ព័ត៌មានផ្ទាល់ខ្លួន'),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               const Card(
//                 child: ExpansionTile(
//                   title: Text('ព័ត៌មានផ្ទាល់ខ្លួន'),
//                   children: [
//                     PersonalInfoPage(),
//                   ],
//                 ),
//               ),
//               Card(
//                 child: ListTile(
//                   title: const Text('ព័ត៌មានគ្រួសារ'),
//                   trailing: const Icon(Icons.keyboard_arrow_right),
//                   onTap: () => Get.to(
//                     () => const FamilyHistoryInfoPage(),
//                     arguments: "ព័ត៌មានគ្រួសារ",
//                   ),
//                 ),
//               ),
//               Card(
//                 child: ListTile(
//                   title: const Text('ប្រវត្តិការងារ'),
//                   trailing: const Icon(Icons.keyboard_arrow_right),
//                   onTap: () => Get.to(
//                     () => const WorkHistoryInfoPage(),
//                     arguments: "ប្រវត្តិការងារ",
//                   ),
//                 ),
//               ),
//               Card(
//                 child: ListTile(
//                   title: const Text('មុខងារបន្ថែម'),
//                   trailing: const Icon(Icons.keyboard_arrow_right),
//                   onTap: () => Get.to(
//                     () => const AdditionalPositionInfoPage(),
//                     arguments: "មុខងារបន្ថែម",
//                   ),
//                 ),
//               ),
//
//               Card(
//                 child: ListTile(
//                   title: const Text('ប្រវត្តិការរសិក្សា'),
//                   trailing: const Icon(Icons.keyboard_arrow_right),
//                   onTap: () => Get.to(
//                     () => const EducationHistoryInfoPage(),
//                     arguments: "ប្រវត្តិការរសិក្សា",
//                   ),
//                 ),
//               ),
//               Card(
//                 child: ListTile(
//                   title: const Text('ភាសា'),
//                   trailing: const Icon(Icons.keyboard_arrow_right),
//                   onTap: () => Get.to(
//                     () => const LanguageInfoPage(),
//                     arguments: "ភាសា",
//                   ),
//                 ),
//               ),
//               Card(
//                 child: ListTile(
//                   title: const Text('កាំបៀវត្ស'),
//                   trailing: const Icon(Icons.keyboard_arrow_right),
//                   onTap: () => Get.to(
//                     () => const KrobKhanInfoPage(),
//                     arguments: "កាំបៀវត្ស",
//                   ),
//                 ),
//               ),
//               Card(
//                 child: ListTile(
//                   title: const Text('ឥស្សរិយយស្ស'),
//                   trailing: const Icon(Icons.keyboard_arrow_right),
//                   onTap: () => Get.to(
//                     () => const MeritInfoPage(),
//                     arguments: "ឥស្សរិយយស្ស",
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
