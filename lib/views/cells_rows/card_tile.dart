import 'package:flutter/material.dart';

class CardTile extends StatelessWidget {
  const CardTile({
    Key? key,
    this.title,
    this.trailing,
    this.onTap,
  }) : super(key: key);
  final Widget? title;
  final Widget? trailing;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Card(

      child: ListTile(
        title: title,
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
