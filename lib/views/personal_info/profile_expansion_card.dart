

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khmer_date/khmer_date.dart';
import 'package:xiaoming/components/expansion_row.dart';
import 'package:xiaoming/controllers/user_controller.dart';
import 'package:xiaoming/utils/constant.dart';
import 'package:xiaoming/views/login_page.dart';

class ProfileExpansionCard extends StatelessWidget {
  const ProfileExpansionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(30, 0, 20, 10),
      child: GetBuilder<UserController>(
        builder: (controller) {
          if (controller.users == null) {
            return const LoginPage();
          }
          final user = controller.users!.value.officialInfo!;
          return Column(
            children: [
              ExpansionRow(
                  label: 'គោត្តនាម និង នាម',
                  value: "${user.firstNameKh} ${user.lastNameKh}"),
              const Divider(),
              ExpansionRow(label: 'ភេទ', value: user.gender ?? "(No Gender)"),
              const Divider(),
              ExpansionRow(
                  label: 'ថ្ងៃ ខែ ឆ្នាំ កំណើត',
                  value: formatDateTime(user.dateOfBirth!)),
              const Divider(),
              ExpansionRow(label: 'ជនជាតិ', value: user.race?.nameKh ?? ""),
              const Divider(),
              ExpansionRow(
                  label: 'សញ្ជាតិ', value: user.nationality?.nameKh ?? ""),
              const Divider(),
              ExpansionRow(
                  label: 'ទីកន្លែងកំណើត',
                  value: generateAddress(
                    province: user.birthAddressProvince,
                    commune: user.birthAddressCommune,
                    district: user.birthAddressDistrict,
                    village: user.birthAddressVillage,
                  )),
              const Divider(),
              ExpansionRow(
                  label: 'ស្ថានភាពគ្រួសារ',
                  value: decideEnumValue(user.maritalStatus)),
              const Divider(),
              ExpansionRow(
                  label: 'អាស័យដ្ឋានបច្ចុប្បន្ន',
                  value: generateAddress(
                    province: user.currentAddressProvince,
                    commune: user.currentAddressCommune,
                    district: user.currentAddressDistrict,
                    village: user.currentAddressVillage,
                  )),
              const Divider(),
              ExpansionRow(
                  label: 'លេខទូរស័ព្ទ',
                  value: formatPhoneNumber(user.contactPhone)),
              const Divider(),
              ExpansionRow(
                  label: 'អត្តលេខ',
                  value: KhmerDate.khmerNumber(user.officialId ?? "")),
              const Divider(),
              ExpansionRow(
                  label: 'ថ្ងៃបម្រើការងារ',
                  value: formatDateTime(user.internshipDate)),
              const Divider(),
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
