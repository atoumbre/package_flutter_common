import 'package:softi_core_module/index.dart';
import 'package:softi_resource_module/src/classes/ResourceRecord.dart';
import 'package:softi_resource_module/src/classes/resource.dart';
import 'package:softi_resource_module/src/classes/ResourceBase.dart';

abstract class BaseRecordController<T extends IResourceData> extends BaseController {
  BaseRecordController(this.intialData, [ResourceBase db]) : record = db.record<T>();

  final DataRecord<T> record;
  final T intialData;

  Future<void> init() {
    return record.init(intialData);
  }

  @override
  Future<void> onReady() {
    super.onReady();
    return init();
  }
}
