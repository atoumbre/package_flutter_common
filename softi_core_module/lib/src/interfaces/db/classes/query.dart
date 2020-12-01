import 'package:flutter/foundation.dart';

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

  // int _skip, _limit;
  // dynamic _cursor;

  QueryPagination({this.skip, this.limit, this.cursor});

  void update({limit, skip, cursor}) {
    this.limit = limit ?? this.limit;
    this.skip = skip ?? this.skip;
    this.cursor = cursor ?? this.cursor;
  }

  // void reset() {
  //   limit = _limit;
  //   skip = _skip;
  //   cursor = _cursor;
  // }

  // void cache() {
  //   _limit = limit;
  //   _skip = skip;
  //   _cursor = cursor;
  // }
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
