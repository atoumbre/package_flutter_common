import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:softi_core_module/src/interfaces/i_base_service.dart';
import 'package:softi_core_module/src/models/base_model.dart';

abstract class ICollectionService extends IBaseService {
  Future<QueryResult<T>> getData<T extends IBaseModel>(
    QueryParam queryParams, {
    String lastId,
    int skip,
    int limit,
  });

  Future<Stream<QueryResult<T>>> streamData<T extends IBaseModel>(
    QueryParam queryParams, {
    String lastId,
    int skip,
    int limit = 10,
  });

  Future<T> get<T extends IBaseModel>(String id);
  Stream<T> stream<T extends IBaseModel>(String id);
  Future<bool> exists<T extends IBaseModel>(String id);
  Future<T> save<T extends IBaseModel>(T record, {refresh = false});
  Future<void> update<T extends IBaseModel>(String id, Map<String, dynamic> values);
  Future<void> delete<T extends IBaseModel>(String id);
}

class QueryResult<T extends IBaseModel> {
  final List<T> data;
  final List<Change<T>> changes;

  List<T> call() => data;

  QueryResult(this.data, this.changes);
}

// class Res<T extends IBaseModel> {
//   int code;
//   String message;
//   T data;

//   Res({this.code, this.message, this.data});
// }

// class ResList<T extends IBaseModel> {
//   int code;
//   String message;
//   List<T> dataList;

//   ResList({this.code, this.message, this.dataList});
// }

class Change<T extends IBaseModel> {
  T document;
  int oldIndex;
  int newIndex;
  ChangeType type;

  Change({
    this.oldIndex,
    this.newIndex,
    this.document,
    this.type,
  });
}

class QueryFilter {
  QueryFilter({
    this.field,
    this.condition,
    this.value,
  });
  final String field;
  final QueryOperator condition;
  final dynamic value;
}

class QuerySort {
  QuerySort(this.field, {this.desc = false});
  final String field;
  final bool desc;
}

class QueryParam {
  QueryParam({
    @required this.sortList,
    this.filterList,
  });

  final List<QuerySort> sortList;
  final List<QueryFilter> filterList;
}

enum QueryOperator {
  equal,
  greaterThan,
  greaterThanOrEqualTo,
  lessThan,
  lessThanOrEqualTo,
  isIn,
  arrayContains,
  arrayContainsAny,
}

enum ChangeType {
  /// Indicates a new document was added to the set of documents matching the query.
  added,

  /// Indicates a document within the query was modified.
  modified,

  /// Indicates a document within the query was removed (either deleted or no longer matches the query.
  removed,
}
