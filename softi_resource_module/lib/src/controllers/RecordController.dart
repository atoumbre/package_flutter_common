import 'package:softi_resource_module/src/classes/DataRecord.dart';
import 'package:softi_resource_module/src/classes/Database.dart';
import 'package:softi_resource_module/src/classes/resource.dart';
import 'package:softi_core_module/index.dart';

abstract class BaseRecordController<T extends IResourceData> extends BaseController {
  BaseRecordController(this.intialData, [DatabaseController db]) : record = db.record<T>();

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
