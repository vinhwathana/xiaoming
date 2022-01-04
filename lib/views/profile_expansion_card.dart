//This page provide profile information for individual user
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xiaoming/components/mptc_textfield.dart';
import 'package:xiaoming/controllers/user_controller.dart';
import 'package:xiaoming/views/login_page.dart';

class ProfileExpansionCard extends StatelessWidget {
  // final userService = UsersS
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 0, 20, 10),
      child: GetBuilder<UserController>(
        builder: (controller) {
          if (controller.users == null) {
            return LoginPage();
          }
          final List<String> keys = controller.getListOfKey();
          print(keys);
          return ListView.separated(
            shrinkWrap: true,
            itemCount: keys.length,
            itemBuilder: (context, index) {
              return ExpansionRow(
                  label: keys[index], value: 'Person Name');
            },
            separatorBuilder: (context, index) => Divider(),
          );
        },
      ),
      // child: Column(
      //   children: [
      //
      //     Divider(),
      //     MPTCTextField(label: 'ភេទ', value: 'ប្រុស'),
      //     Divider(),
      //     MPTCTextField(label: 'ថ្ងៃ ខែ ឆ្នាំ កំណើត', value: '០៦/០៦/១៩៩៧'),
      //     Divider(),
      //     MPTCTextField(label: 'ជនជាតិ', value: 'ខ្មែរ'),
      //     Divider(),
      //     MPTCTextField(label: 'សញ្ជាតិ', value: 'ខ្មែរ'),
      //     Divider(),
      //     MPTCTextField(
      //         label: 'ទីកន្លែងកំណើត', value: 'គីរីចុងកោះ គីរីវង់ តាកែវ'),
      //     Divider(),
      //     MPTCTextField(label: 'ស្ថានភាពគ្រួសារ', value: 'នៅលីវ'),
      //     Divider(),
      //     MPTCTextField(
      //         label: 'អាស័យដ្ឋានបច្ចុប្បន្ន',
      //         value: 'ព្រែកតានូ ២ ចាក់អង្រែលើ មានជ័យ ភ្នំពេញ'),
      //     Divider(),
      //     MPTCTextField(label: 'លេខទូរស័ព្ទ', value: '០៩៣ ៥៣៣ ០៧០'),
      //     Divider(),
      //     MPTCTextField(label: 'អត្តលេខ', value: '១៩៧២១០០០៨៦'),
      //     Divider(),
      //     MPTCTextField(label: 'ថ្ងៃបម្រើការងារ', value: '០១/០៦/២០២០'),
      //     Divider(),
      //     MPTCTextField(label: 'ថ្ងៃតាំងស៊ប់', value: '០១/០៦/២០២១'),
      //   ],
      // ),
    );
  }
}
