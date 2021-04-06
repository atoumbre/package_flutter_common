import 'dart:async';

import 'package:get/get.dart';
import 'package:softi_common/src/core/base_controller.dart';
import 'package:softi_common/src/resource/classes/ResourceRecord.dart';
import 'package:softi_common/src/resource/interfaces/i_resource.dart';

mixin RecordControllerMixin<T extends IResourceData> on BaseViewController {
  @override
  Future<void> loadView() async => initRecord();

  //! Parameters
  String? get id;
  bool get reactive;
  ResourceRecord<T> get resourceRecord;

  //! Getters
  Rx<T?> get record => resourceRecord.data;

  void initRecord() {
    resourceRecord.init(id, reactive: reactive);
  }

  void disposeRecord() {}
}
