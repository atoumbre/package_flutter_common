import 'package:flutter/material.dart';
import 'CommonStyle.dart';

/// Style for SignUp demo pages
class SignUpStyle {

  static final titleFirstLine = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 40.0,
    height: 1.0,
    color: DecoColors.text,
    fontWeight: FontWeight.bold
  );

  static final titleSecondLine = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 40.0,
    height: 1.0,
    color: DecoColors.text,
  );

  static final text = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 14.0,
    height: 16.0 / 14.0,
    color: DecoColors.textLight,
  );
}
