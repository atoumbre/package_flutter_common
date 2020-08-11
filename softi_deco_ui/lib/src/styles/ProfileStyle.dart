import 'package:flutter/material.dart';
import 'CommonStyle.dart';

class ProfileStyle {

  // username
  static final username = DecoTextStyle.baseTextStyle.copyWith(
    color: Color(0xFF282C2E),
    fontSize: 32.0,
    height: 40.0 / 32.0,
    fontWeight: FontWeight.bold
  );
  static final usernameCategory = DecoTextStyle.baseTextStyle.copyWith(
      color: Color(0xFFFFFFFF),
      fontSize: 16.0,
      height: 19.0 / 16.0
  );
  static final usernameBlocks = DecoTextStyle.baseTextStyle.copyWith(
      color: Color(0xFF191B1C),
      fontSize: 16.0,
      height: 19.0 / 16.0
  );

  // location
  static final location = DecoTextStyle.baseTextStyle.copyWith(
    color: Color(0xFF757B7E),
    fontSize: 16.0,
    height: 19.0 / 16.0
  );
  static final locationCategory = DecoTextStyle.baseTextStyle.copyWith(
      color: Color(0xFFFFFFFF),
      fontSize: 12.0,
      height: 14.0 / 12.0
  );
  static final locationBlocks = DecoTextStyle.baseTextStyle.copyWith(
      color: Color(0xFF757B7E),
      fontSize: 12.0,
      height: 14.0 / 12.0
  );

  // Demo2Page username container decoration
  static final usernameContainerDecoration =  BoxDecoration(
    color: Color(0xFFF6F7F9),
    border: Border(
      bottom: BorderSide(
        color: Color(0xFFE6E9ED),
        width: 1.0
      )
    )
  );
}


/// Style for RoundAvatar widget
class RoundAvatarStyle {
  static final shadow = [
    BoxShadow(
      color: Color.fromARGB(20, 0, 0, 0),
      blurRadius: 60.0,
      offset: Offset(0.0, 10.0)
    )
  ];
}


/// Style for Stats widget
class StatsProfileStyle {
  static final number = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 16.0,
    height: 19.0 / 16.0,
    fontWeight: FontWeight.bold,
    color: DecoColors.textDark,
  );

  static final text = DecoTextStyle.baseTextStyle.copyWith(
    fontSize: 12.0,
    height: 14.0 / 12.0,
    color: DecoColors.textLight,
  );
}