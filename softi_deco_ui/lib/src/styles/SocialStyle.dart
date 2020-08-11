import 'package:flutter/material.dart';
import 'CommonStyle.dart';

/// Style for social demo pages
class SocialStyle {

  static final title = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 20.0,
    height: 24.0 / 20.0,
    color: DecoColors.textDark,
  );

  static final titleLarge = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 40.0,
    height: 1.0,
    color: DecoColors.text,
    fontWeight: FontWeight.bold,
  );

  static final subTitleText = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 12.0,
    height: 14.0 / 12.0,
    color: DecoColors.textLight,
  );

  static final text = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 14.0,
    height: 21.0 / 14.0,
    color: DecoColors.text,
  );


  /// demo 10
  static final demo10Title = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 20.0,
    height: 24.0 / 20.0,
    color: Colors.white,
  );

  static final demo10SubTitleText = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 12.0,
    height: 14.0 / 12.0,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static final demo10Text = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 14.0,
    height: 21.0 / 14.0,
    color: Colors.white,
  );
}


/// Style for ActivityCard widget
class ActivityCardStyle {
  static final username = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 14.0,
    height: 21.0 / 14.0,
    color: DecoColors.textDark,
  );

  static final action = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 14.0,
    height: 21.0 / 14.0,
    color: DecoColors.textLight,
  );

  static final date = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 14.0,
    height: 21.0 / 14.0,
    color: DecoColors.textDark,
  );
}


/// Style for CommentCard widget
class CommentCardStyle {

  static final date = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 12.0,
    height: 14.0 / 12.0,
    color: DecoColors.textLight,
  );

  static final text = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 14.0,
    height: 21.0 / 14.0,
    fontStyle: FontStyle.italic,
    color: DecoColors.text,
  );

  static final username = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 14.0,
    height: 16.0 / 14.0,
    color: DecoColors.text,
  );
}


/// Style for FeedCard widget
class FeedCardStyle {
  static final username = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 14.0,
    color: DecoColors.text
  );

  static final date = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 12.0,
    color: DecoColors.textLight
  );

  static final iconColor = DecoColors.icon;
  static final iconColorActive = DecoColors.iconActive;

  static final iconLabel = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 12.0,
    color: DecoColors.icon
  );

  static final iconLabelActive = FeedCardStyle.iconLabel.copyWith(
    color: DecoColors.iconActive
  );

  static final title = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 16.0,
    height: 19.0 / 16.0,
    color: DecoColors.textDark,
  );
  static final text = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 12.0,
    height: 14.0 / 12.0,
    color: DecoColors.textLight,
  );
}


// Style for FeedImageCard widget
class FeedImageCardStyle {
  static final title = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 16.0,
    height: 19.0 / 16.0,
    color: DecoColors.textDark,
  );

  static final description = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 12.0,
    height: 14.0 / 12.0,
    color: DecoColors.textLight,
  );

  static final date = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 8.0,
    height: 9.0 / 8.0,
    color: DecoColors.textLight,
  );
}


/// Style for ImageCard widget
class ImageCardStyle {
  static final title = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 16.0,
    height: 19.0 / 16.0,
    color: Color(0xFFFFFFFF),
  );
  static final titleBellow = ImageCardStyle.title.copyWith(
    color: DecoColors.textDark
  );

  static final description = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 12.0,
    height: 14.0 / 12.0,
    color: Colors.white
  );
  static final descriptionBellow = ImageCardStyle.description.copyWith(
    color: DecoColors.textLight
  );

  static final iconLabel = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 12.0,
    color: Colors.white
  );
  static final iconLabelBellow = ImageCardStyle.iconLabel.copyWith(
    color: DecoColors.iconActive
  );

  static final iconColorBellow = DecoColors.iconActive;
}