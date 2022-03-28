import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpansionRow extends StatelessWidget {
  final String label;
  final String value;

   const ExpansionRow({Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: Get.width / 3,
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Text(value),
        ),
      ],
    );
  }
}
