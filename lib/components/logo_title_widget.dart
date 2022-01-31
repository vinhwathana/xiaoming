import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogoTitleWidget extends StatelessWidget {
  const LogoTitleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image(
          image: const AssetImage("assets/images/mptc_logo.png"),
          fit: BoxFit.cover,
          width: Get.width / 3,
        ),
        const SizedBox(height: 16.0),
        const Text(
          'ប្រព័ន្ធគ្រប់គ្រងទិន្នន័យមន្ត្រី',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}