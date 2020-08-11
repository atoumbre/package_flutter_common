import 'package:flutter/material.dart';

class BlockAvatar extends StatelessWidget {
  final ImageProvider image;
  final double imageSize;
  final VoidCallback onTap;

  BlockAvatar(
    this.image,
    {
      this.onTap,
      this.imageSize = 180.0
    }
  );

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry borderRadius = BorderRadius.only(
      topRight: Radius.circular(5.0),
      bottomRight: Radius.circular(5.0)
    );

    return Container(
      width: imageSize,
      height: imageSize,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: Colors.transparent,
        image: DecorationImage(
          image: image,
          fit: BoxFit.cover
        )
      ),

      child: Material(
        color: Colors.transparent,
        child: InkWell(onTap: onTap, borderRadius: borderRadius),
      ),
    );
  }
}
