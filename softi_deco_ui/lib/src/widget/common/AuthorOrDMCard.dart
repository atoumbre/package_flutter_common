import 'package:flutter/material.dart';
import 'package:softi_deco_ui/src/styles.dart';
import 'DecoCard.dart';

class AuthorOrDMCard extends StatelessWidget {
  final ImageProvider image;
  final double imageSize;
  final String author;
  final String text;
  final String time;
  final VoidCallback onTap;

  AuthorOrDMCard({this.image, this.imageSize = 32.0, this.author, this.text, this.time, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      child: DecoCard(
        onTap: onTap,
        child: Row(
          children: <Widget>[
            image == null
                ? Container()
                : Container(
                    margin: EdgeInsets.only(right: 16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(imageSize / 2),
                      child: Image(image: image, fit: BoxFit.cover, height: imageSize, width: imageSize),
                    ),
                  ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                author == null ? Container() : Text(author, style: AuthorOrDMCardStyle.author),
                text == null ? Container() : Text(text, style: AuthorOrDMCardStyle.text)
              ],
            )),
            time == null
                ? Container()
                : Container(margin: EdgeInsets.only(left: 16.0), child: Text(time, style: AuthorOrDMCardStyle.time))
          ],
        ),
      ),
    );
  }
}
