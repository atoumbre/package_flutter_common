import 'package:softi_common/src/core/BaseController.dart';
import 'package:softi_common/src/resource/classes/ResourceRecord.dart';
import 'package:softi_common/src/resource/controllers/RecordControllerMixin.dart';
import 'package:softi_common/src/resource/interfaces/i_resource.dart';

class RecordController<T extends IResourceData> extends BaseViewController with RecordControllerMixin<T> {
  @override
  // ignore: must_call_super
  Future<void> onViewInit() async => initRecord();

  @override
  // ignore: must_call_super
  Future<void> onViewClose() async => disposeRecord();

  @override
  final String id;

  @override
  final bool reactive;

  @override
  final ResourceRecord<T> resourceRecord;

  RecordController(
    this.resourceRecord, {
    this.id = '',
    this.reactive = true,
  });
}
