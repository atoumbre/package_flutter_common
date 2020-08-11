import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:softi_deco_ui/src/form_fields/common.dart';

class DecoFormSlider extends StatelessWidget {
  //! Parameters for Labels
  final String hintText;
  final String labelText;
  final String helperText;
  //
  final String attribute;
  final List<FormFieldValidator> validators;
  final double initialValue;
  final bool readOnly;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;

  final double max;
  final double min;
  final int divisions;
  final Color activeColor;
  final Color inactiveColor;
  final ValueChanged<double> onChangeStart;
  final ValueChanged<double> onChangeEnd;
  final String label;
  final SemanticFormatterCallback semanticFormatterCallback;
  final NumberFormat numberFormat;
  final FormFieldSetter onSaved;
  final DisplayValues displayValues;

  DecoFormSlider({
    Key key,
    //!   Labels fields
    this.helperText,
    this.hintText,
    this.labelText,
    //
    @required this.attribute,
    @required this.min,
    @required this.max,
    @required this.initialValue,
    this.validators = const [],
    this.readOnly = false,
    this.divisions,
    this.onChanged,
    this.valueTransformer,
    this.activeColor,
    this.inactiveColor,
    this.onChangeStart,
    this.onChangeEnd,
    this.label,
    this.semanticFormatterCallback,
    this.numberFormat,
    this.onSaved,
    this.displayValues = DisplayValues.all,
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
        //
        attribute: attribute,
        min: min,
        max: max,
        initialValue: initialValue,
        validators: validators,
        readOnly: readOnly,
        divisions: divisions,
        onChanged: onChanged,
        valueTransformer: valueTransformer,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        onChangeStart: onChangeStart,
        onChangeEnd: onChangeEnd,
        label: label,
        semanticFormatterCallback: semanticFormatterCallback,
        numberFormat: numberFormat,
        onSaved: onSaved,
        displayValues: displayValues,
      ),
    );
  }
}
