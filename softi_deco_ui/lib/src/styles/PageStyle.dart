import 'package:flutter/material.dart';
import 'CommonStyle.dart';

class PageStyle {
  // our screens padding
  static final padding = EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0);

  // our screens background color
  static final background = DecoColors.pageBackground;

  // app bar background color
  static final appBarBackground = DecoColors.pageBackground;

  // app bar text style
  static final appBarTextStyle = TextStyle(color: DecoColors.appBarColor);
  static final appBarTransparentTextStyle = TextStyle(color: DecoColors.appBarTransparentColor);

  // app bar elevation
  static final appBarElevation = 0.0;

  // app bar icons style
  static final appBarTheme = IconThemeData(color: DecoColors.appBarColor);
  static final appBarTransparentTheme = IconThemeData(color: DecoColors.appBarTransparentColor);

  // drawer style
  static TextStyle drawerTitle =
      DecoTextStyle.baseTextStyle.copyWith(fontSize: 40.0, fontWeight: FontWeight.w500, color: Colors.white);

  static TextStyle drawerText =
      DecoTextStyle.baseTextStyle.copyWith(fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.white);

  // page title padding
  static final titlePadding = EdgeInsets.only(bottom: 16.0);

  // page title style
  static final title = DecoTextStyle.baseTextStyle
      .copyWith(fontSize: 32.0, fontWeight: FontWeight.bold, height: 40.0 / 32.0, color: DecoColors.text);

  static final titleLarge = DecoTextStyle.baseTextStyle
      .copyWith(fontSize: 40.0, height: 1, fontWeight: FontWeight.bold, color: DecoColors.text);
}
