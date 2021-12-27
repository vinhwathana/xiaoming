import 'package:flutter/material.dart';
import 'package:xiaoming/pages/mptc_personal_info.dart';
import 'package:xiaoming/pages/mptc_statistics.dart';
class GridIcons {
  List<IconData> iconList = [];
  List<String> iconText = [];
  List<IconData> getIconList() {
    iconList
      ..add(Icons.person)
      ..add(Icons.access_time)
      ..add(Icons.qr_code_scanner)
    ..add(Icons.pie_chart);
    return iconList;
  }

  List<String> getIconText() {
    iconText
    ..add('ព័ត៌មានផ្ទាល់ខ្លួន')
        ..add('វត្តមានផ្ទាល់ខ្លួន')
        ..add('ស្កេនវត្តមាន')
    ..add('ស្ថិតិ');
    return iconText;
  }

  // List getListPages(){
  //   listPages
  //   ..add(PersonalInfo())
  //   ..add(Statistics())
  //   ..add(Statistics())
  //   ..add(Statistics());
  // }
}

