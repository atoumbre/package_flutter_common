import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:softi_resource_module/index.dart';
import 'package:softi_core_module/index.dart';

import 'package:merge_map/merge_map.dart';

abstract class FormController<T extends IResourceData> extends BaseController {
  final DatabaseController _db;

  final bool isEdit;
  final T record;
  final GlobalKey<FormBuilderState> formKey = GlobalKey();
  final Map<String, dynamic> initialValue;

  FormController(
    T editingRecord, [
    Map<String, dynamic> initialValue,
    DatabaseController db,
  ])  : isEdit = ((editingRecord.getId() ?? '') == ''),
        initialValue = initialValue ?? editingRecord.toJson(),
        record = editingRecord,
        _db = db ?? Get.find();

  Future<T> beforSave(Map<String, dynamic> formData) async => _db.deserializer<T>(formData);

  Future<void> afterSave(T record) async => record;

  VoidCallback onCompleted();

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
    busy.toggle();

    try {
      formKey.currentState.save();

      if (formKey.currentState.validate()) {
        /// Update record with changes from Form
        var _formResult = mergeMap([initialValue, formKey.currentState.value]);

        /// Fire onSubmit for additional changes
        var _product = await beforSave(_formResult);

        /// Save to db
        _product = await _db.save<T>(_product);

        /// Fire onSave with fresh data for side effect
        await afterSave(_product);

        ///
        onCompleted();
      } else {
        print('${T.toString()} Form : validation failed');

        return false;
      }
    } catch (e) {
      rethrow;
    } finally {
      busy.toggle();
    }
  }
}
