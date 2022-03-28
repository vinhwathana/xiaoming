import 'package:flutter/material.dart';

class Item {
  Item(this.title, [this.children = const <Item>[]]);

  final String title;
  final List<Item> children;
}

final List<Item> data = <Item>[
  Item(
    'ព័ត៌មានផ្ទាល់ខ្លួន',
  ),
  Item(
    'ព័ត៌មានគ្រួសារ ',
  ),
  Item(
    'ប្រវត្តិការងារ',
    <Item>[
      //FamilyInfo(),
    ],
  ),
  Item(
    'ប្រវត្តិការរសិក្សា',
    <Item>[
      Item('Section C0'),
      Item('Section C1'),
    ],
  ),
  Item(
    'ភាសា',
    <Item>[
      Item('Section C0'),
      Item('Section C1'),
    ],
  ),
  Item(
    'កាំបៀវត្ស',
    <Item>[
      Item('Section C0'),
      Item('Section C1'),
    ],
  ),
  Item(
    'ឥស្សរិយយស្ស',
    <Item>[
      Item('Section C0'),
      Item('Section C1'),
    ],
  ),
];

class ProfileItem extends StatelessWidget {
  const ProfileItem(
    this.item, {
    Key? key,
  }) : super(key: key);

  final Item item;

  Widget _buildTiles(Item i) {
    if (i.children.isEmpty) return ListTile(title: Text(i.title));
    return Card(
      child: ExpansionTile(
        key: PageStorageKey<Item>(i),
        title: Text(i.title),
        children: i.children.map(_buildTiles).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(item);
  }
}
