import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:softi_deco_ui/src/form_fields/common.dart';

class DecoFormTypeAhead<T> extends StatelessWidget {
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

  final AnimationTransitionBuilder transitionBuilder;
  final AxisDirection direction;
  final bool autoFlipDirection;
  final bool getImmediateSuggestions;
  final bool hideOnEmpty;
  final bool hideOnError;
  final bool hideOnLoading;
  final bool hideSuggestionsOnKeyboardHide;
  final bool keepSuggestionsOnLoading;
  final bool keepSuggestionsOnSuggestionSelected;
  final double animationStart;
  final double suggestionsBoxVerticalOffset;
  final Duration animationDuration;
  final Duration debounceDuration;
  final ErrorBuilder errorBuilder;
  final ItemBuilder<T> itemBuilder;
  final SelectionToTextTransformer<T> selectionToTextTransformer;
  final SuggestionsBoxController suggestionsBoxController;
  final SuggestionsBoxDecoration suggestionsBoxDecoration;
  final SuggestionsCallback<T> suggestionsCallback;
  final SuggestionSelectionCallback<T> onSuggestionSelected;
  final TextEditingController controller;
  final TextFieldConfiguration textFieldConfiguration;
  final WidgetBuilder loadingBuilder;
  final WidgetBuilder noItemsFoundBuilder;

  DecoFormTypeAhead({
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
    @required this.itemBuilder,
    @required this.suggestionsCallback,
    this.getImmediateSuggestions = false,
    this.selectionToTextTransformer,
    this.errorBuilder,
    this.noItemsFoundBuilder,
    this.loadingBuilder,
    this.debounceDuration = const Duration(milliseconds: 300),
    this.suggestionsBoxDecoration = const SuggestionsBoxDecoration(),
    this.suggestionsBoxVerticalOffset = 5.0,
    this.textFieldConfiguration = const TextFieldConfiguration(),
    this.transitionBuilder,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationStart = 0.25,
    this.direction = AxisDirection.down,
    this.hideOnLoading = false,
    this.hideOnEmpty = false,
    this.hideOnError = false,
    this.hideSuggestionsOnKeyboardHide = true,
    this.keepSuggestionsOnLoading = true,
    this.autoFlipDirection = false,
    this.suggestionsBoxController,
    this.keepSuggestionsOnSuggestionSelected = false,
    this.onSuggestionSelected,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return DecoFormFieldDecorator(
      child: FormBuilderTypeAhead<T>(
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
        transitionBuilder: transitionBuilder,
        direction: direction,
        autoFlipDirection: autoFlipDirection,
        getImmediateSuggestions: getImmediateSuggestions,
        hideOnEmpty: hideOnEmpty,
        hideOnError: hideOnError,
        hideOnLoading: hideOnLoading,
        hideSuggestionsOnKeyboardHide: hideSuggestionsOnKeyboardHide,
        keepSuggestionsOnLoading: keepSuggestionsOnLoading,
        keepSuggestionsOnSuggestionSelected: keepSuggestionsOnSuggestionSelected,
        animationStart: animationStart,
        suggestionsBoxVerticalOffset: suggestionsBoxVerticalOffset,
        animationDuration: animationDuration,
        debounceDuration: debounceDuration,
        errorBuilder: errorBuilder,
        itemBuilder: itemBuilder,
        selectionToTextTransformer: selectionToTextTransformer,
        suggestionsBoxController: suggestionsBoxController,
        suggestionsBoxDecoration: suggestionsBoxDecoration,
        suggestionsCallback: suggestionsCallback,
        onSuggestionSelected: onSuggestionSelected,
        controller: controller,
        textFieldConfiguration: textFieldConfiguration,
        loadingBuilder: loadingBuilder,
        noItemsFoundBuilder: noItemsFoundBuilder,
      ),
    );
  }
}
