import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:softi_core_module/softi_core_module.dart';

class FirestoreCollectionService implements ICollectionService {
  FirestoreCollectionService(
    this._firestoreInstance,
    this.endpointResolver,
    this.deserializer,
  );

  final FirebaseFirestore _firestoreInstance;
  final String Function<T extends IBaseModel>([Type type]) endpointResolver;
  final T Function<T extends IBaseModel>(Map<String, Object>) deserializer;

  CollectionReference _getRef<T extends IBaseModel>([Type type]) {
    return _firestoreInstance.collection(endpointResolver<T>(type));
  }

  Future<QueryResult<T>> getData<T extends IBaseModel>(
    QueryParam queryParams, {
    int limit,
    String lastId,
    int skip,
  }) async {
    var _resultStream = (await streamData(
      queryParams,
      limit: limit,
      lastId: lastId,
      skip: skip,
    ));

    return _resultStream.first;
  }

  Future<Stream<QueryResult<T>>> streamData<T extends IBaseModel>(
    QueryParam queryParams, {
    int limit = 10,
    String lastId,
    int skip,
  }) async {
    var _query = await _firestoreQueryBuilder(
      _getRef<T>(),
      queryParam: queryParams,
      limit: limit,
      lastId: lastId,
    );

    var _querySnapshot = _query.snapshots();

    return _querySnapshot.map<QueryResult<T>>(
      (snapshot) {
        var data = snapshot.docs
            //! Filter possible here
            .map<T>((doc) => _fromFirestore<T>(doc))
            .toList();

        var changes = snapshot.docChanges
            //! Filter possible here
            .map((DocumentChange docChange) => Change<T>(
                  document: _fromFirestore<T>(docChange.doc),
                  oldIndex: docChange.oldIndex,
                  newIndex: docChange.newIndex,
                  type: _firestoreEntityChangeMapper[docChange.type],
                ))
            .toList();

        return QueryResult<T>(data, changes);
      },
    );
  }

  @override
  Future<bool> exists<T extends IBaseModel>(String recordId) async {
    return (await _getRef<T>().doc(recordId).snapshots().first).exists;
  }

  // Get documenent from db
  Future<T> get<T extends IBaseModel>(String recordId) async {
    return stream<T>(recordId).first;
  }

  // Stream documenent from db
  Stream<T> stream<T extends IBaseModel>(String recordId) {
    return _getRef<T>().doc(recordId).snapshots().map<T>((snapshot) => _fromFirestore<T>(snapshot));
  }

  Future<void> update<T extends IBaseModel>(String id, Map<String, dynamic> values) async {
    DocumentReference docRef = _getRef<T>().doc(id);

    await docRef.set(_firestireMap(values, false), SetOptions(merge: true));
  }

  Future<T> save<T extends IBaseModel>(T doc, {refresh = false}) async {
    String id = doc.getId() ?? '';
    DocumentReference docRef;
    if (id == '') {
      docRef = await _getRef<T>().add(_toFirestore(doc));
      return _fromFirestore<T>(await docRef.snapshots().first);
    } else {
      docRef = _getRef<T>().doc(id);
      await docRef.set(_toFirestore(doc), SetOptions(merge: true));
      return refresh ? _fromFirestore<T>(await docRef.snapshots().first) : Future.value(doc);
    }
  }

  Future<void> delete<T extends IBaseModel>(String documentId) async {
    await _getRef<T>().doc(documentId).delete();
  }

  /// Internala fmethodes
  Future<Query> _firestoreQueryBuilder(CollectionReference ref,
      {QueryParam queryParam, String lastId, int limit = 50}) async {
    Query _query = ref;

    if (queryParam?.filterList != null)
      queryParam.filterList.forEach((where) {
        switch (where.condition) {
          case QueryOperator.equal:
            _query = _query.where(where.field, isEqualTo: where.value);
            break;
          case QueryOperator.greaterThanOrEqualTo:
            _query = _query.where(where.field, isGreaterThanOrEqualTo: where.value);
            break;
          case QueryOperator.greaterThan:
            _query = _query.where(where.field, isGreaterThan: where.value);
            break;
          case QueryOperator.lessThan:
            _query = _query.where(where.field, isLessThan: where.value);
            break;
          case QueryOperator.lessThanOrEqualTo:
            _query = _query.where(where.field, isLessThanOrEqualTo: where.value);
            break;
          case QueryOperator.isIn:
            _query = _query.where(where.field, whereIn: where.value);
            break;
          case QueryOperator.arrayContains:
            _query = _query.where(where.field, arrayContains: where.value);
            break;
          case QueryOperator.arrayContainsAny:
            _query = _query.where(where.field, arrayContainsAny: where.value);
            break;
          default:
        }
      });

    // Set orderBy
    if (queryParam?.sortList != null)
      queryParam.sortList.forEach((orderBy) {
        _query = _query.orderBy(orderBy.field, descending: orderBy.desc);
      });

    // Get the last Document
    if (lastId != null) {
      _query = _query.startAfterDocument(await ref.doc(lastId).get(GetOptions(source: Source.cache)));
    }

    _query = _query.limit(limit);

    return _query;
  }

  T _fromFirestore<T extends IBaseModel>(DocumentSnapshot docSnap) {
    Map<String, dynamic> map = docSnap.data();
    if (map == null) return null;

    Map<String, dynamic> _map = _firestireMap(map, true);
    if (_map == null) return null;

    T _result = deserializer<T>({
      'id': docSnap.id,
      ..._map,
    });

    return _result;
  }

  Map<String, dynamic> _toFirestore(IBaseModel doc) {
    Map<String, dynamic> map = doc.toJson();
    if (map == null) return null;

    Map<String, dynamic> _map = _firestireMap(map, false);
    if (_map == null) return null;

    return _map;
  }

  Map<String, dynamic> _firestireMap(Map<String, dynamic> input, bool fromFirestore, [bool skipNull = true]) {
    Map<String, dynamic> result = {};

    input.forEach((k, v) {
      if (skipNull && v == null)
        return;
      else if (v is Map)
        result[k] = _firestireMap(v, fromFirestore);
      else if (v is List)
        result[k] = _firestireList(v, fromFirestore);
      else
        result[k] = _firestoreTransform(v, fromFirestore);
    });
    return result;
  }

  List _firestireList(List input, bool fromFirestore, [bool skipNull = true]) {
    List result = [];

    input.forEach((v) {
      if (skipNull && v == null)
        return;
      else if (v is Map)
        result.add(_firestireMap(v, fromFirestore));
      else if (v is List)
        result.add(_firestireList(v, fromFirestore));
      else
        result.add(_firestoreTransform(v, fromFirestore));
    });

    return result;
  }

  dynamic _firestoreTransform(dynamic v, bool fromFirestore) {
    if (fromFirestore) {
      //FROM FIRESTORE

      if (v is Timestamp)
        return v.toDate();
      else if (v is DocumentReference)
        return v.id;
      else
        return v;
    } else {
      // TO FIRESTORE

      if (v is DateTime)
        return Timestamp.fromDate(v);
      else
        return v;
    }
  }

  Map _firestoreEntityChangeMapper = {
    DocumentChangeType.added: ChangeType.added,
    DocumentChangeType.modified: ChangeType.modified,
    DocumentChangeType.removed: ChangeType.removed,
  };
}
