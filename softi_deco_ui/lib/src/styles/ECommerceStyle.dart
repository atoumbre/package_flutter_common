import 'package:flutter/material.dart';
import 'CommonStyle.dart';


/// Style for ECommerce page
class ECommerceStyle {

  /// Demo 2
  static final demo2Description = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 14.0,
    height: 16.0 / 14.0,
    color: DecoColors.textLight,
  );

  static final demo2CardTitle = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 12.0,
    height: 14.0 / 12.0,
    color: DecoColors.textLight,
  );

  static final demo2CardContent = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 12.0,
    height: 14.0 / 12.0,
    color: DecoColors.textDark,
  );


  /// Demo 3
  static final demo3Description = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 14.0,
    height: 16.0 / 14.0,
    color: DecoColors.textLight,
  );


  /// Demo 4
  static final demo4Description = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 14.0,
    height: 16.0 / 14.0,
    color: DecoColors.textLight
  );

  static final demo4Price = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 16.0,
    height: 19.0 / 16.0,
    fontWeight: FontWeight.w600,
    color: DecoColors.textDark
  );

  static final demo4Title = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 14.0,
    height: 16.0 / 13.0,
    color: DecoColors.textDark
  );

  /// Demo 8
  static final demo8Price = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 20.0,
    height: 24.0 / 20.0,
    fontWeight: FontWeight.w600,
    color: DecoColors.textDark
  );

  static final demo8PriceLight = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 14.0,
    height: 16.0 / 14.0,
    fontWeight: FontWeight.w600,
    color: DecoColors.textLight
  );

  static final demo8Description = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 14.0,
    height: 16.0 / 14.0,
    color: DecoColors.textLight
  );
}


/// Style for AddToCartCard widget
class AddToCartCardStyle {
  static final price = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 16.0,
    height: 19.0 / 16.0,
    color: DecoColors.textDark,
    fontWeight: FontWeight.bold,
  );

  static final title = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 14.0,
    height: 16.0 / 14.0,
    color: DecoColors.textDark,
  );

  static final category = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 12.0,
    height: 14.0 / 12.0,
    color: DecoColors.textLight,
  );

  static final iconLabel = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 12.0,
    height: 14.0 / 12.0,
    color: DecoColors.textLight,
  );

  static final iconColor = DecoColors.textLight;
}


/// Style for CartCard widget
class CartCardStyle {
  static final price = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 16.0,
    height: 19.0 / 16.0,
    fontWeight: FontWeight.bold,
    color: DecoColors.textDark,
  );

  static final title = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 14.0,
    height: 16.0 / 14.0,
    color: DecoColors.textDark,
  );

  static final category = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 12.0,
    height: 14.0 / 12.0,
    color: DecoColors.textLight,
  );

  static final quantity = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 14.0,
    height: 16.0 / 14.0,
    color: Colors.white,
  );

  static final iconColor = DecoColors.textLight;
  static final quantityBackgroundColor = DecoColors.primary;
}


/// Style for FiltersList widget
class FiltersListStyle {
  static final title = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 14.0,
    height: 16.0 / 14.0,
    color: DecoColors.textLight
  );
}


/// Style for SizePicker widget
class SizePickerStyle {
  static final title = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 16.0,
    height: 19.0 / 16.0,
    fontWeight: FontWeight.w600,
    color: DecoColors.textLight
  );

  static final titleActive = SizePickerStyle.title.copyWith(
    color: Colors.white
  );
}


/// Style for DecoRangeSlider widget
class DecoRangeSliderStyle {
  static final label = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 14.0,
    height: 16.0 / 14.0,
    color: DecoColors.textDark
  );
}
