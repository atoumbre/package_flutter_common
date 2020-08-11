import 'package:flutter/material.dart';
import 'package:softi_deco_ui/src/styles.dart';

class FeedCard extends StatefulWidget {
  final String username;
  final ImageProvider userImage;
  final String date;
  final ImageProvider image;
  final bool isLiked;
  final int likes;
  final int comments;
  final IconData likeIcon;
  final IconData commentIcon;
  final String title;
  final String description;
  final VoidCallback onTap;
  final VoidCallback onUserTap;
  final VoidCallback onTapLike;
  final VoidCallback onTapComment;

  FeedCard(
      {this.username,
      this.userImage,
      this.date,
      this.image,
      this.isLiked,
      this.likes,
      this.comments,
      this.likeIcon = Icons.favorite,
      this.commentIcon = Icons.chat_bubble,
      this.title,
      this.description,
      this.onTap,
      this.onUserTap,
      this.onTapLike,
      this.onTapComment});

  @override
  State createState() => _FeedCardState(this.isLiked, this.likes);
}

class _FeedCardState extends State<FeedCard> {
  bool isLiked;
  int likes;

  _FeedCardState(this.isLiked, this.likes);

  @override
  Widget build(BuildContext context) {
    return Container(

        // adds border at bottom of container
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFe6e9ed), width: 1.0))),
        child: Column(
          children: <Widget>[
            // returns card user and date
            getCardHeader(),

            // big image container
            getImage(),

            // get likes and comments
            getLikesAndComments(),

            // card content
            getContent(),
          ],
        ));
  }

  /// Returns card header
  getCardHeader() {
    // check do we have any of username, userImage or date set
    if (this.widget.username == null && this.widget.userImage == null && this.widget.date == null) {
      return Container();
    }

    return Row(
      children: <Widget>[
        // returns user's image and username
        getUser(),

        // returns date
        getDate(),
      ],
    );
  }

  /// Returns user's image and username
  Widget getUser() {
    // check do we have any of username or userImage set
    if (this.widget.username == null && this.widget.userImage == null) {
      return Expanded(child: Container());
    }

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: this.widget.onUserTap,
          child: Container(
            margin: EdgeInsets.only(left: 16.0, top: 16.0, bottom: 16.0),
            child: Row(
              children: <Widget>[
                this.widget.userImage == null
                    ? Container()
                    : Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Image(
                            image: this.widget.userImage,
                            width: 32.0,
                            height: 32.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        margin: EdgeInsets.only(right: 8.0),
                      ),
                this.widget.username == null ? Container() : Text(this.widget.username, style: FeedCardStyle.username)
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Returns date
  Widget getDate() {
    return this.widget.date == null
        ? Container()
        : Container(padding: EdgeInsets.all(16.0), child: Text(this.widget.date, style: FeedCardStyle.date));
  }

  /// Returns image
  Widget getImage() {
    return this.widget.image == null
        ? Container()
        : Material(
            color: Colors.transparent,
            child: Ink.image(
              image: this.widget.image,
              fit: BoxFit.cover,
              height: 220.0,
              child: InkWell(onTap: this.widget.onTap),
            ),
          );
  }

  /// Returns likes and comments
  getLikesAndComments() {
    // check do we have likes or comments set
    if (this.widget.likes == null && this.widget.comments == null) {
      return Container();
    }

    return Container(
      margin: EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: this.widget.image == null ? 0.0 : 16.0,
          bottom: this.widget.title == null && this.widget.description == null ? 16.0 : 0.0),
      child: Row(
        children: <Widget>[
          // get likes
          getLikes(),

          // get comments
          getComments()
        ],
      ),
    );
  }

  /// Returns likes
  Widget getLikes() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            if (isLiked) {
              likes -= 1;
            } else {
              likes += 1;
            }

            isLiked = !isLiked;
          });

          if (this.widget.onTapLike != null) {
            this.widget.onTapLike();
          }
        },
        child: Row(
          children: <Widget>[
            // like icon
            Icon(this.widget.likeIcon,
                color: isLiked ? FeedCardStyle.iconColorActive : FeedCardStyle.iconColor, size: 17.0),

            Padding(
              padding: EdgeInsets.only(left: 5.0, right: 10.0),
              child: Text(likes.toString(), style: isLiked ? FeedCardStyle.iconLabelActive : FeedCardStyle.iconLabel),
            ),
          ],
        ),
      ),
    );
  }

  /// Returns comments
  Widget getComments() {
    return Material(
      child: InkWell(
          onTap: this.widget.onTapComment,
          child: Row(
            children: <Widget>[
              Icon(this.widget.commentIcon, color: FeedCardStyle.iconColor, size: 17.0),
              Padding(
                padding: EdgeInsets.only(left: 5.0, right: 10.0),
                child: Text(this.widget.comments.toString(), style: FeedCardStyle.iconLabel),
              ),
            ],
          )),
    );
  }

  /// returns card content
  Widget getContent() {
    // check do we have title or description set
    if (this.widget.title == null && this.widget.description == null) {
      return Container();
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
          onTap: this.widget.onTap,
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(this.widget.title, style: FeedCardStyle.title),
                      Text(this.widget.description, style: FeedCardStyle.text)
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
