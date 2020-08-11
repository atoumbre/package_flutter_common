import 'package:softi_deco_ui/src/form_fields/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DecoFormColorPicker extends StatelessWidget {
  //! Parameters for Labels
  final String hintText;
  final String labelText;
  final String helperText;

  final String attribute;
  final Color initialValue;
  final List<FormFieldValidator> validators;
  final bool enabled;
  final bool autovalidate;
  final ValueTransformer valueTransformer;
  final ValueChanged onChanged;
  final FormFieldSetter<Color> onSaved;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool readOnly;

  final ColorPickerType colorPickerType;
  final TextCapitalization textCapitalization;

  final TextAlign textAlign;

  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextStyle style;
  final StrutStyle strutStyle;
  final TextDirection textDirection;
  final bool autofocus;

  final bool obscureText;

  final bool autocorrect;

  final bool maxLengthEnforced;

  final int maxLines;

  final bool expands;

  final bool showCursor;
  final int minLines;
  final int maxLength;
  final VoidCallback onEditingComplete;
  final ValueChanged<String> onFieldSubmitted;
  final List<TextInputFormatter> inputFormatters;
  final double cursorWidth;
  final Radius cursorRadius;
  final Color cursorColor;
  final Brightness keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final InputCounterWidgetBuilder buildCounter;

  DecoFormColorPicker({
    Key key,
    //!   Labels fields
    this.helperText,
    this.hintText,
    this.labelText,
    //
    @required this.attribute,
    this.initialValue,
    this.validators = const [],
    this.enabled = true,
    this.autovalidate = false,
    this.valueTransformer,
    this.onChanged,
    this.onSaved,
    //
    this.controller,
    this.focusNode,
    this.readOnly = false,
    this.colorPickerType = ColorPickerType.ColorPicker,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.keyboardType,
    this.textInputAction,
    this.style,
    this.strutStyle,
    this.textDirection,
    this.autofocus = false,
    this.obscureText = false,
    this.autocorrect = true,
    this.maxLengthEnforced = true,
    this.maxLines = 1,
    this.expands = false,
    this.showCursor,
    this.minLines,
    this.maxLength,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.cursorWidth = 2.0,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection = true,
    this.buildCounter,
  });

  @override
  Widget build(BuildContext context) {
    return DecoFormFieldDecorator(
      child: FormBuilderColorPicker(
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
        enabled: enabled,
        autovalidate: autovalidate,
        valueTransformer: valueTransformer,
        onChanged: onChanged,
        onSaved: onSaved,
        controller: controller,
        focusNode: focusNode,
        readOnly: readOnly,
        colorPickerType: colorPickerType,
        textCapitalization: textCapitalization,
        textAlign: textAlign,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        style: style,
        strutStyle: strutStyle,
        textDirection: textDirection,
        autofocus: autofocus,
        obscureText: obscureText,
        autocorrect: autocorrect,
        maxLengthEnforced: maxLengthEnforced,
        maxLines: maxLines,
        expands: expands,
        showCursor: showCursor,
        minLines: minLines,
        maxLength: maxLength,
        onEditingComplete: onEditingComplete,
        onFieldSubmitted: onFieldSubmitted,
        inputFormatters: inputFormatters,
        cursorWidth: cursorWidth,
        cursorRadius: cursorRadius,
        cursorColor: cursorColor,
        keyboardAppearance: keyboardAppearance,
        scrollPadding: scrollPadding,
        enableInteractiveSelection: enableInteractiveSelection,
        buildCounter: buildCounter,
      ),
    );
  }
}
