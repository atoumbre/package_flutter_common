import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:softi_deco_ui/src/form_fields/common.dart';

class DecoFormTextField extends StatelessWidget {
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
  final String initialValue;
  final bool enabled;
  final FormFieldSetter onSaved;
  final bool autovalidate;

  // Other fields

  final int maxLines;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextStyle style;
  final TextEditingController controller;
  final TextCapitalization textCapitalization;
  final TextInputAction textInputAction;
  final StrutStyle strutStyle;
  final TextDirection textDirection;
  final TextAlign textAlign;
  final bool autofocus;
  final bool autocorrect;
  final bool maxLengthEnforced;
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
  final bool expands;
  final int minLines;
  final bool showCursor;
  final VoidCallback onTap;
  final bool enableSuggestions;
  final TextAlignVertical textAlignVertical;
  final DragStartBehavior dragStartBehavior;
  final ScrollController scrollController;
  final ScrollPhysics scrollPhysics;
  final ui.BoxWidthStyle selectionWidthStyle;
  final ui.BoxHeightStyle selectionHeightStyle;
  final SmartDashesType smartDashesType;
  final SmartQuotesType smartQuotesType;
  final ToolbarOptions toolbarOptions;
  final Iterable<String> autofillHints;
  final String obscuringCharacter;
  final MouseCursor mouseCursor;

  DecoFormTextField({
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
    this.maxLines = 1,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection = true,
    this.maxLengthEnforced = true,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.autocorrect = true,
    this.cursorWidth = 2.0,
    this.keyboardType,
    this.style,
    this.controller,
    this.textInputAction,
    this.strutStyle,
    this.textDirection,
    this.maxLength,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.buildCounter,
    this.expands = false,
    this.minLines,
    this.showCursor,
    this.onTap,
    this.enableSuggestions = false,
    this.textAlignVertical,
    this.dragStartBehavior = DragStartBehavior.start,
    this.scrollController,
    this.scrollPhysics,
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.smartDashesType,
    this.smartQuotesType,
    this.toolbarOptions,
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.autofillHints,
    this.obscuringCharacter = '•',
    this.mouseCursor,
  });

  @override
  Widget build(BuildContext context) {
    return DecoFormFieldDecorator(
      child: FormBuilderTextField(
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
        maxLines: maxLines,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: style,
        controller: controller,
        textCapitalization: textCapitalization,
        textInputAction: textInputAction,
        strutStyle: strutStyle,
        textDirection: textDirection,
        textAlign: textAlign,
        autofocus: autofocus,
        autocorrect: autocorrect,
        maxLengthEnforced: maxLengthEnforced,
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
        expands: expands,
        minLines: minLines,
        showCursor: showCursor,
        onTap: onTap,
        enableSuggestions: enableSuggestions,
        textAlignVertical: textAlignVertical,
        dragStartBehavior: dragStartBehavior,
        scrollController: scrollController,
        scrollPhysics: scrollPhysics,
        selectionWidthStyle: selectionWidthStyle,
        selectionHeightStyle: selectionHeightStyle,
        smartDashesType: smartDashesType,
        smartQuotesType: smartQuotesType,
        toolbarOptions: toolbarOptions,
        autofillHints: autofillHints,
        obscuringCharacter: obscuringCharacter,
        mouseCursor: mouseCursor,
      ),
    );
  }
}
