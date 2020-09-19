abstract class IBaseModel {
  Map<String, dynamic> toJson();
  String getId();
  bool isValid();
}

mixin BaseModelMixin {
  String id;
  String getId() => id;
  bool isValid() => (id ?? '' != ''); //(endpoint ?? '' != '') &&
}

// class Reference<T extends IBaseModel> {
//   Reference({this.id, this.fetcher});

//   final String id;
//   final Future<T> Function() fetcher;

//   T _data;

//   Type get type => T;
//   T get data => _data;

//   T fetch() => _data = fetcher != null ? await fetcher() : null;
// }
