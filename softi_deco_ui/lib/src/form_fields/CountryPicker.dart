import 'package:dropdown_search/dropdown_search.dart' as dropdown_search;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:softi_deco_ui/src/form_fields/common.dart';

class DecoFormSearchableDropdown<T> extends StatelessWidget {
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

  final bool autoFocusSearchBox;
  final bool autoValidate;
  final bool dropdownBuilderSupportsNullItem;
  final bool isFilteredOnline;
  final bool showClearButton;
  final bool showSearchBox;
  final bool showSelectedItem;
  final Color popupBackgroundColor;
  final Color popupBarrierColor;
  final double dialogMaxWidth;
  final double maxHeight;
  final dropdown_search.DropdownSearchBuilder<T> dropdownBuilder;
  final dropdown_search.DropdownSearchCompareFn<T> compareFn;
  final dropdown_search.DropdownSearchFilterFn<T> filterFn;
  final dropdown_search.DropdownSearchItemAsString<T> itemAsString;
  final dropdown_search.DropdownSearchOnFind<T> onFind;
  final dropdown_search.DropdownSearchPopupItemBuilder<T> popupItemBuilder;
  final dropdown_search.DropdownSearchPopupItemEnabled<T> popupItemDisabled;
  final dropdown_search.ErrorBuilder errorBuilder;
  final dropdown_search.Mode mode;
  final InputDecoration searchBoxDecoration;
  final List<T> items;
  final ShapeBorder popupShape;
  final String hint;
  final T selectedItem;
  final Widget clearButton;
  final Widget dropDownButton;
  final Widget popupTitle;
  final WidgetBuilder emptyBuilder;
  final WidgetBuilder loadingBuilder;

  DecoFormSearchableDropdown({
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
    this.autoValidate = false,
    this.mode = dropdown_search.Mode.DIALOG,
    this.hint,
    this.isFilteredOnline = false,
    this.popupTitle,
    this.selectedItem,
    this.onFind,
    this.dropdownBuilder,
    this.popupItemBuilder,
    this.showSearchBox = true,
    this.showClearButton = false,
    this.searchBoxDecoration,
    this.popupBackgroundColor,
    this.maxHeight,
    this.filterFn,
    this.itemAsString,
    this.showSelectedItem = false,
    this.compareFn,
    this.emptyBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.autoFocusSearchBox = false,
    this.dialogMaxWidth,
    this.clearButton,
    this.dropDownButton,
    this.dropdownBuilderSupportsNullItem = false,
    this.popupShape,
    this.popupItemDisabled,
    this.popupBarrierColor,
  });

  @override
  Widget build(BuildContext context) {
    return DecoFormFieldDecorator(
      child: FormBuilderSearchableDropdown<T>(
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
        autoFocusSearchBox: autoFocusSearchBox,
        autoValidate: autoValidate,
        dropdownBuilderSupportsNullItem: dropdownBuilderSupportsNullItem,
        isFilteredOnline: isFilteredOnline,
        showClearButton: showClearButton,
        showSearchBox: showSearchBox,
        showSelectedItem: showSelectedItem,
        popupBackgroundColor: popupBackgroundColor,
        popupBarrierColor: popupBarrierColor,
        dialogMaxWidth: dialogMaxWidth,
        maxHeight: maxHeight,
        dropdownBuilder: dropdownBuilder,
        compareFn: compareFn,
        filterFn: filterFn,
        itemAsString: itemAsString,
        onFind: onFind,
        popupItemBuilder: popupItemBuilder,
        popupItemDisabled: popupItemDisabled,
        errorBuilder: errorBuilder,
        mode: mode,
        searchBoxDecoration: searchBoxDecoration,
        items: items,
        popupShape: popupShape,
        hint: hint,
        selectedItem: selectedItem,
        clearButton: clearButton,
        dropDownButton: dropDownButton,
        popupTitle: popupTitle,
        emptyBuilder: emptyBuilder,
        loadingBuilder: loadingBuilder,
      ),
    );
  }
}
