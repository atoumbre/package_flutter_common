import 'package:get/get.dart';
import 'package:softi_common/src/core/base_controller.dart';
import 'package:softi_common/src/resource/classes/ResourceBase.dart';
import 'package:softi_common/src/resource/controllers/RecordControllerMixin.dart';
import 'package:softi_common/src/resource/interfaces/i_resource.dart';

class RecordController<T extends IResourceData> extends BaseController with RecordControllerMixin<T> {
  @override
  final String recordId;
  @override
  final bool reactive;

  @override
  final ResourceBase resourceBase;

  RecordController(
    this.recordId, {
    ResourceBase resourceBase,
    this.reactive = true,
  }) : resourceBase = resourceBase ?? Get.find<ResourceBase>();

  @override
  void onInit() {
    initRecord();
    super.onInit();
  }

  @override
  void onClose() {
    disposeRecord();
    super.onClose();
  }
}
