import 'package:softi_common_module/src/controllers/collection_controller.dart';
import 'package:softi_common_module/src/controllers/record_controller.dart';
import 'package:softi_core_module/softi_core_module.dart';

class DatabaseController {
  final ICollectionService _api;

  DatabaseController(this._api);

  get api => _api;

  DataCollection<T> collection<T extends IBaseModel>() {
    return DataCollection<T>(_api);
  }

  Record<T> record<T extends IBaseModel>(String id) {
    return Record<T>(id, _api);
  }
}
