import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:softi_deco_ui/src/form_fields/common.dart';

class DecoFormSignaturePad extends StatelessWidget {
  //! Parameters for Labels
  final String hintText;
  final String labelText;
  final String helperText;
  //
  final String attribute;
  final List<FormFieldValidator> validators;
  final bool readOnly;
  final ValueTransformer valueTransformer;
  final ValueChanged onChanged;
  final FormFieldSetter onSaved;
  final double width;
  final double height;
  final Color backgroundColor;
  final String clearButtonText;
  final SignatureController controller;

  DecoFormSignaturePad({
    Key key,
    //!   Labels fields
    this.helperText,
    this.hintText,
    this.labelText,
    //
    @required this.attribute,
    this.validators = const [],
    this.readOnly = false,
    this.backgroundColor = Colors.white,
    this.clearButtonText = 'Clear',
    this.width,
    this.height = 200,
    this.valueTransformer,
    this.onChanged,
    this.onSaved,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return DecoFormFieldDecorator(
      child: FormBuilderSignaturePad(
        key: key,
        decoration: decoDecoration(
          labelText: labelText,
          hintText: hintText,
          helperText: helperText,
        ),
        //
        attribute: attribute,
        validators: validators,
        readOnly: readOnly,
        backgroundColor: backgroundColor,
        clearButtonText: clearButtonText,
        width: width,
        height: height,
        valueTransformer: valueTransformer,
        onChanged: onChanged,
        onSaved: onSaved,
        controller: controller,
      ),
    );
  }
}
