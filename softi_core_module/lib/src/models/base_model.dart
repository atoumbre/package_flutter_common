abstract class IBaseModel {
  Map<String, dynamic> toJson();
  String getId();
  bool isValid();
}

mixin BaseModelMixin {
  String id;
  String getId() => id;
  bool isValid() => (id ?? '' != '');
  void setId(String newId) => id = newId;
}
