import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoGalleryViewrPage extends StatelessWidget {
  final List<PhotoViewGalleryPageOptions> images;
  final int initialIndex;

  PhotoGalleryViewrPage({Key key, this.images, this.initialIndex = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
                child: PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                return images[index];
              },
              itemCount: images.length,
              pageController: PageController(initialPage: initialIndex),
              loadingBuilder: (context, event) => Center(
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(
                    value: event == null ? 0 : event.cumulativeBytesLoaded / event.expectedTotalBytes,
                  ),
                ),
              ),
              // backgroundDecoration: widget.backgroundDecoration,
              // pageController: widget.pageController,
              // onPageChanged: onPageChanged,
            )),
            InkWell(
              onTap: () => Get.back(result: null),
              child: Icon(
                Icons.chevron_left_outlined,
                color: Colors.white,
                size: 32,
              ),
            ),
          ],
        ),
      ),
      // title: 'View Photo',
    );
  }
}

class PhotoViewPage extends StatelessWidget {
  final ImageProvider image;

  PhotoViewPage({Key key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PhotoView(
              imageProvider: image,
            ),
            InkWell(
              onTap: () => Get.back(result: null),
              child: Icon(
                Icons.chevron_left_outlined,
                color: Colors.white,
                size: 32,
              ),
            ),
          ],
        ),
      ),
      // title: 'View Photo',
    );
  }
}
