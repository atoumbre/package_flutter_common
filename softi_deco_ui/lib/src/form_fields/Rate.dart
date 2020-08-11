import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:softi_deco_ui/src/form_fields/common.dart';

class DecoFormRate extends StatelessWidget {
  //! Parameters for Labels
  final String hintText;
  final String labelText;
  final String helperText;
  //
  final String attribute;
  final List<FormFieldValidator> validators;
  final num initialValue;
  final bool readOnly;
  final ValueChanged onChanged;
  final FormFieldSetter onSaved;
  final ValueTransformer valueTransformer;

  final IconData icon;
  final num iconSize;
  final num max;
  final Color filledColor;
  final IconData emptyIcon;
  final Color emptyColor;
  final bool isHalfAllowed;
  final IconData halfFilledIcon;
  final Color halfFilledColor;

  DecoFormRate({
    Key key,
    //!   Labels fields
    this.helperText,
    this.hintText,
    this.labelText,
    //
    @required this.attribute,
    this.initialValue = 1.0,
    this.validators = const [],
    this.readOnly = false,
    this.max = 5.0,
    this.icon = Icons.star,
    this.iconSize = 24.0,
    this.onChanged,
    this.valueTransformer,
    this.onSaved,
    this.filledColor,
    this.emptyIcon = Icons.star,
    this.emptyColor,
    this.isHalfAllowed = false,
    this.halfFilledIcon = Icons.star_half,
    this.halfFilledColor,
  });

  @override
  Widget build(BuildContext context) {
    return DecoFormFieldDecorator(
      child: FormBuilderRate(
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
        max: max,
        icon: icon,
        iconSize: iconSize,
        onChanged: onChanged,
        valueTransformer: valueTransformer,
        onSaved: onSaved,
        filledColor: filledColor,
        emptyIcon: emptyIcon,
        emptyColor: emptyColor,
        isHalfAllowed: isHalfAllowed,
        halfFilledIcon: halfFilledIcon,
        halfFilledColor: halfFilledColor,
      ),
    );
  }
}
