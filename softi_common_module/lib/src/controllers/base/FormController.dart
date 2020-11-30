// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:get/get.dart';
// import 'package:softi_common_module/src/controllers/app/BaseController.dart';
// import 'package:softi_common_module/src/controllers/db/Database.dart';
// import 'package:softi_core_module/softi_core_module.dart';
// import 'package:logger/logger.dart';
// import 'package:merge_map/merge_map.dart';

// abstract class FormController<T extends IResourceData> extends BaseController {
//   final DatabaseController _db;
//   final INavigationService _nav;
//   final Logger _logger;

//   final bool isEdit;
//   final T record;
//   final GlobalKey<FormBuilderState> formKey = GlobalKey();
//   final Map<String, dynamic> initialValue;

//   FormController(
//     T editingRecord, [
//     Map<String, dynamic> initialValue,
//     INavigationService nav,
//     DatabaseController db,
//     Logger logger,
//   ])  : isEdit = ((editingRecord.getId() ?? '') == ''),
//         initialValue = initialValue ?? editingRecord.toJson(),
//         record = editingRecord,
//         _nav = nav ?? Get.find(),
//         _db = db ?? Get.find(),
//         _logger = logger ?? Get.find();

//   // Map<String, dynamic> buildInitialValue() => record.toJson();

//   Future<T> beforSave(Map<String, dynamic> formData) async => _db.deserializer<T>(formData);

//   Future<void> afterSave(T record) async => record;

//   VoidCallback onCompleted() => () => _nav.back(record);

//   int valueToInt(String value) => int.parse(value);

//   double valueToDouble(String value) => double.parse(value);

//   dynamic getFieldValue(String field) {
//     var result;
//     if (formKey.currentState?.fields == null) {
//       result = initialValue[field];
//     } else if (formKey.currentState.fields[field] == null) {
//       result = initialValue[field];
//     } else {
//       result = formKey.currentState.fields[field].value;
//     }
//     _logger.d('$field: $result');
//     return result;
//   }

//   void saveState() {
//     formKey.currentState.save();
//   }

//   Future<void> save() async {
//     busy.toggle();

//     try {
//       formKey.currentState.save();

//       if (formKey.currentState.validate()) {
//         /// Update record with changes from Form
//         var _formResult = mergeMap([initialValue, formKey.currentState.value]);

//         /// Fire onSubmit for additional changes
//         var _product = await beforSave(_formResult);

//         /// Save to db
//         _product = await _db.save<T>(_product);

//         /// Fire onSave with fresh data for side effect
//         await afterSave(_product);

//         ///
//         onCompleted();
//       } else {
//         _logger.d('${T.toString()} Form : validation failed');

//         return false;
//       }
//     } catch (e) {
//       rethrow;
//     } finally {
//       busy.toggle();
//     }
//   }

//   // uploadImages(String productId, List<File> images) async {
//   //   ///
//   //   int i = 0;
//   //   images.map<Future<RemoteImage>>((imageFile) async {
//   //     i++;
//   //     final _uploadResult = await CS.cloudStorage.uploadImage(
//   //       imageToUpload: imageFile,
//   //       title: 'products/$productId/$i',
//   //     );
//   //     return RemoteImage(
//   //       url: _uploadResult.imageUrl,
//   //       title: _uploadResult.imageFileName,
//   //     );
//   //   });
//   // }
// }
