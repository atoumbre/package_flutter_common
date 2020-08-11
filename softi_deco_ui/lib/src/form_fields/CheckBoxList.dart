import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:softi_deco_ui/src/form_fields/common.dart';

class DecoFormCheckboxList extends StatelessWidget {
  //! Parameters for Labels
  final String hintText;
  final String labelText;
  final String helperText;

  final String attribute;
  final List<FormFieldValidator> validators;
  final dynamic initialValue;
  final bool readOnly;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;
  final FormFieldSetter onSaved;

  final List<FormBuilderFieldOption> options;
  final bool leadingInput;
  final Color activeColor;
  final Color checkColor;
  final MaterialTapTargetSize materialTapTargetSize;
  final bool tristate;
  final EdgeInsets contentPadding;

  DecoFormCheckboxList({
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
    this.leadingInput = false,
    this.onChanged,
    this.valueTransformer,
    this.activeColor,
    this.checkColor,
    this.materialTapTargetSize,
    this.tristate = false,
    this.onSaved,
    this.contentPadding = const EdgeInsets.all(0.0),
  });

  @override
  Widget build(BuildContext context) {
    return DecoFormFieldDecorator(
      child: FormBuilderCheckboxGroup(
        key: key,
        decoration: decoDecoration(
          labelText: labelText,
          hintText: hintText,
          helperText: helperText,
        ),
        attribute: attribute,
        options: options,
        initialValue: initialValue,
        validators: validators,
        readOnly: readOnly,
        // leadingInput: leadingInput,
        onChanged: onChanged,
        valueTransformer: valueTransformer,
        activeColor: activeColor,
        checkColor: checkColor,
        materialTapTargetSize: materialTapTargetSize,
        tristate: tristate,
        onSaved: onSaved,
        // contentPadding: contentPadding,
      ),
    );
  }
}
