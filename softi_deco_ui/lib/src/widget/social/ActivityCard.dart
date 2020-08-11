import 'package:flutter/material.dart';
import 'package:softi_deco_ui/src/styles.dart';
import './../common/DecoCard.dart';

class ActivityCard extends StatelessWidget {
  final String username;
  final ImageProvider userImage;
  final String action;
  final ImageProvider image;
  final String date;
  final VoidCallback onTap;

  ActivityCard({
    this.username = '',
    this.userImage,
    this.action = '',
    this.image,
    this.date = '',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      child: DecoCard(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            userImage == null
                ? Container()
                : Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image(
                        image: userImage,
                        fit: BoxFit.cover,
                        width: 24.0,
                        height: 24.0,
                      ),
                    ),
                    margin: EdgeInsets.only(right: 16.0),
                  ),
            Expanded(
              child: cardContent(),
            ),
            image == null
                ? Container()
                : Container(
                    margin: EdgeInsets.only(left: 16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Image(
                        image: image,
                        fit: BoxFit.cover,
                        width: 40.0,
                        height: 40.0,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  /// Returns card text content
  Widget cardContent() {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(text: username, style: ActivityCardStyle.username),
          TextSpan(text: ' ' + action + ' ', style: ActivityCardStyle.action),
          TextSpan(text: date, style: ActivityCardStyle.date),
        ],
      ),
    );
  }
}
