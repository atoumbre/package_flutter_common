import 'package:flutter/material.dart';
import 'CommonStyle.dart';

/// Style for Walkthrough widget
class WalkthroughStyle {
  static final title = DecoTextStyle.baseTextStyle.copyWith(
    color: Colors.white,
    fontSize: 20.0,
    height: 24.0/20.0
  );

  static final description = DecoTextStyle.baseTextStyle.copyWith(
    color: Colors.white,
    fontSize: 14.0,
    height: 24.0/14.0
  );
}