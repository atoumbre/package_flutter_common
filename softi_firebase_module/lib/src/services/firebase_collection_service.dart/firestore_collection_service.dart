import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:softi_core_module/softi_core_module.dart';
import 'package:softi_firebase_module/src/services/firebase_collection_service.dart/firebase_desirializer.dart';
import 'package:softi_firebase_module/src/services/firebase_collection_service.dart/firebase_resource.dart';

export 'package:softi_firebase_module/src/services/firebase_collection_service.dart/firebase_resource.dart';

class FirestoreCollectionService extends ICollectionService {
  FirestoreCollectionService(
    this._firestoreInstance,
  );

  final FirebaseFirestore _firestoreInstance;

  CollectionReference _getRef<T extends IResourceData>(Resource<T> res) {
    return _firestoreInstance.collection(res.endpointResolver());
  }

  Future<Stream<QueryResult<T>>> streamData<T extends IResourceData>(
    IResource<T> res,
    QueryParam queryParams, {
    int limit = 10,
    dynamic cursor,
    int skip,
    bool watch = true,
  }) async {
    var _query = _firestoreQueryBuilder(
      _getRef<T>(res),
      queryParam: queryParams,
      limit: limit,
      cursor: cursor,
    );

    var _querySnapshot = _query.snapshots();

    return _querySnapshot.map<QueryResult<T>>(
      (snapshot) {
        var data = snapshot.docs
            //! Filter possible here
            .map<T>((doc) => fromFirestore<T>(res, doc))
            .toList();

        var changes = snapshot.docChanges
            //! Filter possible here
            .map((DocumentChange docChange) => Change<T>(
                  document: fromFirestore<T>(res, docChange.doc),
                  oldIndex: docChange.oldIndex,
                  newIndex: docChange.newIndex,
                  type: {
                    DocumentChangeType.added: ChangeType.added,
                    DocumentChangeType.modified: ChangeType.modified,
                    DocumentChangeType.removed: ChangeType.removed,
                  }[docChange.type],
                ))
            .toList();

        return QueryResult<T>(
          data,
          changes,
          cursor: snapshot.docs.length > 0 ? snapshot.docs.last : null,
        );
      },
    );
  }

  // Check if record exsits
  Future<bool> exists<T extends IResourceData>(IResource<T> res, String recordId) async {
    return (await _getRef<T>(res).doc(recordId).snapshots().first).exists;
  }

  // Stream documenent from db
  Stream<T> get<T extends IResourceData>(IResource<T> res, String recordId, {bool watch = true}) {
    return _getRef<T>(res).doc(recordId).snapshots().map<T>((snapshot) => fromFirestore<T>(res, snapshot));
  }

  Future<void> update<T extends IResourceData>(IResource<T> res, String id, Map<String, dynamic> values) async {
    DocumentReference docRef = _getRef<T>(res).doc(id);

    await docRef.set(firestireMap(values, false), SetOptions(merge: true));
  }

  Future<T> save<T extends IResourceData>(IResource<T> res, T doc, {refresh = false}) async {
    String id = doc.getId() ?? '';

    DocumentReference docRef;
    if (id == '') {
      docRef = await _getRef<T>(res).add(toFirestore(doc));
    } else {
      docRef = _getRef<T>(res).doc(id);
      await docRef.set(toFirestore(doc), SetOptions(merge: false));
    }

    if (refresh)
      return fromFirestore<T>(res, await docRef.snapshots().first);
    else
      return doc;
  }

  Future<void> delete<T extends IResourceData>(IResource<T> res, String documentId) async {
    await _getRef<T>(res).doc(documentId).delete();
  }

  /// Internala fmethodes
  Query _firestoreQueryBuilder(
    CollectionReference ref, {
    QueryParam queryParam,
    dynamic cursor,
    int limit = 50,
  }) {
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

    // _query = _query.orderBy(FieldPath.documentId);

    // Get the last Document
    if (cursor != null) {
      _query = _query.startAfterDocument(cursor);
    }

    _query = _query.limit(limit);

    return _query;
  }
}
