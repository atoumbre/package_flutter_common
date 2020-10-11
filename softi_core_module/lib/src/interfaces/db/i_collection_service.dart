import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:recase/recase.dart';
import 'package:softi_core_module/src/interfaces/i_base_service.dart';

typedef Deserializer<T> = T Function(Map<String, dynamic>);

enum ResourceRequestType { list, read, create, replace, update, delete }

abstract class IResource<T> {
  String get collectionName => T.toString().snakeCase + 's';
  T deserializer(Map<String, dynamic> serializedData);
  String endpointResolver({
    ResourceRequestType requestType,
    QueryParameters queryParams,
    QueryPagination querypagination,
    String id,
    String dataPath,
    T dataObject,
  });
}

abstract class IResourceData {
  Map<String, dynamic> toJson();
  String getId();
  String getPath();
  bool isValid();
}

mixin BaseResourceDataMixin {
  String id;
  String path;
  String getId() => id;
  String getPath() => path;
  bool isValid() => (id ?? '' != '');
}

abstract class ICollectionService extends IBaseService {
  Future<Stream<QueryResult<T>>> find<T extends IResourceData>(
    IResource<T> res,
    QueryParameters queryParams, {
    QueryPagination pagination,
    bool reactive = true,
  });

  Stream<T> get<T extends IResourceData>(IResource<T> res, String id, {bool reactive = true});
  Future<bool> exists<T extends IResourceData>(IResource<T> res, String id);
  Future<T> save<T extends IResourceData>(IResource<T> res, T record, {bool refresh = false});
  Future<void> update<T extends IResourceData>(IResource<T> res, String id, Map<String, dynamic> values);
  Future<void> delete<T extends IResourceData>(IResource<T> res, String id);
}

class QueryResult<T extends IResourceData> {
  final List<T> data;
  final List<DataChange<T>> changes;
  final dynamic cursor;
  final dynamic metadata;

  List<T> call() => data;

  QueryResult(this.data, this.changes, {this.cursor, this.metadata});
}

/// Data access object
class DataChange<T extends IResourceData> {
  T document;
  int oldIndex;
  int newIndex;
  DataChangeType type;

  DataChange({
    this.oldIndex,
    this.newIndex,
    this.document,
    this.type,
  });
}

class QueryFilter {
  final String field;
  final QueryOperator condition;
  final dynamic value;

  QueryFilter({this.field, this.condition, this.value});
}

class QuerySort {
  final String field;
  final bool desc;

  QuerySort(this.field, {this.desc = false});
}

class QueryParameters {
  List<QuerySort> sortList;
  List<QueryFilter> filterList;

  QueryParameters({@required this.sortList, this.filterList});
}

class QueryPagination {
  int skip, limit;
  dynamic cursor;

  int _skip, _limit;
  dynamic _cursor;

  QueryPagination({this.skip, this.limit, this.cursor}) {
    cache();
  }

  void update({limit, skip, cursor}) {
    this.limit = limit ?? this.limit;
    this.skip = skip ?? this.skip;
    this.cursor = cursor ?? this.cursor;
  }

  void reset() {
    limit = _limit;
    skip = _skip;
    cursor = _cursor;
  }

  void cache() {
    _limit = limit;
    _skip = skip;
    _cursor = cursor;
  }
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

enum DataChangeType {
  /// Indicates a new document was added to the set of documents matching the query.
  added,

  /// Indicates a document within the query was modified.
  modified,

  /// Indicates a document within the query was removed (either deleted or no longer matches the query.
  removed,
}
