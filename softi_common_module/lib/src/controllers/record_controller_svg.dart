// import 'dart:async';

// import 'package:softi_core_module/softi_core_module.dart';

// class Record<T extends IResourceData> {
//   Record(this._api, this._res);

//   // Record.doc(T doc, this._api, this._res) : _id = doc.getId();
//   // Record.id(T doc, this._api, this._res) : _id = doc.getId();

//   final ICollectionService _api;
//   final IResource<T> _res;

//   bool _exist;
//   T _data;
//   String _id;

//   Record<T> id(String id) {
//     _id = id;
//     return this;
//   }

//   /// Methods
//   Future<T> fetch([String newId, bool realtime = true]) async {
//     if (newId != null) _id = newId;
//     _data = await _api.get<T>(_res, _id).first;
//     _exist = _data != null;
//     return _data;
//   }

//   Future<T> save([T newData]) async {
//     return _api.save<T>(_res, newData);
//   }

//   Future<void> delete() async {
//     await _api.delete<T>(_res, _id);
//     _exist = false;
//   }

//   /// Getters
//   Future<bool> get exist async {
//     if (_exist == null) _exist = await _api.exists<T>(_res, _id);
//     return Future.value(_exist);
//   }

//   T call([T newData]) {
//     if (newData != null) _data = newData;
//     return _data;
//   }
// }
