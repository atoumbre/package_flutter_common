import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:softi_deco_ui/src/form_fields/common.dart';

class DecoFormTouchSpin extends StatelessWidget {
  //! Parameters for Labels
  final String hintText;
  final String labelText;
  final String helperText;

  final String attribute;
  final List<FormFieldValidator> validators;
  final num initialValue;
  final bool readOnly;
  final InputDecoration decoration;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;
  final num step;
  final num min;
  final num max;
  final FormFieldSetter onSaved;
  final Icon subtractIcon;
  final Icon addIcon;
  final num iconSize;

  final NumberFormat displayFormat;

  final EdgeInsets iconPadding;

  final TextStyle textStyle;

  final Color iconActiveColor;

  final Color iconDisabledColor;

  DecoFormTouchSpin({
    Key key,
    //
    this.helperText,
    this.hintText,
    this.labelText,
    //
    @required this.attribute,
    this.initialValue,
    this.validators = const [],
    this.readOnly = false,
    this.decoration = const InputDecoration(),
    this.step,
    this.min = 1,
    this.max = 9999,
    this.onChanged,
    this.valueTransformer,
    this.onSaved,
    this.iconSize = 24.0,
    this.displayFormat,
    this.subtractIcon = const Icon(Icons.remove),
    this.addIcon = const Icon(Icons.add),
    this.iconPadding = const EdgeInsets.all(4.0),
    this.textStyle = const TextStyle(fontSize: 24),
    this.iconActiveColor,
    this.iconDisabledColor,
  });

  @override
  Widget build(BuildContext context) {
    return DecoFormFieldDecorator(
      child: FormBuilderTouchSpin(
        key: key,
        decoration: decoDecoration(
          labelText: labelText,
          hintText: hintText,
          helperText: helperText,
        ),
        //
        attribute: attribute,
        initialValue: initialValue,
        validators: validators,
        readOnly: readOnly,
        step: step,
        min: min,
        max: max,
        onChanged: onChanged,
        valueTransformer: valueTransformer,
        onSaved: onSaved,
        iconSize: iconSize,
        displayFormat: displayFormat,
        subtractIcon: subtractIcon,
        addIcon: addIcon,
        iconPadding: iconPadding,
        textStyle: textStyle,
        iconActiveColor: iconActiveColor,
        iconDisabledColor: iconDisabledColor,
      ),
    );
  }
}
