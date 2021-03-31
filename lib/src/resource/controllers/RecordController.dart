import 'package:softi_common/src/core/base_controller.dart';
import 'package:softi_common/src/resource/classes/ResourceBase.dart';
import 'package:softi_common/src/resource/controllers/RecordControllerMixin.dart';
import 'package:softi_common/src/resource/interfaces/i_resource.dart';

class RecordController<T extends IResourceData> extends BaseViewController with RecordControllerMixin<T> {
  @override
  final String recordId;

  @override
  final bool reactive;

  @override
  final ResourceBase resourceBase;

  RecordController(
    this.recordId,
    this.resourceBase, {
    this.reactive = true,
  });

  @override
  Future<void> loadView() async => initRecord();

  @override
  Future<void> disposeView() async => initRecord();
}
