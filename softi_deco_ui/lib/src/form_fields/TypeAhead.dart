import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:softi_deco_ui/src/form_fields/common.dart';

class DecoFormTypeAhead<T> extends StatelessWidget {
  //! Parameters for Labels
  final String hintText;
  final String labelText;
  final String helperText;
  //
  final String attribute;
  final List<FormFieldValidator> validators;
  final T initialValue;
  final bool readOnly;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;

  final bool getImmediateSuggestions;
  final bool autovalidate;
  final ErrorBuilder errorBuilder;
  final WidgetBuilder noItemsFoundBuilder;
  final WidgetBuilder loadingBuilder;
  final Duration debounceDuration;
  final SuggestionsBoxDecoration suggestionsBoxDecoration;
  final String Function(T) selectionToTextTransformer;
  final ItemBuilder<T> itemBuilder;
  final SuggestionsCallback<T> suggestionsCallback;
  final double suggestionsBoxVerticalOffset;
  final TextFieldConfiguration textFieldConfiguration;
  final AnimationTransitionBuilder transitionBuilder;
  final Duration animationDuration;
  final double animationStart;
  final AxisDirection direction;
  final bool hideOnLoading;
  final bool hideOnEmpty;
  final bool hideOnError;
  final bool hideSuggestionsOnKeyboardHide;
  final bool keepSuggestionsOnLoading;
  final bool autoFlipDirection;
  final SuggestionsBoxController suggestionsBoxController;
  final bool keepSuggestionsOnSuggestionSelected;
  final SuggestionSelectionCallback<T> onSuggestionSelected;
  final TextEditingController controller;
  final FormFieldSetter<T> onSaved;

  DecoFormTypeAhead({
    Key key,
    //!   Labels fields
    this.helperText,
    this.hintText,
    this.labelText,
    //
    @required this.attribute,
    @required this.itemBuilder,
    @required this.suggestionsCallback,
    this.initialValue,
    this.validators = const [],
    this.readOnly = false,
    this.getImmediateSuggestions = false,
    this.autovalidate = false,
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
    this.onChanged,
    this.valueTransformer,
    this.suggestionsBoxController,
    this.keepSuggestionsOnSuggestionSelected = false,
    this.onSuggestionSelected,
    this.controller,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return DecoFormFieldDecorator(
      child: FormBuilderTypeAhead(
        key: key,
        decoration: decoDecoration(
          labelText: labelText,
          hintText: hintText,
          helperText: helperText,
        ),
        //
        attribute: attribute,
        itemBuilder: itemBuilder,
        suggestionsCallback: suggestionsCallback,
        initialValue: initialValue,
        validators: validators,
        readOnly: readOnly,
        getImmediateSuggestions: getImmediateSuggestions,
        autovalidate: autovalidate,
        selectionToTextTransformer: selectionToTextTransformer,
        errorBuilder: errorBuilder,
        noItemsFoundBuilder: noItemsFoundBuilder,
        loadingBuilder: loadingBuilder,
        debounceDuration: debounceDuration,
        suggestionsBoxDecoration: suggestionsBoxDecoration,
        suggestionsBoxVerticalOffset: suggestionsBoxVerticalOffset,
        textFieldConfiguration: textFieldConfiguration,
        transitionBuilder: transitionBuilder,
        animationDuration: animationDuration,
        animationStart: animationStart,
        direction: direction,
        hideOnLoading: hideOnLoading,
        hideOnEmpty: hideOnEmpty,
        hideOnError: hideOnError,
        hideSuggestionsOnKeyboardHide: hideSuggestionsOnKeyboardHide,
        keepSuggestionsOnLoading: keepSuggestionsOnLoading,
        autoFlipDirection: autoFlipDirection,
        onChanged: onChanged,
        valueTransformer: valueTransformer,
        suggestionsBoxController: suggestionsBoxController,
        keepSuggestionsOnSuggestionSelected: keepSuggestionsOnSuggestionSelected,
        onSuggestionSelected: onSuggestionSelected,
        controller: controller,
        onSaved: onSaved,
      ),
    );
  }
}
