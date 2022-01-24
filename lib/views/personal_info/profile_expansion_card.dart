//This page provide profile information for individual user
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khmer_date/khmer_date.dart';
import 'package:xiaoming/components/expansion_row.dart';
import 'package:xiaoming/controllers/user_controller.dart';
import 'package:xiaoming/models/user.dart';
import 'package:xiaoming/utils/constant.dart';
import 'package:xiaoming/views/login_page.dart';

class ProfileExpansionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 0, 20, 10),
      child: GetBuilder<UserController>(
        builder: (controller) {
          if (controller.users == null) {
            return LoginPage();
          }
          final user = controller.users!.value.officialInfo!;
          return Column(
            children: [
              ExpansionRow(
                  label: 'គោត្តនាម និង នាម',
                  value: "${user.firstNameKh} ${user.lastNameKh}"),
              Divider(),
              ExpansionRow(label: 'ភេទ', value: user.gender ?? "(No Gender)"),
              Divider(),
              ExpansionRow(
                  label: 'ថ្ងៃ ខែ ឆ្នាំ កំណើត',
                  value: formatDateTime(user.dateOfBirth!)),
              Divider(),
              ExpansionRow(label: 'ជនជាតិ', value: user.race!.nameKh),
              Divider(),
              ExpansionRow(label: 'សញ្ជាតិ', value: user.nationality!.nameKh),
              Divider(),
              ExpansionRow(
                  label: 'ទីកន្លែងកំណើត',
                  value: '${generateAddress(
                    province: user.birthAddressProvince,
                    commune: user.birthAddressCommune,
                    district: user.birthAddressDistrict,
                    village: user.birthAddressVillage,
                  )}'),
              Divider(),
              ExpansionRow(
                  label: 'ស្ថានភាពគ្រួសារ',
                  value: decideEnumValue(user.maritalStatus)),
              Divider(),
              ExpansionRow(
                  label: 'អាស័យដ្ឋានបច្ចុប្បន្ន',
                  value: '${generateAddress(
                    province: user.currentAddressProvince,
                    commune: user.currentAddressCommune,
                    district: user.currentAddressDistrict,
                    village: user.currentAddressVillage,
                  )}'),
              Divider(),
              ExpansionRow(
                  label: 'លេខទូរស័ព្ទ',
                  value: formatPhoneNumber(user.contactPhone)),
              Divider(),
              ExpansionRow(
                  label: 'អត្តលេខ',
                  value: KhmerDate.khmerNumber(user.officialId ?? "")),
              Divider(),
              ExpansionRow(
                  label: 'ថ្ងៃបម្រើការងារ',
                  value: formatDateTime(user.internshipDate)),
              Divider(),
              ExpansionRow(
                  label: 'ថ្ងៃតាំងស៊ប់',
                  value: formatDateTime(user.officialWorkingDate)),
            ],
          );
        },
      ),
      // child:
    );
  }
}
