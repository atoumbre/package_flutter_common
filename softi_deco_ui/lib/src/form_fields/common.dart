import 'package:softi_deco_ui/deco_ui.dart';
import 'package:flutter/material.dart';

InputDecoration decoDecoration({
  String hintText,
  String labelText,
  String helperText,
}) =>
    InputDecoration(
      contentPadding: EdgeInsets.all(0),
      border: InputBorder.none,
      hintText: hintText,
      labelText: labelText,
      helperText: helperText,
    );

class DecoFormFieldDecorator extends StatelessWidget {
  final Widget child;

  final double _vertical = 10;

  const DecoFormFieldDecorator({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: _vertical),
      child: DecoCard(
        padding: 16,
        child: child,
      ),
    );
  }
}
