import 'package:flutter/material.dart';
import 'package:softi_deco_ui/src/styles.dart';

import '../common/DecoCard.dart';

class ImageCardOverlap extends StatelessWidget {
  final ImageProvider image;
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  ImageCardOverlap(this.image, this.title, {this.description, this.onTap, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      child: Stack(
        children: <Widget>[
          // white background with shadow
          Positioned.fill(
              child: Container(
            padding: EdgeInsets.only(top: 16.0),
            child: DecoCard(),
          )),

          // image and text
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            padding: EdgeInsets.only(bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // image with set max height
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 180.0,
                    minWidth: double.infinity,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Image(image: image, fit: BoxFit.cover),
                  ),
                ),

                // gets widget content
                Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: getContentWidthIcon(),
                )
              ],
            ),
          ),

          // clickable area
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getContentWidthIcon() {
    return icon == null
        ? getContent()
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // get widget content
              getContent(),

              // icon
              Icon(icon, color: DecoColors.icon),
            ],
          );
  }

  Widget getContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // title

        Text(
          title,
          style: ImageCardOverlapStyle.title,
          overflow: TextOverflow.ellipsis,
        ),

        // description
        description == null
            ? Container()
            : Text(
                description,
                style: ImageCardOverlapStyle.description,
                overflow: TextOverflow.ellipsis,
              ),
      ],
    );
  }
}
