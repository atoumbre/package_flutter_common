typedef Deserializer<T> = T Function(Map<String, dynamic>);

enum ResourceRequestType { call, find, read, create, replace, update, delete }

abstract class ApiResource<Q, T> {
  // String get collectionName => T.toString().snakeCase + 's';
  T deserializer(Map<String, dynamic> serializedData);

  //
  String endpointResolver<R>({
    ResourceRequestType requestType,
    R requestObject,
  });

  // Stream<R> call(ResourceRequestType order, Q res, Deserializer<R> deserializer);
}

abstract class ApiResourceEndpoint<QueryPamarmeterType, ResponseType> {
  Stream<ResponseType> call(QueryPamarmeterType res);
}

abstract class IApiResourceData {
  Map<String, dynamic> toJson();
}
