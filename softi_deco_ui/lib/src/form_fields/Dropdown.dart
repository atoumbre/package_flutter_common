import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:softi_deco_ui/src/form_fields/common.dart';

class DecoFormDropdown extends StatelessWidget {
  //! Parameters for Labels
  final String hintText;
  final String labelText;
  final String helperText;
  //
  final String attribute;
  final List<FormFieldValidator> validators;
  final dynamic initialValue;
  final bool readOnly;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;

  final Widget hint;
  final List<DropdownMenuItem> items;
  final bool isExpanded;
  final TextStyle style;
  final bool isDense;
  final int elevation;
  final Widget disabledHint;
  final double iconSize;
  final Widget underline;
  final Widget icon;
  final Color iconDisabledColor;
  final Color iconEnabledColor;
  final bool allowClear;
  final Widget clearIcon;
  final FormFieldSetter onSaved;

  DecoFormDropdown({
    Key key,
    //!   Labels fields
    this.helperText,
    this.hintText,
    this.labelText,
    //
    @required this.attribute,
    @required this.items,
    this.validators = const [],
    this.readOnly = false,
    this.isExpanded = true,
    this.isDense = true,
    this.elevation = 8,
    this.iconSize = 24.0,
    this.hint,
    this.initialValue,
    this.style,
    this.disabledHint,
    this.onChanged,
    this.valueTransformer,
    this.underline,
    this.icon,
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.allowClear = false,
    this.clearIcon = const Icon(Icons.close),
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return DecoFormFieldDecorator(
      child: FormBuilderDropdown(
        key: key,
        decoration: decoDecoration(
          labelText: labelText,
          hintText: hintText,
          helperText: helperText,
        ),
        //
        attribute: attribute,
        items: items,
        validators: validators,
        readOnly: readOnly,
        isExpanded: isExpanded,
        isDense: isDense,
        elevation: elevation,
        iconSize: iconSize,
        hint: hint,
        initialValue: initialValue,
        style: style,
        disabledHint: disabledHint,
        onChanged: onChanged,
        valueTransformer: valueTransformer,
        underline: underline,
        icon: icon,
        iconDisabledColor: iconDisabledColor,
        iconEnabledColor: iconEnabledColor,
        allowClear: allowClear,
        clearIcon: clearIcon,
        onSaved: onSaved,
      ),
    );
  }
}
