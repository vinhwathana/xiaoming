import 'package:flutter/material.dart';
import 'package:xiaoming/components/mptc_textfield.dart';

class FamilyInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 0, 20, 10),
      child: Column(
        children: [
          ExpansionRow(label: 'គោត្តនាម និង នាម', value: 'មុត ប៉េងឈង'),
          Divider(),
          ExpansionRow(label: 'ភេទ', value: 'ប្រុស'),
          Divider(),
          ExpansionRow(label: 'ថ្ងៃ ខែ ឆ្នាំ កំណើត', value: '០៦/០៦/១៩៩៧'),
          Divider(),
          ExpansionRow(label: 'ជនជាតិ', value: 'ខ្មែរ'),
          Divider(),
          ExpansionRow(label: 'សញ្ជាតិ', value: 'ខ្មែរ'),
          Divider(),
          ExpansionRow(
              label: 'ទីកន្លែងកំណើត', value: 'គីរីចុងកោះ គីរីវង់ តាកែវ'),
          Divider(),
          ExpansionRow(label: 'ស្ថានភាពគ្រួសារ', value: 'នៅលីវ'),
          Divider(),
          ExpansionRow(
              label: 'អាស័យដ្ឋានបច្ចុប្បន្ន',
              value: 'ព្រែកតានូ ២ ចាក់អង្រែលើ មានជ័យ ភ្នំពេញ'),
          Divider(),
          ExpansionRow(label: 'លេខទូរស័ព្ទ', value: '០៩៣ ៥៣៣ ០៧០'),
          Divider(),
          ExpansionRow(label: 'អត្តលេខ', value: '១៩៧២១០០០៨៦'),
          Divider(),
          ExpansionRow(label: 'ថ្ងៃបម្រើការងារ', value: '០១/០៦/២០២០'),
          Divider(),
          ExpansionRow(label: 'ថ្ងៃតាំងស៊ប់', value: '០១/០៦/២០២១'),
        ],
      ),
    );
  }
}
