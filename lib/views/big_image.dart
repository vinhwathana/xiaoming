import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:xiaoming/colors/company_colors.dart';

class BigImagePage extends StatelessWidget {
  const BigImagePage({
    Key? key,
    required this.imageBase64,
    required this.imageProvider,
  }) : super(key: key);

  final String imageBase64;
  final ImageProvider imageProvider;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.vertical,
      onDismissed: (direction) {
        Get.back();
      },
      key: const Key('key'),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            color: Colors.black,
            width: double.maxFinite,
            height: double.maxFinite,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Hero(
                      tag: imageBase64,
                      child: PhotoView(
                        imageProvider: imageProvider,
                        minScale: 0.1,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 5,
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 32,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
