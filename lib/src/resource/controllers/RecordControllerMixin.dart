import 'dart:async';

import 'package:get/get.dart';
import 'package:softi_common/src/core/base_controller.dart';
import 'package:softi_common/src/resource/classes/ResourceBase.dart';
import 'package:softi_common/src/resource/interfaces/i_resource.dart';

mixin RecordControllerMixin<T extends IResourceData> on BaseController {
  String get recordId;
  bool get reactive;
  ResourceBase get resourceBase;

  final Rx<T> _rxRecord = Rx<T>();
  StreamSubscription _sub;

  void initRecord() {
    _sub = resourceBase.get<T>(recordId, reactive: reactive).listen((recordEvent) {
      _rxRecord(recordEvent);
    });
  }

  void disposeRecord() {
    _sub.cancel();
  }

  Rx<T> get record => _rxRecord;
}
