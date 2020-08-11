import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:softi_deco_ui/src/form_fields/common.dart';

class DecoFormCheckbox extends StatelessWidget {
  //! Parameters for Labels
  final String hintText;
  final String labelText;
  final String helperText;
  //

  final String attribute;
  final List<FormFieldValidator> validators;
  final bool initialValue;
  final bool readOnly;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;
  final bool leadingInput;

  final Widget label;

  final Color activeColor;
  final Color checkColor;
  final MaterialTapTargetSize materialTapTargetSize;
  final bool tristate;
  final FormFieldSetter onSaved;
  final EdgeInsets contentPadding;

  DecoFormCheckbox({
    Key key,
    //!   Labels fields
    this.helperText,
    this.hintText,
    this.labelText,
    //
    @required this.attribute,
    @required this.label,
    this.initialValue,
    this.validators = const [],
    this.readOnly = false,
    this.onChanged,
    this.valueTransformer,
    this.leadingInput = false,
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
      child: FormBuilderCheckbox(
        key: key,
        decoration: decoDecoration(
          labelText: labelText,
          hintText: hintText,
          helperText: helperText,
        ),
        //
        attribute: attribute,
        label: label,
        initialValue: initialValue,
        validators: validators,
        readOnly: readOnly,
        onChanged: onChanged,
        valueTransformer: valueTransformer,
        leadingInput: leadingInput,
        activeColor: activeColor,
        checkColor: checkColor,
        materialTapTargetSize: materialTapTargetSize,
        tristate: tristate,
        onSaved: onSaved,
        contentPadding: contentPadding,
      ),
    );
  }
}
