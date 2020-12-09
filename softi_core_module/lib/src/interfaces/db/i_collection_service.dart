import 'dart:async';

import 'package:softi_core_module/src/interfaces/db/classes/query.dart';
import 'package:softi_core_module/src/interfaces/db/classes/resource.dart';
import 'package:softi_core_module/src/interfaces/i_base_service.dart';

export 'package:softi_core_module/src/interfaces/db/classes/resource.dart';
export 'package:softi_core_module/src/interfaces/db/classes/query.dart';

abstract class ICollectionService extends IBaseService {
  Stream<QueryResult<T>> find<T extends IResourceData>(
    IResource<T> res,
    QueryParameters queryParams, {
    QueryPagination pagination,
    bool reactive = true,
  });

  Stream<T> get<T extends IResourceData>(IResource<T> res, String id, {bool reactive = true});

  Future<bool> exists<T extends IResourceData>(IResource<T> res, String id);
  Future<T> save<T extends IResourceData>(IResource<T> res, T record);
  Future<void> update<T extends IResourceData>(IResource<T> res, String id, Map<String, dynamic> values);
  Future<void> delete<T extends IResourceData>(IResource<T> res, String id);
}

class QueryResult<T extends IResourceData> {
  final List<T> data;
  final List<DataChange<T>> changes;
  final dynamic endCursor;
  final dynamic startCursor;

  List<T> call() => data;

  QueryResult(this.data, this.changes, {this.endCursor, this.startCursor});
}

class DataChange<T extends IResourceData> {
  T data;
  int oldIndex;
  int newIndex;
  DataChangeType type;

  DataChange({
    this.oldIndex,
    this.newIndex,
    this.data,
    this.type,
  });
}

enum DataChangeType {
  /// Indicates a new document was added to the set of documents matching the query.
  added,

  /// Indicates a document within the query was modified.
  modified,

  /// Indicates a document within the query was removed (either deleted or no longer matches the query.
  removed,
}
