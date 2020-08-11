import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:softi_deco_ui/src/form_fields/common.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';

class DecoFormChipsInput<T> extends StatelessWidget {
  //! Parameters for Labels
  final String hintText;
  final String labelText;
  final String helperText;
  //
  final String attribute;
  final List<FormFieldValidator> validators;
  final List<T> initialValue;
  final bool readOnly;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;

  final ChipsInputSuggestions findSuggestions;

  // final ValueChanged<List<T>> onChanged;
  final ChipsBuilder<T> chipBuilder;
  final ChipsBuilder<T> suggestionBuilder;
  final int maxChips;
  final TextStyle textStyle;
  final String actionLabel;
  final bool autocorrect;
  final TextInputAction inputAction;
  final TextInputType inputType;
  final Brightness keyboardAppearance;
  final bool obscureText;
  final double suggestionsBoxMaxHeight;
  final TextCapitalization textCapitalization;
  final FormFieldSetter onSaved;
  final FocusNode focusNode;
  final bool allowChipEditing;
  final bool autofocus;

  DecoFormChipsInput({
    Key key,
    //!   Labels fields
    this.helperText,
    this.hintText,
    this.labelText,
    //
    @required this.attribute,
    @required this.chipBuilder,
    @required this.suggestionBuilder,
    @required this.findSuggestions,
    this.initialValue = const [],
    this.validators = const [],
    this.readOnly = false,
    this.maxChips,
    this.onChanged,
    this.valueTransformer,
    this.textStyle,
    this.actionLabel,
    this.suggestionsBoxMaxHeight,
    this.autocorrect = false,
    this.inputAction = TextInputAction.done,
    this.inputType = TextInputType.text,
    this.keyboardAppearance = Brightness.light,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
    this.onSaved,
    this.focusNode,
    this.allowChipEditing = false,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return DecoFormFieldDecorator(
      child: FormBuilderChipsInput(
        key: key,
        decoration: decoDecoration(
          labelText: labelText,
          hintText: hintText,
          helperText: helperText,
        ),
        //
        attribute: attribute,
        chipBuilder: chipBuilder,
        suggestionBuilder: suggestionBuilder,
        findSuggestions: findSuggestions,
        initialValue: initialValue,
        validators: validators,
        readOnly: readOnly,
        maxChips: maxChips,
        onChanged: onChanged,
        valueTransformer: valueTransformer,
        textStyle: textStyle,
        actionLabel: actionLabel,
        suggestionsBoxMaxHeight: suggestionsBoxMaxHeight,
        autocorrect: autocorrect,
        inputAction: inputAction,
        inputType: inputType,
        keyboardAppearance: keyboardAppearance,
        obscureText: obscureText,
        textCapitalization: textCapitalization,
        onSaved: onSaved,
        focusNode: focusNode,
        allowChipEditing: allowChipEditing,
        autofocus: autofocus,
      ),
    );
  }
}
