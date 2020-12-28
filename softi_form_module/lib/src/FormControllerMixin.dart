import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:merge_map/merge_map.dart';
import 'package:softi_core_module/index.dart';
import 'package:softi_resource_module/index.dart';

mixin FormControllerMixin<T extends IResourceData> on BaseController {
  final formKey = GlobalKey<FormBuilderState>();

  T _record;
  ResourceBase _db;
  bool _isEdit;

  Map<String, dynamic> get initialValue => buildInitialValue(_record);
  bool get isEdit => _isEdit;

  void initForm(T editingRecord, ResourceBase db) {
    _isEdit = ((editingRecord.getId() ?? '') == '');
    _record = editingRecord;
    _db = db;
  }

  // TO OVERRIDE
  // void onCompleted() => Get.back();
  Future<T> beforSave(Map<String, dynamic> formData) async => _db.deserializer<T>(formData);

  Future<void> afterSave(T record); // async => record;

  Map<String, dynamic> buildInitialValue(T record) => record.toJson();

  // Utlities
  int valueToInt(String value) => int.parse(value);

  double valueToDouble(String value) => double.parse(value);

  dynamic getFieldValue(String field) {
    var result;
    if (formKey.currentState?.fields == null) {
      result = initialValue[field];
    } else if (formKey.currentState.fields[field] == null) {
      result = initialValue[field];
    } else {
      result = formKey.currentState.fields[field].value;
    }
    print('$field: $result');
    return result;
  }

  void saveState() {
    formKey.currentState.save();
  }

  Future<void> save() async {
    busy(true);

    try {
      formKey.currentState.save();

      if (formKey.currentState.validate()) {
        /// Update record with changes from Form
        var _formResult = mergeMap([initialValue, formKey.currentState.value]);

        /// Fire onSubmit for additional changes
        var _record = await beforSave(_formResult);

        /// Save to db
        _record = await _db.save<T>(_record);

        /// Fire onSave with fresh data for side effect
        await afterSave(_record);
      } else {
        print('${T.toString()} Form : validation failed');

        return false;
      }
    } catch (e) {
      rethrow;
    } finally {
      busy(false);
    }
  }
}
