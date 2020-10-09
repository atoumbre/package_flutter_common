import 'package:softi_common_module/src/controllers/collection_controller.dart';
import 'package:softi_common_module/src/controllers/record_controller.dart';
import 'package:softi_core_module/softi_core_module.dart';

class DatabaseController {
  final ICollectionService _api;
  final Map<dynamic, IResource> _resourceMapper;

  DatabaseController(this._api, this._resourceMapper);

  get api => _api;

  DataCollection<T> collection<T extends IResourceData>([IResource _res]) {
    return DataCollection<T>(_api, _res ?? _resourceMapper[T]);
  }

  Record<T> record<T extends IResourceData>(T id, [IResource _res]) {
    return Record<T>(_api, _res ?? _resourceMapper[T]);
  }

  //  Transition helper
  String endpointResolver<T extends IResourceData>([Type doc]) {
    if (_resourceMapper[doc ?? T] == null) {
      throw ('${T.toString()} not registred for endpoint resolution');
    }

    return _resourceMapper[doc ?? T].endpointResolver();
  }

  T deserializer<T extends IResourceData>(map) {
    return _resourceMapper[T].deserializer(map);
  }

  IResource<T> res<T extends IResourceData>() {
    return _resourceMapper[T];
  }
}
