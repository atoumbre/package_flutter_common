import 'package:flutter/material.dart';
import 'package:softi_deco_ui/src/styles.dart';
import './../common/DecoCard.dart';

class FeedImageCard extends StatelessWidget {
  final ImageProvider image;
  final String title;
  final String description;
  final String date;
  final VoidCallback onTap;

  FeedImageCard({this.image, this.title, this.description, this.date, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      child: DecoCard(
          onTap: onTap,
          padding: image == null ? 16.0 : 8.0,
          child: Row(
            children: <Widget>[
              image == null
                  ? Container()
                  : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: <BoxShadow>[
                          BoxShadow(color: Color(0xFFD8D8D8), blurRadius: 16.0, offset: Offset(0.0, 8.0))
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Image(
                          image: image,
                          width: 120.0,
                          height: 120.0,
                        ),
                      ),
                      margin: EdgeInsets.only(right: 16.0),
                    ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    title == null
                        ? Container()
                        : Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0),
                            child: Text(title, style: FeedImageCardStyle.title),
                          ),
                    description == null
                        ? Container()
                        : Padding(
                            padding: EdgeInsets.only(top: 4.0, bottom: 8.0),
                            child: Text(description, style: FeedImageCardStyle.description),
                          ),
                    date == null
                        ? Container()
                        : Padding(
                            padding: EdgeInsets.only(top: 6.0),
                            child: Text(date, style: FeedImageCardStyle.date),
                          ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
