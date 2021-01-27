import 'package:get/get.dart';
import 'package:softi_common/src/resource/classes/ResourceCollection.dart';
import 'package:softi_common/src/resource/classes/query.dart';
import 'package:softi_common/src/resource/classes/resource.dart';
import 'package:softi_common/src/resource/interfaces/i_collection_service.dart';

class ResourceBase {
  final ICollectionService _api;
  final Map<dynamic, dynamic> _resourceMapper;

  ResourceBase(this._resourceMapper, [ICollectionService api]) : _api = api ?? Get.find();

  ResourceCollection<T> collection<T extends IResourceData>([IResource<T> _res]) {
    return ResourceCollection<T>(_api, _res ?? _resourceMapper[T]);
  }

  // ResourceDAO<T> record<T extends IResourceData>([IResource<T> _res]) {
  //   return ResourceDAO<T>(_api, _res ?? _resourceMapper[T]);
  // }

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

  // Expose API

  Stream<T> get<T extends IResourceData>(String id, {IResource<T> res, bool reactive}) {
    return _api.get<T>(res ?? _resourceMapper[T], id, reactive: reactive);
  }

  Future<T> save<T extends IResourceData>(T record, {IResource<T> res}) {
    return _api.save<T>(res ?? _resourceMapper[T], record);
  }

  Future<void> patch<T extends IResourceData>(String id, Map<String, dynamic> values, {IResource<T> res}) {
    return _api.update<T>(res ?? _resourceMapper[T], id, values);
  }

  Future<void> delete<T extends IResourceData>(String id, {IResource<T> res}) {
    return _api.delete<T>(res ?? _resourceMapper[T], id);
  }

  Stream<QueryResult<T>> find<T extends IResourceData>(
    QueryParameters params, {
    QueryPagination pagination,
    bool reactive = true,
    IResource<T> res,
  }) {
    return _api.find(
      res ?? _resourceMapper[T],
      params,
      pagination: pagination,
      reactive: reactive,
    );
  }
}
