import 'package:flutter/foundation.dart';
import 'package:softi_core_module/softi_core_module.dart';

class FirestoreResource<T> extends IResource<T> {
  final String endpoint;
  final Deserializer<T> fromJson;

  FirestoreResource({
    @required this.fromJson,
    this.endpoint,
  });

  @override
  String endpointResolver({
    ResourceRequestType requestType,
    QueryParameters queryParams,
    QueryPagination querypagination,
    String id,
    String dataPath,
    T dataObject,
  }) {
    return endpoint ?? collectionName;
  }

  @override
  T deserializer(Map<String, dynamic> serializedData) {
    return fromJson(serializedData);
  }
}
