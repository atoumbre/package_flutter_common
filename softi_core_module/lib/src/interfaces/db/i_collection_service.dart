import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:recase/recase.dart';
import 'package:softi_core_module/src/interfaces/i_base_service.dart';

typedef Deserializer<T> = T Function(Map<String, dynamic>);

enum ResourceRequestType { list, read, create, replace, update, delete }

abstract class IResource<T> {
  String get collectionName => T.toString().snakeCase + 's';
  T deserializer(Map<String, dynamic> serializedData);
  String endpointResolver({ResourceRequestType requestType, QueryParam queryParam, dynamic id, T dataObject});
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
  Future<QueryResult<T>> getData<T extends IResourceData>(
    IResource<T> res,
    QueryParam queryParams, {
    dynamic cursor,
    int skip,
    int limit = 10,
  });

  Future<Stream<QueryResult<T>>> streamData<T extends IResourceData>(
    IResource<T> res,
    QueryParam queryParams, {
    dynamic cursor,
    int skip,
    int limit = 10,
  });

  Future<T> get<T extends IResourceData>(IResource<T> res, String id);
  Stream<T> stream<T extends IResourceData>(IResource<T> res, String id);
  Future<bool> exists<T extends IResourceData>(IResource<T> res, String id);
  Future<T> save<T extends IResourceData>(IResource<T> res, T record, {refresh = false});
  Future<void> update<T extends IResourceData>(IResource<T> res, String id, Map<String, dynamic> values);
  Future<void> delete<T extends IResourceData>(IResource<T> res, String id);
}

class QueryResult<T extends IResourceData> {
  final List<T> data;
  final List<Change<T>> changes;
  final dynamic cursor;
  final dynamic metadata;

  List<T> call() => data;

  QueryResult(this.data, this.changes, {this.cursor, this.metadata});
}

/// Data access object
class Change<T extends IResourceData> {
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
