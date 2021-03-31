import 'package:softi_common/src/resource/classes/query.dart';

typedef Deserializer<T> = T Function(Map<String, dynamic>);

enum ResourceRequestType { call, find, read, create, replace, update, delete }

abstract class IResource<T> {
  // String get collectionName => T.toString().snakeCase + 's';
  T deserializer(Map<String, dynamic> serializedData);
  String endpointResolver({
    ResourceRequestType requestType,
    QueryParameters queryParams,
    QueryPagination querypagination,
    String dataId,
    String dataPath,
    T dataObject,
  });
}

abstract class IResourceData {
  Map<String, dynamic> toJson();
  String getId();
  String getPath();
  void setId(String newId);
  void setPath(String newPath);
  bool isValid();
}

mixin BaseResourceDataMixin {
  String id;
  String path;
  String getId() => id;
  String getPath() => path;
  void setId(String newId) => id = newId;
  void setPath(String newPath) => path = newPath;
  bool isValid() => (id ?? '') != '';
}
