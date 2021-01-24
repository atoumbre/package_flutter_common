import 'dart:async';

import 'package:softi_core_module/src/resource/classes/query.dart';
import 'package:softi_core_module/src/resource/classes/resource.dart';

abstract class IResourceService<R, T> {
  Future<T> request([R requestData]);

  // Stream<QueryResult<T>> find<T extends IResourceData>(
  //   IResource<T> res,
  //   QueryParameters queryParams, {
  //   QueryPagination pagination,
  //   bool reactive = true,
  // });

  // Stream<T> get<R, T>(R requestData, {bool reactive = true});
  // Future<bool> exists<R>(R requestData);
  // Future<void> update<R>(R res);
  // Future<void> delete<R>(R res);
}

class DefaulFunction extends IResourceService<Map, dynamic> {
  @override
  Future request([Map a]) async {
    return {};
  }
}

test() {}

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
