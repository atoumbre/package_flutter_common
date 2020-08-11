abstract class IBaseModel {
  Map<String, dynamic> toJson();
  String getId();
  // String getPath();
  bool isValid();
}

mixin BaseModelMixin {
  String id;
  // String path;

  String getId() => id;

  // String getPath() => path;
  bool isValid() => true;

  // Map<String, dynamic> toJson() => super.toJson();
}

class Reference<T extends IBaseModel> {
  Reference({this.id, this.data, this.fetch});

  final String id;
  final T data;
  final T Function() fetch;

  T getData() {
    if (fetch != null) return fetch();
    return null;
  }
}

class Resource<T extends IBaseModel> {
  Resource({this.id, this.data, this.fetch});

  final String id;
  final T data;
  final T Function() fetch;

  T getData() {
    if (fetch != null) return fetch();
    return null;
  }
}
