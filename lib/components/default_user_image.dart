import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';

class DefaultUserImage extends StatelessWidget {
  const DefaultUserImage({
    Key? key,
    required this.fullName,
    this.width = 130,
    this.height = 130,
  }) : super(key: key);

  final String fullName;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Avatar(
      name: fullName,
      onTap: () {},
      value: fullName,
      shape: AvatarShape(
        width: width,
        height: height,
        shapeBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(65),
        ),
      ),
    );
  }
}
