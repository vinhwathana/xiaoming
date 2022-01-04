import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpansionRow extends StatelessWidget {
  final String label;
  final String value;

  ExpansionRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          SizedBox(
            width: Get.width / 3,
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
