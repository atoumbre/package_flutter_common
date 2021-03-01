import 'package:get/get.dart';
import 'package:softi_common/src/resource/classes/ResourceCollection.dart';
import 'package:softi_common/src/resource/classes/query.dart';
import 'package:softi_common/src/resource/interfaces/i_resource.dart';
import 'package:softi_common/src/resource/interfaces/i_collection_service.dart';

class ResourceBase {
  final ICollectionService _api;

  final IResource<T> Function<T>() _resourceResolver;

  ResourceBase(this._resourceResolver, [ICollectionService api]) : _api = api ?? Get.find();

  ResourceCollection<T> collection<T extends IResourceData>([IResource<T> _res]) {
    return ResourceCollection<T>(_api, _res ?? _resourceResolver<T>());
  }

  //  Transition helper

  String endpointResolver<T extends IResourceData>() {
    var res = _resourceResolver<T>();
    return res.endpointResolver();
  }

  T deserializer<T extends IResourceData>(map) {
    return _resourceResolver<T>().deserializer(map);
  }

  // Expose API

  Stream<T> get<T extends IResourceData>(String id, {IResource<T> res, bool reactive}) {
    return _api.get<T>(res ?? _resourceResolver<T>(), id, reactive: reactive);
  }

  Future<T> save<T extends IResourceData>(T record, {IResource<T> res}) {
    return _api.save<T>(res ?? _resourceResolver<T>(), record);
  }

  Future<void> patch<T extends IResourceData>(String id, Map<String, dynamic> values, {IResource<T> res}) {
    return _api.update<T>(res ?? _resourceResolver<T>(), id, values);
  }

  Future<void> delete<T extends IResourceData>(String id, {IResource<T> res}) {
    return _api.delete<T>(res ?? _resourceResolver<T>(), id);
  }

  Stream<QueryResult<T>> find<T extends IResourceData>(
    QueryParameters params, {
    QueryPagination pagination,
    bool reactive = true,
    IResource<T> res,
  }) {
    return _api.find(
      res ?? _resourceResolver<T>(),
      params,
      pagination: pagination,
      reactive: reactive,
    );
  }
}
