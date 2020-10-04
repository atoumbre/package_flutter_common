import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:softi_deco_ui/src/form_fields/common.dart';

class DecoFormRangeSlider extends StatelessWidget {
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
  final RangeValues initialValue;
  final bool enabled;
  final FormFieldSetter onSaved;
  final bool autovalidate;

  // Other fields

  final Color activeColor;
  final Color inactiveColor;
  final double max;
  final double min;
  final int divisions;
  final RangeLabels labels;
  // final RangeSemanticFormatterCallback semanticFormatterCallback;
  final ValueChanged<RangeValues> onChangeEnd;
  final ValueChanged<RangeValues> onChangeStart;
  final DisplayValues displayValues;
  final TextStyle minTextStyle;
  final TextStyle textStyle;
  final TextStyle maxTextStyle;
  final NumberFormat numberFormat;

  DecoFormRangeSlider({
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
    this.labels,
    // this.semanticFormatterCallback,
    this.displayValues = DisplayValues.all,
    this.minTextStyle,
    this.textStyle,
    this.maxTextStyle,
    this.numberFormat,
  });

  @override
  Widget build(BuildContext context) {
    return DecoFormFieldDecorator(
      child: FormBuilderRangeSlider(
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
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        max: max,
        min: min,
        divisions: divisions,
        labels: labels,
        // semanticFormatterCallback: semanticFormatterCallback,
        onChangeEnd: onChangeEnd,
        onChangeStart: onChangeStart,
        displayValues: displayValues,
        minTextStyle: minTextStyle,
        textStyle: textStyle,
        maxTextStyle: maxTextStyle,
        numberFormat: numberFormat,
      ),
    );
  }
}
