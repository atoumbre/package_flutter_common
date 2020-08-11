import 'package:flutter/material.dart';

class ImagesGrid extends StatelessWidget {
  final List<ImageProvider> images;
  final double padding;
  final int crossAxisCount;

  ImagesGrid(
    this.images,
    {
      this.padding: 16.0,
      this.crossAxisCount = 3
    }
  );

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: crossAxisCount,
      physics: ScrollPhysics(),
      shrinkWrap: true,
      mainAxisSpacing: padding,
      crossAxisSpacing: padding,
      padding: EdgeInsets.all(0.0),
      children: images.map(
        (ImageProvider image) => Builder(
          builder: (context) => ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Image(
              image: image,
              fit: BoxFit.cover,
            ),
          ),
        )
      ).toList()
    );
  }
}
