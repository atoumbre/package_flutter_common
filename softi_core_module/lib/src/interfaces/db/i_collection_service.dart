import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:softi_core_module/src/models/base_model.dart';

abstract class ICollectionService {
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
    int limit,
  });

  Future<T> get<T extends IBaseModel>(String id);
  Stream<T> stream<T extends IBaseModel>(String id);
  Future<T> add<T extends IBaseModel>(T record);
  Future<T> update<T extends IBaseModel>(T record);
  Future<T> delete<T extends IBaseModel>(String id);
  Future<bool> exists<T extends IBaseModel>(String id);
}

class QueryResult<T extends IBaseModel> {
  final List<T> data;
  final List<Change<T>> changes;

  QueryResult(this.data, this.changes);
}

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
  QuerySort(this.field, {this.desc});
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

class _FilterBuilder {
  List<QueryFilter> _params = [];
  List<QuerySort> _orders = [];

  //+ Filters
  _FilterBuilder addFilter(QueryFilter queryFilter) {
    _params.add(queryFilter);
    return this;
  }

  //+ Order by
  _FilterBuilder addOrderBy(QuerySort queryOrder) {
    _orders.add(queryOrder);
    return this;
  }

  //+ Build query Params
  QueryParam build() {
    return QueryParam(sortList: _orders, filterList: _params);
  }

  //+ Build query Params
  void reset() {
    _orders = [];
    _params = [];
  }
}

abstract class IFilter {
  QueryParam build();
}

class Filter with BaseFilterMixin implements IFilter {
  Filter([_FilterBuilder filterBuilder]) : _filterBuilder = filterBuilder ?? _FilterBuilder();

  final _FilterBuilder _filterBuilder;
}

class FieldFilter with FieldFilterMixin {
  FieldFilter(String field, _FilterBuilder filterBuilder)
      : _field = field,
        _filterBuilder = filterBuilder;

  final _FilterBuilder _filterBuilder;
  final String _field;
}

class FieldFilterExtended with BaseFilterMixin, FieldFilterMixin implements IFilter {
  FieldFilterExtended([String field, _FilterBuilder filterBuilder])
      : _filterBuilder = filterBuilder ?? _FilterBuilder(),
        _field = field;

  final _FilterBuilder _filterBuilder;
  final String _field;
}

mixin BaseFilterMixin {
  _FilterBuilder _filterBuilder;

  FieldFilter $field(String field) => FieldFilter(field, _filterBuilder);

  FieldFilterExtended $orderBy(String field, {bool desc = false}) => $field(field).$sort(desc: desc);
  FieldFilterExtended $filter$eq(String field, value) => $field(field).$eq(value);
  FieldFilterExtended $filter$gt(String field, value) => $field(field).$gt(value);
  FieldFilterExtended $filter$gte(String field, value) => $field(field).$gte(value);
  FieldFilterExtended $filter$lt(String field, value) => $field(field).$lt(value);
  FieldFilterExtended $filter$lte(String field, value) => $field(field).$lte(value);
  FieldFilterExtended $filter$in(String field, value) => $field(field).$in(value);
  FieldFilterExtended $filter$contains(String field, value) => $field(field).$contains(value);
  FieldFilterExtended $filter$containsAny(String field, value) => $field(field).$containsAny(value);

  QueryParam build() => _filterBuilder.build();
  void reset() => _filterBuilder.reset();
}

mixin FieldFilterMixin {
  _FilterBuilder _filterBuilder;
  String _field;

  FieldFilterExtended $sort({bool desc = false}) {
    _filterBuilder.addOrderBy(QuerySort(_field, desc: desc));
    return FieldFilterExtended(_field, _filterBuilder);
  }

  FieldFilterExtended $in(List<dynamic> valueList) {
    _filterBuilder.addFilter(QueryFilter(field: _field, condition: QueryOperator.isIn, value: valueList));
    return FieldFilterExtended(_field, _filterBuilder);
  }

  FieldFilterExtended $eq(dynamic value) {
    _filterBuilder.addFilter(QueryFilter(field: _field, condition: QueryOperator.equal, value: value));
    return FieldFilterExtended(_field, _filterBuilder);
  }

  FieldFilterExtended $gte(dynamic value) {
    _filterBuilder.addFilter(QueryFilter(field: _field, condition: QueryOperator.greaterThanOrEqualTo, value: value));
    return FieldFilterExtended(_field, _filterBuilder);
  }

  FieldFilterExtended $gt(dynamic value) {
    _filterBuilder.addFilter(QueryFilter(field: _field, condition: QueryOperator.greaterThan, value: value));
    return FieldFilterExtended(_field, _filterBuilder);
  }

  FieldFilterExtended $lt(dynamic value) {
    _filterBuilder.addFilter(QueryFilter(field: _field, condition: QueryOperator.lessThan, value: value));
    return FieldFilterExtended(_field, _filterBuilder);
  }

  FieldFilterExtended $lte(dynamic value) {
    _filterBuilder.addFilter(QueryFilter(field: _field, condition: QueryOperator.lessThanOrEqualTo, value: value));
    return FieldFilterExtended(_field, _filterBuilder);
  }

  FieldFilterExtended $contains(value) {
    _filterBuilder.addFilter(QueryFilter(field: _field, condition: QueryOperator.arrayContains, value: value));
    return FieldFilterExtended(_field, _filterBuilder);
  }

  FieldFilterExtended $containsAny(List<dynamic> valueList) {
    _filterBuilder.addFilter(QueryFilter(field: _field, condition: QueryOperator.arrayContainsAny, value: valueList));
    return FieldFilterExtended(_field, _filterBuilder);
  }
}
