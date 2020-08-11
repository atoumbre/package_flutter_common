import 'package:flutter/material.dart';

class ImageWithTitle extends StatelessWidget {
  final ImageProvider image;
  final Widget content;
  final AppBar appBar;

  ImageWithTitle(
    this.image,
    {
      this.content,
      this.appBar
    }
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      // alignment: AlignmentDirectional(0.0, 1.0),
      children: <Widget>[

        // image
        Image(
          image: image,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),

        // content
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[

            Container(
              padding: EdgeInsets.all(32.0),
              child: content,
            ),

          ],
        ),

        // app bar
        appBar == null ? Container() : appBar,
      ],
    );
  }
}