import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:softi_deco_ui/src/form_fields/common.dart';

class DecoFormDateTimePicker extends StatelessWidget {
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
  final DateTime initialValue;
  final bool enabled;
  final FormFieldSetter onSaved;
  final bool autovalidate;

  // Other fields

  final bool alwaysUse24HourFormat;
  final bool autocorrect;
  final bool autofocus;
  final bool enableInteractiveSelection;
  final bool expands;
  final bool Function(DateTime) selectableDayPredicate;
  final bool maxLengthEnforced;
  final bool obscureText;
  final bool showCursor;
  final bool useRootNavigator;
  final Brightness keyboardAppearance;
  final Color cursorColor;
  final DateCancelledCallback onCancel;
  final DateChangedCallback onConfirm;
  final DateFormat format;
  final DatePickerEntryMode initialEntryMode;
  final DatePickerMode initialDatePickerMode;
  final DatePickerTheme theme;
  final DateTime currentDate;
  final DateTime firstDate;
  final DateTime initialDate;
  final DateTime lastDate;
  final double cursorWidth;
  final EdgeInsets scrollPadding;
  final Future<DateTime> Function(BuildContext context) datePicker;
  final Future<TimeOfDay> Function(BuildContext context) timePicker;
  final Icon resetIcon;
  final InputCounterWidgetBuilder buildCounter;
  final InputType inputType;
  final int maxLength;
  final int maxLines;
  final int minLines;
  final List<TextInputFormatter> inputFormatters;
  final Locale locale;
  final PickerType pickerType;
  final Radius cursorRadius;
  final RouteSettings routeSettings;
  final String cancelText;
  final String confirmText;
  final String errorFormatText;
  final String errorInvalidText;
  final String fieldHintText;
  final String fieldLabelText;
  final String helpText;
  final TextAlign textAlign;
  final TextCapitalization textCapitalization;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final TextStyle style;
  final TimeOfDay initialTime;
  final TimePickerEntryMode timePickerInitialEntryMode;
  final TransitionBuilder transitionBuilder;
  final ui.TextDirection textDirection;
  final ValueChanged<DateTime> onFieldSubmitted;
  final VoidCallback onEditingComplete;
  final StrutStyle strutStyle;

  DecoFormDateTimePicker({
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
    this.inputType = InputType.both,
    this.pickerType = PickerType.material,
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
    this.format,
    this.firstDate,
    this.lastDate,
    // this.onChanged,
    this.initialDate,
    // this.onSaved,
    this.onFieldSubmitted,
    this.initialDatePickerMode = DatePickerMode.day,
    this.locale,
    this.selectableDayPredicate,
    this.textDirection,
    this.controller,
    this.style,
    this.maxLength,
    this.inputFormatters,
    this.transitionBuilder,
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
    this.cancelText,
    this.confirmText,
    this.errorFormatText,
    this.errorInvalidText,
    this.fieldHintText,
    this.fieldLabelText,
    this.helpText,
    this.initialEntryMode = DatePickerEntryMode.calendar,
    this.routeSettings,
    this.currentDate,
    this.onConfirm,
    this.onCancel,
    this.theme,
    this.timePickerInitialEntryMode = TimePickerEntryMode.dial,
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
        cursorWidth: cursorWidth,
        scrollPadding: scrollPadding,
        datePicker: datePicker,
        timePicker: timePicker,
        resetIcon: resetIcon,
        buildCounter: buildCounter,
        inputType: inputType,
        maxLength: maxLength,
        maxLines: maxLines,
        minLines: minLines,
        inputFormatters: inputFormatters,
        locale: locale,
        pickerType: pickerType,
        cursorRadius: cursorRadius,
        routeSettings: routeSettings,
        cancelText: cancelText,
        confirmText: confirmText,
        errorFormatText: errorFormatText,
        errorInvalidText: errorInvalidText,
        fieldHintText: fieldHintText,
        fieldLabelText: fieldLabelText,
        helpText: helpText,
        textAlign: textAlign,
        textCapitalization: textCapitalization,
        controller: controller,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        style: style,
        initialTime: initialTime,
        timePickerInitialEntryMode: timePickerInitialEntryMode,
        transitionBuilder: transitionBuilder,
        textDirection: textDirection,
        onFieldSubmitted: onFieldSubmitted,
        onEditingComplete: onEditingComplete,
        strutStyle: strutStyle,
      ),
    );
  }
}
