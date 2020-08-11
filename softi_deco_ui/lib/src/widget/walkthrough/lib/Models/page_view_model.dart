import 'package:flutter/material.dart';

//view model for pages

class PageViewModel {
  /// Page BackGround Color
  final Color pageColor;

  ///icon image path
  final String iconImageAssetPath;

  /// iconColor
  final Color iconColor;

  /// color for background of progress bubbles
  ///
  /// @Default `const Color(0xFFFFFFFF)`
  final Color bubbleBackgroundColor;

  /// widget for the title
  ///
  /// _typicaly a Text Widget_
  ///
  /// @Default Textstyle `color: Colors.white , fontSize: 50.0`
  final Widget title;

  /// widget for the body
  ///
  /// _typicaly a Text Widget_
  ///
  /// @Default Textstyle `color: Colors.white, fontSize: 24.0`
  final Widget body;

  /// set default TextStyle for both title and body
  final TextStyle textStyle;

  /// Image Widget
  ///
  /// _typicaly a Image Widget_
  final Widget mainImage;

  /// Background image
  final ImageProvider backgroundImage;

  /// bubble inner Widget
  ///
  /// _typicaly a Image Widget_
  ///
  /// gets overriden by [iconImageAssetPath]
  final Widget bubble;

  PageViewModel({
    this.pageColor,
    this.iconImageAssetPath,
    this.bubbleBackgroundColor = const Color(0xFFFFFFFF),
    this.iconColor,
    @required this.title,
    @required this.body,
    @required this.mainImage,
    this.backgroundImage,
    this.bubble,
    this.textStyle
  });

  TextStyle get titleTextStyle {
    return TextStyle(color: Colors.white, fontSize: 20.0).merge(this.textStyle);
  }

  TextStyle get bodyTextStyle {
    return TextStyle(color: Colors.white, fontSize: 14.0, height: 21.0/14.0).merge(this.textStyle);
  }
}
