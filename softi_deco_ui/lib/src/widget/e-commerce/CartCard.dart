import 'package:flutter/material.dart';
import 'package:softi_deco_ui/src/styles.dart';

import './../common/DecoCard.dart';

class CartCard extends StatelessWidget {
  final ImageProvider image;
  final String price;
  final String title;
  final String category;
  final bool showQuantityButtons;
  final int quantity;
  final VoidCallback onTapUp;
  final VoidCallback onTapBottom;

  CartCard(
      {this.image,
      this.price,
      this.title,
      this.category,
      this.showQuantityButtons = true,
      this.quantity = 0,
      this.onTapUp,
      this.onTapBottom});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      child: DecoCard(
        padding: 8.0,
        child: Row(
          children: <Widget>[
            // get image container
            getImage(),

            // get card content
            getContent(),

            // returns buttons on right side
            showQuantityButtons ? getButtons() : Container(),
          ],
        ),
      ),
    );
  }

  /// Returns image container
  Widget getImage() {
    if (image == null) {
      return Container();
    }

    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Image(
          image: image,
          width: 98.0,
          height: 98.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  /// Returns card content
  Widget getContent() {
    if (price == null && title == null && category == null) {
      return Expanded(child: Container());
    }

    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: image == null ? 0.0 : 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            price == null
                ? Container()
                : Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(price, style: CartCardStyle.price),
                  ),
            title == null
                ? Container()
                : Padding(
                    padding: EdgeInsets.only(bottom: 2.0),
                    child: Text(title, style: CartCardStyle.title),
                  ),
            category == null ? Container() : Text(category, style: CartCardStyle.category),
          ],
        ),
      ),
    );
  }

  /// Returns buttons on right side
  Widget getButtons() {
    return Column(
      children: <Widget>[
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(8.0),
            onTap: onTapUp,
            child: Icon(
              Icons.add,
              color: CartCardStyle.iconColor,
              size: 16.0,
            ),
          ),
        ),
        Container(
            width: 32.0,
            height: 32.0,
            margin: EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
                color: CartCardStyle.quantityBackgroundColor, borderRadius: BorderRadius.circular(32.0 / 2)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(quantity.toString(), style: CartCardStyle.quantity),
              ],
            )),
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(8.0),
            onTap: onTapBottom,
            child: Icon(
              Icons.remove,
              color: CartCardStyle.iconColor,
              size: 16.0,
            ),
          ),
        ),
      ],
    );
  }
}
