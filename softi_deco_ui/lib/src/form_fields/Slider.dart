import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:softi_deco_ui/src/form_fields/common.dart';

class DecoFormSlider extends StatelessWidget {
  //! Parameters for Labels
  final String hintText;
  final String labelText;
  final String helperText;

  // From Super

  final bool readOnly;
  final FocusNode focusNode;
  final String name;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;
  final VoidCallback onReset;
  final FormFieldValidator validator;
  final double initialValue;
  final bool enabled;
  final FormFieldSetter onSaved;
  final bool autovalidate;

  // Other fields

  final ValueChanged<double> onChangeStart;
  final ValueChanged<double> onChangeEnd;
  final TextStyle textStyle;
  final TextStyle minTextStyle;
  final TextStyle maxTextStyle;
  final String label;
  final SemanticFormatterCallback semanticFormatterCallback;
  final NumberFormat numberFormat;
  final MouseCursor mouseCursor;
  final int divisions;
  final double min;
  final double max;
  final DisplayValues displayValues;
  final Color inactiveColor;
  final Color activeColor;
  final bool autofocus;

  DecoFormSlider({
    Key key,
    //!   Labels fields
    this.helperText,
    this.hintText,
    this.labelText,
    // From Super
    this.name,
    this.validator,
    this.initialValue,
    this.readOnly = false,
    this.onChanged,
    this.valueTransformer,
    this.enabled = true,
    this.onSaved,
    this.autovalidate = false,
    this.onReset,
    this.focusNode,
    // Other fields
    @required this.min,
    @required this.max,
    this.divisions,
    this.activeColor,
    this.inactiveColor,
    this.onChangeStart,
    this.onChangeEnd,
    this.label,
    this.semanticFormatterCallback,
    this.numberFormat,
    this.displayValues = DisplayValues.all,
    this.minTextStyle,
    this.textStyle,
    this.maxTextStyle,
    this.autofocus = false,
    this.mouseCursor,
  });

  @override
  Widget build(BuildContext context) {
    return DecoFormFieldDecorator(
      child: FormBuilderSlider(
        key: key,
        decoration: decoDecoration(
          labelText: labelText,
          hintText: hintText,
          helperText: helperText,
        ),
        // From Supper
        initialValue: initialValue,
        name: name,
        validator: validator,
        valueTransformer: valueTransformer,
        onChanged: onChanged,
        readOnly: readOnly,
        autovalidate: autovalidate,
        onSaved: onSaved,
        enabled: enabled,
        onReset: onReset,
        focusNode: focusNode,
        // Other fields
        onChangeStart: onChangeStart,
        onChangeEnd: onChangeEnd,
        textStyle: textStyle,
        minTextStyle: minTextStyle,
        maxTextStyle: maxTextStyle,
        label: label,
        semanticFormatterCallback: semanticFormatterCallback,
        numberFormat: numberFormat,
        mouseCursor: mouseCursor,
        divisions: divisions,
        min: min,
        max: max,
        displayValues: displayValues,
        inactiveColor: inactiveColor,
        activeColor: activeColor,
        autofocus: autofocus,
      ),
    );
  }
}
