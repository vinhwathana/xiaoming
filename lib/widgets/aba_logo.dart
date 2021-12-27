import 'package:flutter/material.dart';

Widget get abaLogo {
  return Row(
    children: [
      Text('ABA',
      style: TextStyle(
        letterSpacing: 3.0
      ),),
      SizedBox(
        width: 5.0,
      ),
      Text('\'',
      style: TextStyle(
        color: Colors.red,
      ),),
      SizedBox(
        width: 5.0,
      ),
      Text('Mobile'),
    ],
  );
}