import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:softi_deco_ui/src/form_fields/common.dart';

class DecoFormRangeSlider extends StatelessWidget {
  //! Parameters for Labels
  final String hintText;
  final String labelText;
  final String helperText;
  //
  final String attribute;
  final List<FormFieldValidator> validators;
  final RangeValues initialValue;
  final bool readOnly;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;
  final num max;
  final num min;
  final int divisions;
  final Color activeColor;
  final Color inactiveColor;
  final ValueChanged<RangeValues> onChangeStart;
  final ValueChanged<RangeValues> onChangeEnd;
  final RangeLabels labels;
  // final RangeSemanticFormatterCallback semanticFormatterCallback;
  final FormFieldSetter onSaved;
  final DisplayValues displayValues;

  DecoFormRangeSlider({
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
    this.labels,
    // this.semanticFormatterCallback,
    this.onSaved,
    this.displayValues = DisplayValues.all,
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
        labels: labels,
        // semanticFormatterCallback: semanticFormatterCallback,
        onSaved: onSaved,
        displayValues: displayValues,
      ),
    );
  }
}
