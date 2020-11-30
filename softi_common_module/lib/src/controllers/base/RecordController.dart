import 'package:softi_common_module/src/controllers/db/DataRecord.dart';
import 'package:softi_common_module/src/controllers/db/Database.dart';
import 'package:softi_core_module/softi_core_module.dart';

import '../BaseController.dart';

abstract class DataRecordController<T extends IResourceData> extends BaseController {
  DataRecordController(this.intialData, [DatabaseController db]) : record = db.record<T>();

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
