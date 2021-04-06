import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:softi_common/core.dart';
import 'package:softi_common/utils.dart';

mixin FormControllerMixin<T> on BaseController {
  final formKey = GlobalKey<FormBuilderState>();

  Map<String, dynamic>? _initialValue;

  // GETTERS
  Map<String, dynamic>? get initialValue => _initialValue;

  // TO OVERRIDE
  Future<T> beforSave(Map<String, dynamic> formData); // _db.deserializer<T>(formData);
  Future<void> afterSave(T record);
  Map<String, dynamic> buildInitialValue(T record); // => record.toJson();

  // Methods
  void initForm(T editingRecord) {
    _initialValue = buildInitialValue(editingRecord);
  }

  void saveState() {
    formKey.currentState!.save();
  }

  Future<void> save() async {
    toggleLoading();

    try {
      formKey.currentState!.save();

      if (formKey.currentState!.validate()) {
        /// Update record with changes from Form
        var _formResult = mergeMap([initialValue, formKey.currentState!.value]);

        /// Fire onSubmit for additional changes
        var _record = await beforSave(_formResult);

        /// Fire onSave with fresh data for side effect (save data, navigate back ...)
        await afterSave(_record);
      } else {
        print('${T.toString()} Form : validation failed');

        // return false;
      }
    } catch (e) {
      rethrow;
    } finally {
      toggleIdle();
    }
  }

  // UTILITIES
  int valueToInt(String value) => int.parse(value);

  double valueToDouble(String value) => double.parse(value);

  dynamic getFieldValue(String field) {
    var result;
    if (formKey.currentState?.fields == null) {
      result = initialValue![field];
    } else if (formKey.currentState!.fields[field] == null) {
      result = initialValue![field];
    } else {
      result = formKey.currentState!.fields[field]!.value;
    }
    print('$field: $result');
    return result;
  }
}
