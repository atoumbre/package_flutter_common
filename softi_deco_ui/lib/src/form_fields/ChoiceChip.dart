import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:softi_deco_ui/src/form_fields/common.dart';

class DecoFormChoiceChip<T> extends StatelessWidget {
  //! Parameters for Labels
  final String hintText;
  final String labelText;
  final String helperText;

  // From Super

  final bool readOnly;
  final FocusNode focusNode;
  final String name;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;
  final VoidCallback onReset;
  final FormFieldValidator validator;
  final T initialValue;
  final bool enabled;
  final FormFieldSetter onSaved;
  final bool autovalidate;

  // Other fields

  final Axis direction;
  final Color backgroundColor;
  final Color disabledColor;
  final Color selectedColor;
  final Color selectedShadowColor;
  final Color shadowColor;
  final double elevation;
  final double pressElevation;
  final double runSpacing;
  final double spacing;
  final EdgeInsets labelPadding;
  final EdgeInsets padding;
  final List<FormBuilderFieldOption> options;
  final MaterialTapTargetSize materialTapTargetSize;
  final ShapeBorder shape;
  final TextDirection textDirection;
  final TextStyle labelStyle;
  final VerticalDirection verticalDirection;
  final VisualDensity visualDensity;
  final WrapAlignment alignment;
  final WrapAlignment runAlignment;
  final WrapCrossAlignment crossAxisAlignment;

  DecoFormChoiceChip({
    Key key,
    //!   Labels fields
    this.helperText,
    this.hintText,
    this.labelText,
    // From Super
    this.name,
    this.validator,
    this.initialValue,
    this.readOnly = false,
    this.onChanged,
    this.valueTransformer,
    this.enabled = true,
    this.onSaved,
    this.autovalidate = false,
    this.onReset,
    this.focusNode,
    // Other fields
    @required this.options,
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
    this.labelPadding,
    this.labelStyle,
    this.padding,
    this.visualDensity,
  });

  @override
  Widget build(BuildContext context) {
    return DecoFormFieldDecorator(
      child: FormBuilderChoiceChip<T>(
        key: key,
        decoration: decoDecoration(
          labelText: labelText,
          hintText: hintText,
          helperText: helperText,
        ),
        // From Supper
        initialValue: initialValue,
        name: name,
        validator: validator,
        valueTransformer: valueTransformer,
        onChanged: onChanged,
        readOnly: readOnly,
        autovalidate: autovalidate,
        onSaved: onSaved,
        enabled: enabled,
        onReset: onReset,
        focusNode: focusNode,
        // Other fields
        direction: direction,
        backgroundColor: backgroundColor,
        disabledColor: disabledColor,
        selectedColor: selectedColor,
        selectedShadowColor: selectedShadowColor,
        shadowColor: shadowColor,
        elevation: elevation,
        pressElevation: pressElevation,
        runSpacing: runSpacing,
        spacing: spacing,
        labelPadding: labelPadding,
        padding: padding,
        options: options,
        materialTapTargetSize: materialTapTargetSize,
        shape: shape,
        textDirection: textDirection,
        labelStyle: labelStyle,
        verticalDirection: verticalDirection,
        visualDensity: visualDensity,
        alignment: alignment,
        runAlignment: runAlignment,
        crossAxisAlignment: crossAxisAlignment,
      ),
    );
  }
}
