import 'package:softi_core_module/softi_core_module.dart';

class Resource<T> extends IResource<T> {
  final String endpointOveride;
  final Deserializer<T> extenalDeserializer;

  Resource(this.extenalDeserializer, [this.endpointOveride]);

  @override
  String endpointResolver({requestType, queryParam, dataPath, dataObject}) {
    // var _endpoint = prefix + (endpointOveride ?? (T.toString().snakeCase + 's'));
    return endpointOveride ?? collectionName;
  }

  @override
  T deserializer(Map<String, dynamic> serializedData) {
    return extenalDeserializer(serializedData);
  }
}
