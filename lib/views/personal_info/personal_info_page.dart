import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khmer_date/khmer_date.dart';
import 'package:xiaoming/colors/company_colors.dart';
import 'package:xiaoming/components/expansion_row.dart';
import 'package:xiaoming/controllers/user_controller.dart';
import 'package:xiaoming/utils/constant.dart';
import 'package:xiaoming/views/login_page.dart';

class PersonalInfoPage extends StatelessWidget {
  const PersonalInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: CompanyColors.yellow,
      margin: EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                "ព័ត៌មានផ្ទាល់ខ្លួន",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            GetBuilder<UserController>(
              builder: (controller) {
                if (controller.users == null) {
                  return const LoginPage();
                }
                final user = controller.users!.value.officialInfo!;
                return Column(
                  children: [
                    ExpansionRow(
                      label: 'គោត្តនាម និង នាម',
                      value: "${user.firstNameKh} ${user.lastNameKh}",
                    ),
                    const Divider(),
                    ExpansionRow(
                      label: 'ភេទ',
                      value: user.gender ?? "(No Gender)",
                    ),
                    const Divider(),
                    ExpansionRow(
                      label: 'ថ្ងៃ ខែ ឆ្នាំ កំណើត',
                      value: formatDateTimeForView(user.dateOfBirth!),
                    ),
                    const Divider(),
                    ExpansionRow(
                        label: 'ជនជាតិ', value: user.race?.nameKh ?? ""),
                    const Divider(),
                    ExpansionRow(
                        label: 'សញ្ជាតិ',
                        value: user.nationality?.nameKh ?? ""),
                    const Divider(),
                    ExpansionRow(
                      label: 'ទីកន្លែងកំណើត',
                      value: generateAddress(
                        province: user.birthAddressProvince,
                        commune: user.birthAddressCommune,
                        district: user.birthAddressDistrict,
                        village: user.birthAddressVillage,
                      ),
                    ),
                    const Divider(),
                    ExpansionRow(
                      label: 'ស្ថានភាពគ្រួសារ',
                      value: decideEnumValue(user.maritalStatus),
                    ),
                    const Divider(),
                    ExpansionRow(
                      label: 'អាស័យដ្ឋានបច្ចុប្បន្ន',
                      value: generateAddress(
                        province: user.currentAddressProvince,
                        commune: user.currentAddressCommune,
                        district: user.currentAddressDistrict,
                        village: user.currentAddressVillage,
                      ),
                    ),
                    const Divider(),
                    ExpansionRow(
                      label: 'លេខទូរស័ព្ទ',
                      value: formatPhoneNumber(user.contactPhone),
                    ),
                    const Divider(),
                    ExpansionRow(
                      label: 'អត្តលេខ',
                      value: KhmerDate.khmerNumber(user.officialId ?? ""),
                    ),
                    const Divider(),
                    ExpansionRow(
                      label: 'ថ្ងៃបម្រើការងារ',
                      value: formatDateTimeForView(user.internshipDate),
                    ),
                    const Divider(),
                    ExpansionRow(
                      label: 'ថ្ងៃតាំងស៊ប់',
                      value: formatDateTimeForView(user.officialWorkingDate),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        // child:
      ),
    );
  }
}
