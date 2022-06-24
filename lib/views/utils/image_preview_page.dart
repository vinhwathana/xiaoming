import 'package:extended_image/extended_image.dart';
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
    return ExtendedImageSlidePage(
      slideAxis: SlideAxis.both,
      slideType: SlideType.onlyImage,
      resetPageDuration: const Duration(milliseconds: 100),
      child: Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
        ),
        body: SafeArea(
          child: Container(
            color: Colors.black,
            width: double.maxFinite,
            height: double.maxFinite,
            child: ExtendedImage(
              // imageProvider: imageProvider,
              // minScale: 0.1,
              image: imageProvider,
              mode: ExtendedImageMode.gesture,
              enableMemoryCache: true,
              enableSlideOutPage: true,
            ),
          ),
        ),
      ),
    );
  }
}
