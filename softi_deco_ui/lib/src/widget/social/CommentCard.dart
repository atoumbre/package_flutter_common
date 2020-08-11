import 'package:flutter/material.dart';
import 'package:softi_deco_ui/src/styles.dart';
import './../common/DecoCard.dart';

class CommentCard extends StatelessWidget {
  final String text;
  final String date;
  final String username;
  final ImageProvider userImage;
  final VoidCallback onTap;

  CommentCard({this.text, this.date, this.username, this.userImage, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: <Widget>[
            // get comment content
            getContent(),

            // get user
            getUser()
          ],
        ));
  }

  /// Returns comment card content
  Widget getContent() {
    return DecoCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          date == null
              ? Container()
              : Padding(
                  padding: EdgeInsets.only(bottom: text == null ? 0.0 : 16.0),
                  child: Text(date, style: CommentCardStyle.date),
                ),
          text == null ? Container() : Text(text, style: CommentCardStyle.text),
        ],
      ),
    );
  }

  /// Returns user container
  Widget getUser() {
    // check do we have username or userImage set
    if (username == null && userImage == null) {
      return Container();
    }

    return Container(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
      child: Row(
        children: <Widget>[
          userImage == null
              ? Container()
              : Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image(
                      image: userImage,
                      width: 32.0,
                      height: 32.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
          username == null ? Container() : Text(username, style: CommentCardStyle.username)
        ],
      ),
    );
  }
}
