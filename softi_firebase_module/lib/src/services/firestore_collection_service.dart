import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:softi_core_module/softi_core_module.dart';

class FirestoreCollectionService implements ICollectionService {
  FirestoreCollectionService(this._firestoreInstance, this.collectionName, this.fromJson);

  final FirebaseFirestore _firestoreInstance;

  final String Function<T extends IBaseModel>([T doc]) collectionName;
  final T Function<T extends IBaseModel>(Map<String, Object>) fromJson;

  CollectionReference _getRef(String path) => _firestoreInstance.collection(path);

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
    int limit,
    String lastId,
    int skip,
  }) async {
    var _query = await _firestoreQueryBuilder(
      _getRef(collectionName<T>()),
      queryParam: queryParams,
      limit: limit,
      lastId: lastId,
    );

    var _querySnapshot = _query.snapshots();

    return _querySnapshot.map<QueryResult<T>>(
      (snapshot) {
        var data = snapshot.docs
            //! Filter possible here
            // .where((mappedItem) => mappedItem.name != null)
            .map<T>((doc) => _fromFirestore<T>(doc))
            .toList();

        var changes = snapshot.docChanges
            //! Filter possible here
            // .where((mappedItem) => mappedItem.name != null)
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

//TODO(atoumbre): Manage optimistic response for second read
  Future<T> add<T extends IBaseModel>(T doc, {refresh = false}) async {
    DocumentReference docRef = await _getRef(collectionName<T>()).add(_toFirestore(doc));
    // return refresh ? _fromFirestore<T>(await docRef.get()) : Future.value(doc..setId(docRef.documentID));

    return _fromFirestore<T>(await docRef.snapshots().first);
  }

  @override
  Future<bool> exists<T extends IBaseModel>(String id) async {
    return (await _getRef(collectionName<T>()).doc(id).snapshots().first).exists;
  }

  Future<T> update<T extends IBaseModel>(T doc, {refresh = false}) async {
    DocumentReference docRef = _getRef(collectionName<T>()).doc(doc.getId())
      ..set(
        _toFirestore(doc),
        SetOptions(merge: true),
      );
    await docRef.update(_toFirestore(doc));
    return refresh ? _fromFirestore<T>(await docRef.snapshots().first) : Future.value(doc);
  }

  Future<T> delete<T extends IBaseModel>(String documentId) async {
    T deletedDoc = await get<T>(documentId);
    if (deletedDoc != null) {
      await _getRef(collectionName<T>()).doc(documentId).delete();
    }
    return deletedDoc;
  }

  // Get documenent from db
  Future<T> get<T extends IBaseModel>(String recordId) async {
    DocumentSnapshot snapshot = await _getRef(collectionName<T>()).doc(recordId).snapshots().first;
    if (snapshot.exists) {
      return _fromFirestore<T>(snapshot);
    } else {
      return null;
    }
  }

  // Stream documenent from db
  Stream<T> stream<T extends IBaseModel>(String recordId) {
    return _getRef(collectionName<T>()).doc(recordId).snapshots().map<T>((snapshot) => _fromFirestore<T>(snapshot));
  }

  /// Internala fmethodes
  Future<Query> _firestoreQueryBuilder(CollectionReference ref,
      {QueryParam queryParam, String lastId, int limit}) async {
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

    dynamic _result = fromJson<T>({
      'id': docSnap.id,
      'path': docSnap.reference.path,
      ..._map,
    });

    return _result as T;
  }

  Map<String, dynamic> _toFirestore(IBaseModel doc) {
    Map<String, dynamic> map = doc.toJson();
    if (map == null) return null;

    Map<String, dynamic> _map = _firestireMap(map, false);
    if (_map == null) return null;

    return _map;
  }

  Map<String, dynamic> _firestireMap(Map<String, dynamic> input, bool fromJson, [bool skipNull = true]) {
    Map<String, dynamic> result = {};

    input.forEach((k, v) {
      if (skipNull && v == null)
        return;
      else if (v is Map)
        result[k] = _firestireMap(v, fromJson);
      else if (v is List)
        result[k] = _firestireList(v, fromJson);
      else
        result[k] = _firestoreTransform(v, fromJson);
    });
    return result;
  }

  List _firestireList(List input, bool fromJson, [bool skipNull = true]) {
    List result = [];

    input.forEach((v) {
      if (skipNull && v == null)
        return;
      else if (v is Map)
        result.add(_firestireMap(v, fromJson));
      else if (v is List)
        result.add(_firestireList(v, fromJson));
      else
        result.add(_firestoreTransform(v, fromJson));
    });

    return result;
  }

  dynamic _firestoreTransform(dynamic v, bool fromJson) {
    if (fromJson) {
      //FROM FIRESTORE

      if (v is Timestamp)
        return v.toDate();
      else if (v is DocumentReference)
        return {'id': v.id, 'path': v.path};
      else
        return v;
    } else {
      // TO FIRESTORE

      if (v is DateTime)
        return Timestamp.fromDate(v);
      else if (v is Reference)
        return FirebaseFirestore.instance.collection(collectionName(v.data)).doc(v.id);
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
