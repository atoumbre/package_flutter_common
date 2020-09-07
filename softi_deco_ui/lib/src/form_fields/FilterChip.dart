import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:softi_deco_ui/src/form_fields/common.dart';

// FormBuilderFilterChip(
class DecoFormFilterChip extends StatelessWidget {
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
  final List<dynamic> initialValue;
  final bool enabled;
  final FormFieldSetter onSaved;
  final bool autovalidate;

  // Other fields

  final List<FormBuilderFieldOption> options;
  final double elevation, pressElevation;
  final Color selectedColor;
  final Color disabledColor;
  final Color backgroundColor;
  final Color selectedShadowColor;
  final Color shadowColor;
  final ShapeBorder shape;
  final MaterialTapTargetSize materialTapTargetSize;
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

  DecoFormFilterChip({
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
    this.padding,
    this.checkmarkColor,
    this.clipBehavior = Clip.none,
    this.labelStyle,
    this.showCheckmark = true,
    this.labelPadding,
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
        options: options,
        elevation: elevation,
        selectedColor: selectedColor,
        disabledColor: disabledColor,
        backgroundColor: backgroundColor,
        selectedShadowColor: selectedShadowColor,
        shadowColor: shadowColor,
        shape: shape,
        materialTapTargetSize: materialTapTargetSize,
        direction: direction,
        alignment: alignment,
        crossAxisAlignment: crossAxisAlignment,
        runAlignment: runAlignment,
        runSpacing: runSpacing,
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
