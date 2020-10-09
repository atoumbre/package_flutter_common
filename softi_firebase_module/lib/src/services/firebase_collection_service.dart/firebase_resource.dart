import 'package:softi_core_module/softi_core_module.dart';

class Resource<T> extends IResource<T> {
  final String endpointOveride;
  final Deserializer<T> deserializerOveride;
  final T instanceOveride;

  Resource(this.deserializerOveride, this.instanceOveride, [this.endpointOveride]);

  @override
  String endpointResolver({requestType, queryParam, dataPath, dataObject}) {
    // var _endpoint = prefix + (endpointOveride ?? (T.toString().snakeCase + 's'));
    return endpointOveride ?? collectionName;
  }

  @override
  T deserializer(Map<String, dynamic> serializedData) {
    return deserializerOveride(serializedData);
  }

  @override
  T get defautInstance => throw UnimplementedError();
}
