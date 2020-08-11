import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:softi_deco_ui/src/form_fields/common.dart';

class DecoFormRadioGroup extends StatelessWidget {
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

  final bool leadingInput;
  final List<FormBuilderFieldOption> options;
  final MaterialTapTargetSize materialTapTargetSize;
  final Color activeColor;
  final FormFieldSetter onSaved;
  final EdgeInsets contentPadding;
  final Axis direction;
  final MainAxisAlignment horizontalAlignment;
  final double spaceBetween;

  DecoFormRadioGroup({
    Key key,
    //
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
    this.leadingInput = false,
    this.materialTapTargetSize,
    this.activeColor,
    this.onSaved,
    this.contentPadding = const EdgeInsets.all(0.0),
    this.direction = Axis.horizontal,
    this.horizontalAlignment = MainAxisAlignment.start,
    this.spaceBetween,
  });

  @override
  Widget build(BuildContext context) {
    return DecoFormFieldDecorator(
      child: FormBuilderRadioGroup(
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

        // leadingInput: leadingInput,
        materialTapTargetSize: materialTapTargetSize,
        activeColor: activeColor,
        onSaved: onSaved,
        // contentPadding: contentPadding,
        // direction: direction,
        // horizontalAlignment: horizontalAlignment,
        // spaceBetween: spaceBetween,
      ),
    );
  }
}
