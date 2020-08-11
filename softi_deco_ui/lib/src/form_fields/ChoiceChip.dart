import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:softi_deco_ui/src/form_fields/common.dart';

class DecoFormChoiceChip extends StatelessWidget {
  //! Parameters for Labels
  final String hintText;
  final String labelText;
  final String helperText;

  // FormBuilder Settings
  final String attribute;
  final List<FormFieldValidator> validators;
  final dynamic initialValue;
  final bool readOnly;
  final ValueChanged onChanged;
  final FormFieldSetter onSaved;
  final ValueTransformer valueTransformer;
  final List<FormBuilderFieldOption> options;

  // FilterChip Settings
  final double elevation, pressElevation;
  final Color selectedColor, disabledColor, backgroundColor, selectedShadowColor, shadowColor;
  final ShapeBorder shape;
  final MaterialTapTargetSize materialTapTargetSize;

  // Wrap Settings
  final Axis direction;
  final WrapAlignment alignment;
  final WrapCrossAlignment crossAxisAlignment;
  final WrapAlignment runAlignment;
  final double runSpacing, spacing;
  final TextDirection textDirection;
  final VerticalDirection verticalDirection;

  DecoFormChoiceChip({
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
    this.onSaved,
    this.selectedColor,
    this.disabledColor,
    this.backgroundColor,
    this.shadowColor,
    this.selectedShadowColor,
    this.shape,
    this.elevation,
    this.pressElevation,
    this.materialTapTargetSize,
    this.direction = Axis.horizontal,
    this.alignment = WrapAlignment.start,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.runAlignment = WrapAlignment.start,
    this.runSpacing = 0.0,
    this.spacing = 0.0,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
  });

  @override
  Widget build(BuildContext context) {
    return DecoFormFieldDecorator(
      child: FormBuilderChoiceChip(
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
        onSaved: onSaved,
        selectedColor: selectedColor,
        disabledColor: disabledColor,
        backgroundColor: backgroundColor,
        shadowColor: shadowColor,
        selectedShadowColor: selectedShadowColor,
        shape: shape,
        elevation: elevation,
        pressElevation: pressElevation,
        materialTapTargetSize: materialTapTargetSize,
        direction: direction,
        alignment: alignment,
        crossAxisAlignment: crossAxisAlignment,
        runAlignment: runAlignment,
        runSpacing: runSpacing,
        spacing: spacing,
        textDirection: textDirection,
        verticalDirection: verticalDirection,
      ),
    );
  }
}
