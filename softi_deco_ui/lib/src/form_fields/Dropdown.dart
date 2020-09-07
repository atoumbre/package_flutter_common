import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:softi_deco_ui/src/form_fields/common.dart';

class DecoFormDropdown<T> extends StatelessWidget {
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

  final bool allowClear;
  final bool autofocus;
  final bool isDense;
  final bool isExpanded;
  final Color dropdownColor;
  final Color focusColor;
  final Color iconDisabledColor;
  final Color iconEnabledColor;
  final double iconSize;
  final double itemHeight;
  final DropdownButtonBuilder selectedItemBuilder;
  final int elevation;
  final List<DropdownMenuItem<T>> items;
  final TextStyle style;
  final VoidCallback onTap;
  final Widget clearIcon;
  final Widget disabledHint;
  final Widget hint;
  final Widget icon;

  DecoFormDropdown({
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
    @required this.items,
    this.isExpanded = true,
    this.isDense = true,
    this.elevation = 8,
    this.iconSize = 24.0,
    this.hint,
    this.style,
    this.disabledHint,
    this.icon,
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.allowClear = false,
    this.clearIcon = const Icon(Icons.close),
    this.onTap,
    this.autofocus = false,
    this.dropdownColor,
    this.focusColor,
    this.itemHeight,
    this.selectedItemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return DecoFormFieldDecorator(
      child: FormBuilderDropdown<T>(
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
        allowClear: allowClear,
        autofocus: autofocus,
        isDense: isDense,
        isExpanded: isExpanded,
        dropdownColor: dropdownColor,
        focusColor: focusColor,
        iconDisabledColor: iconDisabledColor,
        iconEnabledColor: iconEnabledColor,
        iconSize: iconSize,
        itemHeight: itemHeight,
        selectedItemBuilder: selectedItemBuilder,
        elevation: elevation,
        items: items,
        style: style,
        onTap: onTap,
        clearIcon: clearIcon,
        disabledHint: disabledHint,
        hint: hint,
        icon: icon,
      ),
    );
  }
}
