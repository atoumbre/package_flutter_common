import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:softi_deco_ui/src/form_fields/common.dart';

class DecoFormPhoneField extends StatelessWidget {
  //! Parameters for Labels
  final String hintText;
  final String labelText;
  final String helperText;
  //
  final String attribute;
  final List<FormFieldValidator> validators;
  final String initialValue;
  final bool readOnly;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;

  final bool autovalidate;
  final int maxLines;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextStyle style;
  final TextEditingController controller;
  final FocusNode focusNode;
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
  final bool enabled;
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
  final FormFieldSetter onSaved;
  final VoidCallback onTap;

  // For country dialog
  final String searchText;
  final EdgeInsets titlePadding;
  final bool isSearchable;
  final Text dialogTitle;
  final String defaultSelectedCountryIsoCode;
  final List<String> priorityListByIsoCode;
  final List<String> countryFilterByIsoCode;
  final TextStyle dialogTextStyle;
  final bool isCupertinoPicker;
  final double cupertinoPickerSheetHeight;

  DecoFormPhoneField({
    Key key,
    //!   Labels fields
    this.helperText,
    this.hintText,
    this.labelText,
    //
    @required this.attribute,
    this.initialValue,
    this.validators = const [],
    this.readOnly = false,
    this.autovalidate = false,
    this.maxLines,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enabled = true,
    this.enableInteractiveSelection = true,
    this.maxLengthEnforced = true,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.autocorrect = true,
    this.cursorWidth = 2.0,
    this.keyboardType = TextInputType.phone,
    this.style,
    this.controller,
    this.focusNode,
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
    this.onChanged,
    this.valueTransformer,
    this.expands = false,
    this.minLines,
    this.showCursor,
    this.onSaved,
    this.onTap,
    this.searchText,
    this.titlePadding,
    this.dialogTitle,
    this.isSearchable,
    this.defaultSelectedCountryIsoCode = 'US',
    this.priorityListByIsoCode,
    this.countryFilterByIsoCode,
    this.dialogTextStyle,
    this.isCupertinoPicker = false,
    this.cupertinoPickerSheetHeight,
  });

  @override
  Widget build(BuildContext context) {
    return DecoFormFieldDecorator(
      child: FormBuilderPhoneField(
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
        autovalidate: autovalidate,
        maxLines: maxLines,
        obscureText: obscureText,
        textCapitalization: textCapitalization,
        scrollPadding: scrollPadding,
        enabled: enabled,
        enableInteractiveSelection: enableInteractiveSelection,
        maxLengthEnforced: maxLengthEnforced,
        textAlign: textAlign,
        autofocus: autofocus,
        autocorrect: autocorrect,
        cursorWidth: cursorWidth,
        keyboardType: keyboardType,
        style: style,
        controller: controller,
        focusNode: focusNode,
        textInputAction: textInputAction,
        strutStyle: strutStyle,
        textDirection: textDirection,
        maxLength: maxLength,
        onEditingComplete: onEditingComplete,
        onFieldSubmitted: onFieldSubmitted,
        inputFormatters: inputFormatters,
        cursorRadius: cursorRadius,
        cursorColor: cursorColor,
        keyboardAppearance: keyboardAppearance,
        buildCounter: buildCounter,
        onChanged: onChanged,
        valueTransformer: valueTransformer,
        expands: expands,
        minLines: minLines,
        showCursor: showCursor,
        onSaved: onSaved,
        onTap: onTap,
        searchText: searchText,
        titlePadding: titlePadding,
        dialogTitle: dialogTitle,
        isSearchable: isSearchable,
        defaultSelectedCountryIsoCode: defaultSelectedCountryIsoCode,
        priorityListByIsoCode: priorityListByIsoCode,
        countryFilterByIsoCode: countryFilterByIsoCode,
        dialogTextStyle: dialogTextStyle,
        isCupertinoPicker: isCupertinoPicker,
        cupertinoPickerSheetHeight: cupertinoPickerSheetHeight,
      ),
    );
  }
}
