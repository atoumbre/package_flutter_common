import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:softi_deco_ui/src/form_fields/common.dart';

class DecoFormDateTimePicker extends StatelessWidget {
  //! Parameters for Labels
  final String hintText;
  final String labelText;
  final String helperText;

  final String attribute;
  final List<FormFieldValidator> validators;
  final DateTime initialValue;
  final bool readOnly;

  final ValueTransformer valueTransformer;

  /// The date/time picker dialogs to show.
  final InputType inputType;

  /// Allow manual editing of the date/time. Defaults to true. If false, the
  /// picker(s) will be shown every time the field gains focus.
  // final bool editable;

  /// For representing the date as a string e.g.
  /// `DateFormat("EEEE, MMMM d, yyyy 'at' h:mma")`
  /// (Sunday, June 3, 2018 at 9:24pm)
  final DateFormat format;

  /// The date the calendar opens to when displayed. Defaults to the current date.
  ///
  /// To preset the widget's value, use [initialValue] instead.
  final DateTime initialDate;

  /// The earliest choosable date. Defaults to 1900.
  final DateTime firstDate;

  /// The latest choosable date. Defaults to 2100.
  final DateTime lastDate;

  /// The initial time prefilled in the picker dialog when it is shown. Defaults
  /// to noon. Explicitly set this to `null` to use the current time.
  final TimeOfDay initialTime;

  /// If defined, the TextField [decoration]'s [suffixIcon] will be
  /// overridden to reset the input using the icon defined here.
  /// Set this to `null` to stop that behavior. Defaults to [Icons.close].
  final Icon resetIcon;

  /// For validating the [DateTime]. The value passed will be `null` if
  /// [format] fails to parse the text.
  @Deprecated("Doesn't work. Use `validators` attribute to provides `List<FormFieldValidator>` for reusability")
  final FormFieldValidator<DateTime> validator;

  /// Called when an enclosing form is saved. The value passed will be `null`
  /// if [format] fails to parse the text.
  final FormFieldSetter<DateTime> onSaved;

  /// Corresponds to the [showDatePicker()] parameter. Defaults to
  /// [DatePickerMode.day].
  final DatePickerMode initialDatePickerMode;

  /// Corresponds to the [showDatePicker()] parameter.
  ///
  /// See [GlobalMaterialLocalizations](https://docs.flutter.io/flutter/flutter_localizations/GlobalMaterialLocalizations-class.html)
  /// for acceptable values.
  final Locale locale;

  /// Corresponds to the [showDatePicker()] parameter.
  final bool Function(DateTime) selectableDayPredicate;

  /// Corresponds to the [showDatePicker()] parameter.
  final ui.TextDirection textDirection;

  /// Corresponds to the [showDatePicker()] parameter.
  final bool useRootNavigator;

  /// Called when an enclosing form is submitted. The value passed will be
  /// `null` if [format] fails to parse the text.
  final ValueChanged<DateTime> onFieldSubmitted;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final TextStyle style;
  final TextAlign textAlign;

  /// Preset the widget's value.
  final bool autofocus;
  final bool autovalidate;
  final bool obscureText;
  final bool autocorrect;
  final bool maxLengthEnforced;
  final int maxLines;
  final int maxLength;
  final List<TextInputFormatter> inputFormatters;
  final bool enabled;
  final TransitionBuilder builder;

  /// Called when the time chooser dialog should be shown. In the future the
  /// preferred way of using this widget will be to utilize the [datePicker] and
  /// [timePicker] callback functions instead of adding their parameter list to
  /// this widget.
  final Future<TimeOfDay> Function(BuildContext context) timePicker;

  /// Called when the date chooser dialog should be shown. In the future the
  /// preferred way of using this widget will be to utilize the [datePicker] and
  /// [timePicker] callback functions instead of adding their parameter list to
  /// this widget.
  final Future<DateTime> Function(BuildContext context) datePicker;

  /// Called whenever the state's value changes, e.g. after picker value(s)
  /// have been selected or when the field loses focus. To listen for all text
  /// changes, use the [controller] and [focusNode].
  final ValueChanged<DateTime> onChanged;

  final bool showCursor;

  final int minLines;

  final bool expands;

  final TextInputAction textInputAction;

  final VoidCallback onEditingComplete;

  final InputCounterWidgetBuilder buildCounter;

  // final VoidCallback onEditingComplete,
  final Radius cursorRadius;
  final Color cursorColor;
  final Brightness keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;

  final double cursorWidth;
  final TextCapitalization textCapitalization;
  final bool alwaysUse24HourFormat;

  final StrutStyle strutStyle;

  DecoFormDateTimePicker({
    Key key,
    //!   Labels fields
    this.helperText,
    this.hintText,
    this.labelText,
    //
    @required this.attribute,
    this.validators = const [],
    this.readOnly = false,
    this.inputType = InputType.both,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.cursorWidth = 2.0,
    this.enableInteractiveSelection = true,
    this.resetIcon = const Icon(Icons.close),
    this.initialTime = const TimeOfDay(hour: 12, minute: 0),
    this.keyboardType = TextInputType.text,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.obscureText = false,
    this.autocorrect = true,
    this.maxLines = 1,
    this.maxLengthEnforced = true,
    this.expands = false,
    this.autovalidate = false,
    this.initialValue,
    this.format,
    this.firstDate,
    this.lastDate,
    this.onChanged,
    this.initialDate,
    this.validator,
    this.onSaved,
    this.onFieldSubmitted,
    this.initialDatePickerMode,
    this.locale,
    this.selectableDayPredicate,
    this.textDirection,
    this.controller,
    this.focusNode,
    this.style,
    this.enabled,
    this.maxLength,
    this.inputFormatters,
    this.valueTransformer,
    this.builder,
    this.timePicker,
    this.datePicker,
    this.showCursor,
    this.minLines,
    this.textInputAction,
    this.onEditingComplete,
    this.buildCounter,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.textCapitalization = TextCapitalization.none,
    this.strutStyle,
    this.useRootNavigator = true,
    this.alwaysUse24HourFormat = false,
  });

  @override
  Widget build(BuildContext context) {
    return DecoFormFieldDecorator(
      child: FormBuilderDateTimePicker(
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
        inputType: inputType,
        scrollPadding: scrollPadding,
        cursorWidth: cursorWidth,
        enableInteractiveSelection: enableInteractiveSelection,
        resetIcon: resetIcon,
        initialTime: initialTime,
        keyboardType: keyboardType,
        textAlign: textAlign,
        autofocus: autofocus,
        obscureText: obscureText,
        autocorrect: autocorrect,
        maxLines: maxLines,
        maxLengthEnforced: maxLengthEnforced,
        expands: expands,
        autovalidate: autovalidate,
        // editable: editable,
        initialValue: initialValue,
        format: format,
        firstDate: firstDate,
        lastDate: lastDate,
        onChanged: onChanged,
        initialDate: initialDate,
        onSaved: onSaved,
        onFieldSubmitted: onFieldSubmitted,
        initialDatePickerMode: initialDatePickerMode,
        locale: locale,
        selectableDayPredicate: selectableDayPredicate,
        textDirection: textDirection,
        controller: controller,
        focusNode: focusNode,
        style: style,
        enabled: enabled,
        maxLength: maxLength,
        inputFormatters: inputFormatters,
        valueTransformer: valueTransformer,
        builder: builder,
        timePicker: timePicker,
        datePicker: datePicker,
        showCursor: showCursor,
        minLines: minLines,
        textInputAction: textInputAction,
        onEditingComplete: onEditingComplete,
        buildCounter: buildCounter,
        cursorRadius: cursorRadius,
        cursorColor: cursorColor,
        keyboardAppearance: keyboardAppearance,
        textCapitalization: textCapitalization,
        strutStyle: strutStyle,
        useRootNavigator: useRootNavigator,
        alwaysUse24HourFormat: alwaysUse24HourFormat,
      ),
    );
  }
}
