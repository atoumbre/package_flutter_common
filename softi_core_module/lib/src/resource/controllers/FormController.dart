import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:merge_map/merge_map.dart';
import 'package:softi_core_module/core.dart';
import 'package:softi_core_module/src/resource/classes/ResourceBase.dart';
import 'package:softi_core_module/src/resource/classes/resource.dart';

abstract class FormController<T extends IResourceData> extends BaseController {
  final ResourceBase db;
  final bool isEdit;
  final T record;
  final GlobalKey<FormBuilderState> formKey = GlobalKey();
  final Map<String, dynamic> _initialValue;

  Map<String, dynamic> get initialValue => _initialValue ?? buildInitialValue(record);

  FormController(
    T editingRecord,
    this.db, [
    Map<String, dynamic> initialValue,
  ])  : isEdit = ((editingRecord.getId() ?? '') == ''),
        _initialValue = initialValue,
        record = editingRecord;

  void onCompleted() => Get.back();

  Future<T> beforSave(Map<String, dynamic> formData) async => db.deserializer<T>(formData);

  Future<void> afterSave(T record) async => record;

  Map<String, dynamic> buildInitialValue(T record) => record.toJson();

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
        var _record = await beforSave(_formResult);

        /// Save to db
        _record = await db.save<T>(_record);

        /// Fire onSave with fresh data for side effect
        await afterSave(_record);

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
