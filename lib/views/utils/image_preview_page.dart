import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class ImagePreviewPage extends StatelessWidget {
  const ImagePreviewPage({
    Key? key,
    required this.imageProvider,
  }) : super(key: key);

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
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: SafeArea(
          child: Container(
            color: Colors.black,
            width: double.maxFinite,
            height: double.maxFinite,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: PhotoView(
                  imageProvider: imageProvider,
                  minScale: 0.1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
