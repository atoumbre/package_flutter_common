import 'package:flutter/material.dart';
import 'package:softi_deco_ui/src/styles.dart';

class IconBox extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color fillColor;
  final Color borderColor;
  final Color iconColor;
  final String text;
  final Color textColor;
  final VoidCallback onTap;

  IconBox(this.icon, this.title,
      {this.fillColor = DecoColors.primary,
      this.borderColor = Colors.transparent,
      this.iconColor = Colors.white,
      this.text,
      this.textColor = Colors.white,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          color: fillColor,
          border: Border.all(color: borderColor)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(icon, color: iconColor),
                Padding(
                  padding: EdgeInsets.only(top: 16.0, bottom: 6.0),
                  child: Text(title, style: DecoTextStyle.baseTextStyle.copyWith(fontSize: 16.0, color: textColor)),
                ),
                text == null
                    ? Container()
                    : Text(
                        text,
                        style: DecoTextStyle.baseTextStyle.copyWith(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
