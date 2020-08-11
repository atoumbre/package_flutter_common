import 'package:flutter/material.dart';
import 'package:softi_deco_ui/src/styles.dart';

class TextArea extends StatelessWidget {
  final double height;
  final String hint;

  TextArea({this.height, this.hint});

  @override
  Widget build(BuildContext context) {
    var containerHeight = MediaQuery.of(context).size.height * 0.75;
    if (height != null) {
      containerHeight = height;
    }

    return Container(
      height: containerHeight,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color.fromARGB(10, 0, 0, 0),
            offset: Offset(0.0, 10.0),
            blurRadius: 30.0,
          ),
        ],
      ),
      child: TextField(
        maxLines: null,
        decoration: InputDecoration(border: InputBorder.none, hintText: hint, hintStyle: TextAreaStyle.hint),
      ),
    );
  }
}
