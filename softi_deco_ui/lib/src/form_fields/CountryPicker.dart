import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:softi_deco_ui/src/form_fields/common.dart';

class DecoFormCountryPicker extends StatelessWidget {
  //! Parameters for Labels
  final String hintText;
  final String labelText;
  final String helperText;
  //
  final String attribute;
  final List<FormFieldValidator> validators;
  final bool readOnly;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;

  final TextStyle style;
  final FormFieldSetter onSaved;

  // For country dialog
  final String searchText;
  final EdgeInsets titlePadding;
  final bool isSearchable;
  final Text dialogTitle;
  final String initialValue;
  final String defaultSelectedCountryIsoCode;
  final List<String> priorityListByIsoCode;
  final List<String> countryFilterByIsoCode;
  final TextStyle dialogTextStyle;
  final bool isCupertinoPicker;
  final double cupertinoPickerSheetHeight;
  final Color cursorColor;

  DecoFormCountryPicker({
    Key key,
    //!   Labels fields
    this.helperText,
    this.hintText,
    this.labelText,
    //
    @required this.attribute,
    this.defaultSelectedCountryIsoCode = 'US',
    @required this.initialValue,
    this.validators = const [],
    this.readOnly = false,
    this.style,
    this.onChanged,
    this.valueTransformer,
    this.onSaved,
    this.searchText,
    this.titlePadding,
    this.dialogTitle,
    this.isSearchable,
    this.priorityListByIsoCode,
    this.countryFilterByIsoCode,
    this.dialogTextStyle,
    this.isCupertinoPicker = false,
    this.cupertinoPickerSheetHeight,
    this.cursorColor,
  });

  @override
  Widget build(BuildContext context) {
    return DecoFormFieldDecorator(
      child: FormBuilderCountryPicker(
        key: key,
        decoration: decoDecoration(
          labelText: labelText,
          hintText: hintText,
          helperText: helperText,
        ),
        //
        attribute: attribute,
        defaultSelectedCountryIsoCode: defaultSelectedCountryIsoCode,
        initialValue: initialValue,
        validators: validators,
        readOnly: readOnly,
        style: style,
        onChanged: onChanged,
        valueTransformer: valueTransformer,
        onSaved: onSaved,
        searchText: searchText,
        titlePadding: titlePadding,
        dialogTitle: dialogTitle,
        isSearchable: isSearchable,
        priorityListByIsoCode: priorityListByIsoCode,
        countryFilterByIsoCode: countryFilterByIsoCode,
        dialogTextStyle: dialogTextStyle,
        isCupertinoPicker: isCupertinoPicker,
        cupertinoPickerSheetHeight: cupertinoPickerSheetHeight,
        cursorColor: cursorColor,
      ),
    );
  }
}
