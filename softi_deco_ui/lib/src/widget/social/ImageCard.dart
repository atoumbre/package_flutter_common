import 'package:flutter/material.dart';
import 'package:softi_deco_ui/src/styles.dart';

class ImageCard extends StatelessWidget {
  final String title;
  final String description;
  final int iconValue;
  final ImageProvider image;
  final IconData icon;
  final bool textOnTop;
  final double height;
  final VoidCallback onTap;

  ImageCard(
      {this.title,
      this.description,
      this.iconValue,
      this.image,
      this.icon = Icons.favorite,
      this.textOnTop = true,
      this.height = 220.0,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      child: textOnTop ? getTextOnTop() : getTextBottom(),
    );
  }

  /// Returns card widgets where text is places over image
  Widget getTextOnTop() {
    return Stack(
      alignment: AlignmentDirectional(0.0, 1.0),
      children: <Widget>[
        // get image container
        getImage(),

        // get widget content
        getContentWithGradient(),

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
    );
  }

  /// Returns card widgets when text is placed on bottom
  Widget getTextBottom() {
    var margin = 16.0;
    if (title == null && description == null && iconValue == null) {
      margin = 0.0;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: margin),
              child: getImage(),
            ),
            getContent()
          ],
        ),
      ),
    );
  }

  /// Returns image
  Widget getImage() {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.transparent,
          boxShadow: <BoxShadow>[
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 30.0, offset: Offset(0.0, 10.0))
          ],
          image: DecorationImage(image: image, fit: BoxFit.cover)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(borderRadius: BorderRadius.all(Radius.circular(5.0)), onTap: onTap),
      ),
    );
  }

  /// Returns widget content with background gradient
  Widget getContentWithGradient() {
    if (title == null && description == null && iconValue == null) {
      return Container();
    }

    return Container(
        width: double.infinity,
        height: 90.0,
        padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(5.0),
          ),
          gradient: LinearGradient(
            begin: Alignment(0.0, -1.0),
            end: Alignment(0.0, 0.6),
            colors: [Colors.black.withOpacity(0.0), Colors.black.withOpacity(0.4)],
          ),
        ),
        child: getContent());
  }

  /// Returns card container
  Widget getContent() {
    if (title == null && description == null && iconValue == null) {
      return Container();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                title == null
                    ? Container()
                    : Text(title, style: textOnTop ? ImageCardStyle.title : ImageCardStyle.titleBellow),
                description == null
                    ? Container()
                    : Padding(
                        padding: EdgeInsets.only(top: 2.0),
                        child: Text(description,
                            style: textOnTop ? ImageCardStyle.description : ImageCardStyle.descriptionBellow),
                      )
              ],
            )),
            iconValue == null
                ? Container()
                : Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 10.0),
                        child: Icon(icon, color: textOnTop ? Colors.white : ImageCardStyle.iconColorBellow, size: 24),
                      ),
                      Text(iconValue.toString(),
                          style: textOnTop ? ImageCardStyle.iconLabel : ImageCardStyle.iconLabelBellow)
                    ],
                  ),
          ],
        )
      ],
    );
  }
}
