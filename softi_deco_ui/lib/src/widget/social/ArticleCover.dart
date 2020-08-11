import 'package:flutter/material.dart';
import '../common/DecoCard.dart';

class ArticleCover extends StatelessWidget {
  final ImageProvider image;
  final Widget content;

  ArticleCover(
    this.image,
    {
      this.content
    }
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[

        // white background with shadow
        Positioned.fill(
          child: Container(
            padding: EdgeInsets.only(top: 16.0),
            child: DecoCard(),
          )
        ),


        // content with image
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          padding: EdgeInsets.only(bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              // image with set max height
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 192.0,
                  minWidth: double.infinity,
                ),

                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Image(
                    image: image,
                    fit: BoxFit.cover
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 32.0),
                child: content == null ? Container() : content,
              ),

            ],
          ),
        ),
      ],
    );
  }
}
