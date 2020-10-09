import 'package:softi_common_module/src/controllers/collection_controller.dart';
import 'package:softi_common_module/src/controllers/record_controller.dart';
import 'package:softi_core_module/softi_core_module.dart';

class DatabaseController {
  final ICollectionService _api;
  final Map<dynamic, IResource> _resourceMapper;

  DatabaseController(this._api, this._resourceMapper);

  get api => _api;

  DataCollection<T> collection<T extends IBaseModel>([IResource _res]) {
    return DataCollection<T>(_api, _res ?? _resourceMapper[T]);
  }

  Record<T> record<T extends IBaseModel>(String id, [IResource _res]) {
    return Record<T>(id, _api, _res ?? _resourceMapper[T]);
  }

  //  Transition helper
  String endpointResolver<T extends IBaseModel>([Type doc]) {
    if (_resourceMapper[doc ?? T] == null) {
      throw ('${T.toString()} not registred for endpoint resolution');
    }

    return _resourceMapper[doc ?? T].endpointResolver();
  }

  T deserializer<T extends IBaseModel>(map) {
    return _resourceMapper[T].deserializer(map);
  }

  IResource<T> res<T extends IBaseModel>() {
    return _resourceMapper[T];
  }
}
