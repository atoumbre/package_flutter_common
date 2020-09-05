import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:softi_deco_ui/src/form_fields/common.dart';

class DecoFormCheckbox extends StatelessWidget {
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
  final bool initialValue;
  final bool enabled;
  final FormFieldSetter onSaved;
  final bool autovalidate;

  // Other fields

  final bool autofocus;
  final bool selected;
  final bool tristate;
  final Color activeColor;
  final Color checkColor;
  final EdgeInsets contentPadding;
  final ListTileControlAffinity controlAffinity;
  final Widget secondary;
  final Widget subtitle;
  final Widget title;

  DecoFormCheckbox({
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
    @required this.title,
    this.activeColor,
    this.checkColor,
    this.subtitle,
    this.secondary,
    this.controlAffinity = ListTileControlAffinity.leading,
    this.contentPadding = const EdgeInsets.all(0.0),
    this.autofocus = false,
    this.tristate = false,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return DecoFormFieldDecorator(
      child: FormBuilderCheckbox(
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
        title: title,
        activeColor: activeColor,
        checkColor: checkColor,
        subtitle: subtitle,
        secondary: secondary,
        controlAffinity: controlAffinity,
        contentPadding: contentPadding,
        autofocus: autofocus,
        tristate: tristate,
        selected: selected,
      ),
    );
  }
}
