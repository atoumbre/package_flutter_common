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
    return ResourceCollection<T>(_api, _resourceResolver<T>());
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
  Stream<QueryResult<T>> find<T extends IResourceData>(
    QueryParameters params, {
    QueryPagination pagination,
    bool reactive = true,
  }) {
    return _api.find(
      _resourceResolver<T>(),
      params,
      pagination: pagination,
      reactive: reactive,
    );
  }

  Stream<T> get<T extends IResourceData>(String id, {bool reactive}) {
    return _api.get<T>(_resourceResolver<T>(), id, reactive: reactive);
  }

  Future<T> save<T extends IResourceData>(T record) {
    return _api.save<T>(_resourceResolver<T>(), record);
  }

  Future<void> patch<T extends IResourceData>(String id, Map<String, dynamic> values) {
    return _api.update<T>(_resourceResolver<T>(), id, values);
  }

  Future<void> delete<T extends IResourceData>(String id) {
    return _api.delete<T>(_resourceResolver<T>(), id);
  }
}
