import 'package:date_range_picker/date_range_picker.dart' as date_range_picker;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart' as intl;
import 'package:softi_deco_ui/src/form_fields/common.dart';

class DecoFormDateRangePicker extends StatelessWidget {
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
  final DateTime initialFirstDate;
  final DateTime initialLastDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final date_range_picker.DatePickerMode initialDatePickerMode;
  final Locale locale;
  final date_range_picker.SelectableDayPredicate selectableDayPredicate;
  final intl.DateFormat format;

  DecoFormDateRangePicker({
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
    @required this.firstDate,
    @required this.lastDate,
    this.format,
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
    this.initialFirstDate,
    this.initialLastDate,
    this.initialDatePickerMode = date_range_picker.DatePickerMode.day,
    this.locale,
    this.selectableDayPredicate,
  });

  @override
  Widget build(BuildContext context) {
    return DecoFormFieldDecorator(
      child: FormBuilderDateRangePicker(
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
        initialFirstDate: initialFirstDate,
        initialLastDate: initialLastDate,
        firstDate: firstDate,
        lastDate: lastDate,
        initialDatePickerMode: initialDatePickerMode,
        locale: locale,
        selectableDayPredicate: selectableDayPredicate,
        format: format,
      ),
    );
  }
}
