import 'package:flutter/material.dart';
import 'package:xiaoming/components/mptc_textfield.dart';

class FamilyInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 0, 20, 10),
      child: Column(
        children: [
          MPTCTextField(label: 'គោត្តនាម និង នាម', value: 'មុត ប៉េងឈង'),
          Divider(),
          MPTCTextField(label: 'ភេទ', value: 'ប្រុស'),
          Divider(),
          MPTCTextField(label: 'ថ្ងៃ ខែ ឆ្នាំ កំណើត', value: '០៦/០៦/១៩៩៧'),
          Divider(),
          MPTCTextField(label: 'ជនជាតិ', value: 'ខ្មែរ'),
          Divider(),
          MPTCTextField(label: 'សញ្ជាតិ', value: 'ខ្មែរ'),
          Divider(),
          MPTCTextField(
              label: 'ទីកន្លែងកំណើត', value: 'គីរីចុងកោះ គីរីវង់ តាកែវ'),
          Divider(),
          MPTCTextField(label: 'ស្ថានភាពគ្រួសារ', value: 'នៅលីវ'),
          Divider(),
          MPTCTextField(
              label: 'អាស័យដ្ឋានបច្ចុប្បន្ន',
              value: 'ព្រែកតានូ ២ ចាក់អង្រែលើ មានជ័យ ភ្នំពេញ'),
          Divider(),
          MPTCTextField(label: 'លេខទូរស័ព្ទ', value: '០៩៣ ៥៣៣ ០៧០'),
          Divider(),
          MPTCTextField(label: 'អត្តលេខ', value: '១៩៧២១០០០៨៦'),
          Divider(),
          MPTCTextField(label: 'ថ្ងៃបម្រើការងារ', value: '០១/០៦/២០២០'),
          Divider(),
          MPTCTextField(label: 'ថ្ងៃតាំងស៊ប់', value: '០១/០៦/២០២១'),
        ],
      ),
    );
  }
}
