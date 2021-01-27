import 'package:softi_common/src/resource/classes/resource.dart';

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
