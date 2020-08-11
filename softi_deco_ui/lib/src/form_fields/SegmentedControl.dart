import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:softi_deco_ui/src/form_fields/common.dart';

class DecoFormSegmentedControl extends StatelessWidget {
  //! Parameters for Labels
  final String hintText;
  final String labelText;
  final String helperText;
  //
  final String attribute;
  final List<FormFieldValidator> validators;
  final dynamic initialValue;
  final bool readOnly;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;
  final Color borderColor;
  final Color selectedColor;
  final Color pressedColor;
  final FormFieldSetter onSaved;

  final List<FormBuilderFieldOption> options;
  final EdgeInsetsGeometry padding;
  final Color unselectedColor;

  DecoFormSegmentedControl({
    Key key,
    //!   Labels fields
    this.helperText,
    this.hintText,
    this.labelText,
    //
    @required this.attribute,
    @required this.options,
    this.initialValue,
    this.validators = const [],
    this.readOnly = false,
    this.onChanged,
    this.valueTransformer,
    this.borderColor,
    this.selectedColor,
    this.pressedColor,
    this.padding,
    this.unselectedColor,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return DecoFormFieldDecorator(
      child: FormBuilderSegmentedControl(
        key: key,
        decoration: decoDecoration(
          labelText: labelText,
          hintText: hintText,
          helperText: helperText,
        ),
        //
        attribute: attribute,
        options: options,
        initialValue: initialValue,
        validators: validators,
        readOnly: readOnly,
        onChanged: onChanged,
        valueTransformer: valueTransformer,
        borderColor: borderColor,
        selectedColor: selectedColor,
        pressedColor: pressedColor,
        padding: padding,
        unselectedColor: unselectedColor,
        onSaved: onSaved,
      ),
    );
  }
}
