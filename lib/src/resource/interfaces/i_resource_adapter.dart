import 'dart:async';

import 'package:softi_common/src/resource/classes/query.dart';
import 'package:softi_common/src/resource/interfaces/i_resource.dart';

abstract class IResourceAdapter<T extends IResourceData> {
  IResource<T> _res;

  IResource<T> get resource => _res;

  IResourceAdapter<T> setResource(IResource<T> newResource) {
    _res = newResource;
    return this;
  }

  Stream<QueryResult<T>> find(
    QueryParameters queryParams, {
    QueryPagination pagination,
    bool reactive = true,
  });

  Stream<T> get(String id, {bool reactive = true});

  Future<bool> exists(String id);
  Future<T> save(T record);
  Future<void> update(String id, Map<String, dynamic> values);
  Future<void> delete(String id);
}

class QueryResult<T extends IResourceData> {
  final List<T> data;
  final List<DataChange<T>> changes;
  final dynamic cursor;

  List<T> call() => data;

  QueryResult(this.data, this.changes, {this.cursor});
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
