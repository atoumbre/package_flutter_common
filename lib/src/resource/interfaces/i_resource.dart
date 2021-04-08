typedef Deserializer<T> = T Function(Map<String, dynamic>);

enum ResourceRequestType { call, find, read, create, replace, update, delete }

abstract class IResource<T extends IResourceData?> {
  String _endpoint;
  IResource(String endpoint) : _endpoint = endpoint;

  String get endpoint => _endpoint;

  T deserializer(Map<String, dynamic> serializedData);

  IResource<T> setEndpoint(String newEndpoint) {
    _endpoint = newEndpoint;
    return this;
  }
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
  String? id;
  String? path;
  String getId() => id ?? '';
  String getPath() => path ?? '';
  void setId(String newId) => id = newId;
  void setPath(String newPath) => path = newPath;
  bool isValid() => (id ?? '') != '';
}
