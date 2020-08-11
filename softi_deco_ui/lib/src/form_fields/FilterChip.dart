import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:softi_deco_ui/src/form_fields/common.dart';

// FormBuilderFilterChip(
class DecoFormFilterChip extends StatelessWidget {
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
  final ValueTransformer valueTransformer;
  final List<FormBuilderFieldOption> options;
  final FormFieldSetter onSaved;

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
  final EdgeInsets padding;
  final Color checkmarkColor;
  final Clip clipBehavior;
  final TextStyle labelStyle;
  final bool showCheckmark;
  final EdgeInsets labelPadding;
  // final VisualDensity visualDensity;

  DecoFormFilterChip({
    Key key,
    //!   Labels fields
    this.helperText,
    this.hintText,
    this.labelText,

    // FormBuilder fields
    @required this.attribute,
    @required this.options,
    this.initialValue,
    this.validators = const [],
    this.readOnly = false,
    this.onChanged,
    this.onSaved,
    this.valueTransformer,
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
    this.padding,
    this.checkmarkColor,
    this.clipBehavior = Clip.none,
    this.labelStyle,
    this.showCheckmark = true,
    this.labelPadding,

    // this.visualDensity,
  });

  @override
  Widget build(BuildContext context) {
    return DecoFormFieldDecorator(
      child: FormBuilderFilterChip(
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
        onSaved: onSaved,
        valueTransformer: valueTransformer,
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
        padding: padding,
        checkmarkColor: checkmarkColor,
        clipBehavior: clipBehavior,
        labelStyle: labelStyle,
        showCheckmark: showCheckmark,
        labelPadding: labelPadding,
      ),
    );
  }
}
