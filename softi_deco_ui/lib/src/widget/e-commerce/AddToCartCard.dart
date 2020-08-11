import 'package:flutter/material.dart';
import 'package:softi_deco_ui/src/styles.dart';

import './../common/DecoCard.dart';

class AddToCartCard extends StatelessWidget {
  final ImageProvider image;
  final bool moveImageTop;
  final bool imageRight;
  final String price;
  final String title;
  final String category;
  final IconData sideIcon;
  final IconData addToCartIcon;
  final String addToCartLabel;
  final VoidCallback onTap;
  final double marginLeft;
  final double marginTop;
  final double marginRight;
  final double marginBottom;

  AddToCartCard(
      {this.image,
      this.moveImageTop = false,
      this.imageRight = false,
      this.price,
      this.title,
      this.category,
      this.sideIcon,
      this.addToCartIcon,
      this.addToCartLabel,
      this.onTap,
      this.marginLeft = 0.0,
      this.marginTop = 0.0,
      this.marginRight = 0.0,
      this.marginBottom = 16.0});

  @override
  Widget build(BuildContext context) {
    return moveImageTop ? imageMovedTop() : imageNormal();
  }

  /// Case when image is moved outside of card
  Widget imageMovedTop() {
    return Container(
      margin: EdgeInsets.only(left: marginLeft, top: marginTop, right: marginRight, bottom: marginBottom),
      child: Stack(
        alignment: AlignmentDirectional(-1.0, 1.0),
        children: <Widget>[
          Container(
            height: 124.0,
            child: DecoCard(
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      left: imageRight ? 0.0 : 140.0,
                    ),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // add price
                            getPrice(),

                            // add product title
                            getTitle(),

                            // add product category
                            getCategory(),

                            // add to card label
                            getAddToCart()
                          ])
                    ]),
                  ),
                ],
              ),
            ),
          ),

          Align(
            alignment: imageRight ? Alignment.bottomRight : Alignment.bottomLeft,
            child: Container(
              height: 124.0,
              width: 124.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.transparent,
                  image: DecorationImage(image: image, fit: BoxFit.cover)),
              margin: EdgeInsets.only(bottom: 16.0, right: imageRight ? 16.0 : 0.0, left: !imageRight ? 16.0 : 0.0),
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

  /// Case when image is inside of card
  Widget imageNormal() {
    return Container(
      margin: EdgeInsets.only(left: marginLeft, top: marginTop, right: marginRight, bottom: marginBottom),
      child: DecoCard(
        onTap: onTap,
        padding: 8.0,
        child: Row(
          children: <Widget>[
            // add left side card image
            getImage(true),

            Expanded(
                child: Container(
              margin: EdgeInsets.only(left: 8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // add price
                      getPrice(),

                      // add product title
                      getTitle(),

                      // add product category
                      getCategory(),

                      // add to card label
                      getAddToCart()
                    ])
              ]),
            )),

            getRightSideIcon(),

            // add right side card image
            getImage(false),
          ],
        ),
      ),
    );
  }

  /// Returns widget image
  Widget getImage(leftSide) {
    if (leftSide == imageRight || image == null) {
      return Container();
    }

    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Image(
          image: image,
          width: 98.0,
          height: 98.0,
        ),
      ),
      margin: EdgeInsets.only(right: !imageRight ? 8.0 : 0.0, left: imageRight ? 8.0 : 0.0),
    );
  }

  /// Returns widget price
  Widget getPrice() {
    if (price == null) {
      return Container();
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 2.0),
      child: Text(price, style: AddToCartCardStyle.price),
    );
  }

  /// Returns widget title
  Widget getTitle() {
    if (title == null) {
      return Container();
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 2.0),
      child: Text(title, style: AddToCartCardStyle.title),
    );
  }

  /// Returns widget category
  Widget getCategory() {
    if (category == null) {
      return Container();
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: Text(category, style: AddToCartCardStyle.category),
    );
  }

  /// Returns add to cart label
  Widget getAddToCart() {
    if (addToCartIcon == null) {
      return Container();
    }

    return Padding(
        padding: EdgeInsets.only(top: 14.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(addToCartIcon, size: 16.0, color: AddToCartCardStyle.iconColor),
            ),
            Text(addToCartLabel, style: AddToCartCardStyle.iconLabel),
          ],
        ));
  }

  /// Returns widget side icon
  Widget getRightSideIcon() {
    if (sideIcon == null) {
      return Container();
    }

    return Container(
      padding: EdgeInsets.only(right: 8.0),
      child: Icon(sideIcon, color: AddToCartCardStyle.iconColor),
    );
  }
}
