import 'package:flutter/material.dart';


/// Deco UI Kit base text style
class DecoTextStyle {
  static final baseTextStyle = TextStyle(
      fontFamily: 'Roboto'
  );
}


/// Colors used by Deco UI Kit
class DecoColors {

  // background and app bar colors
  static final pageBackground = Color(0xFFFBFCFD);
  static final appBarColor = Color(0xFF707984);
  static final appBarTransparentColor = Color(0xFFFFFFFF);

  static const primary = Color(0xFF7CBE45);
  static const secondary = Color(0xFFAAB3BE);

  static final text = Color(0xFF282C2E);
  static final textDark = Color(0xFF191B1C);
  static final textLight = Color(0xFF757B7E);

  static const icon = Color(0xFF87919E);
  static const iconActive = Color(0xFFE23E3E);
}


/// Style for Button widget
class ButtonStyle {
  static final text = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 14.0,
    height: 16.0 / 14.0,
    color: Colors.white
  );

  static final clearText = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 14.0,
    height: 16.0 / 14.0,
    color: DecoColors.text,
    fontWeight: FontWeight.bold
  );

  static final boxShadow = <BoxShadow>[
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 30.0,
      offset: Offset(0.0, 10.0)
    )
  ];
}


/// Style for DecoCard widget
class DecoCardStyle {

  /// Card box radius
  static final borderRadius = BorderRadius.circular(5.0);

  /// Card box decoration
  static final decoration = BoxDecoration(
    color: Colors.white,
    borderRadius: DecoCardStyle.borderRadius,
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 30.0,
        offset: Offset(0.0, 10.0)
      )
    ],
  );
}


/// Style for AuthorOrDMCard widget
class AuthorOrDMCardStyle {
  static final author = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 16.0,
    height: 19.0 / 16.0,
    color: DecoColors.textDark,
  );

  static final text = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 12.0,
    height: 14.0 / 12.0,
    color: DecoColors.textLight,
  );

  static final time = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 12.0,
    height: 14.0 / 12.0,
    color: DecoColors.textLight,
  );
}


/// Style for ImageCardOverlap widget
class ImageCardOverlapStyle {
  static final title = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 14.0,
    height: 16.0 / 14.0,
    color: DecoColors.textDark,
  );

  static final description = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 12.0,
    height: 14.0 / 12.0,
    color: DecoColors.textLight,
  );
}


/// Style for TextArea widget
class TextAreaStyle {
  static final hint = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 14.0,
    height: 21.0 / 14.0,
    fontStyle: FontStyle.italic,
    color: Color(0xFFC1C9CD),
  );
}
