import 'package:flutter/material.dart';
import 'package:softi_deco_ui/src/styles.dart';

class RoundAvatar extends StatelessWidget {
  final ImageProvider avatar;
  final double size;

  RoundAvatar(this.avatar, {this.size = 260.0});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(size / 2), boxShadow: RoundAvatarStyle.shadow),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size / 2),
          child: Image(
            image: avatar,
            width: size,
            height: size,
            fit: BoxFit.cover,
          ),
        ));
  }
}
