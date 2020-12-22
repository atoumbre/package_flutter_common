import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';
import 'package:softi_resource_module/src/classes/query.dart';
import 'package:softi_resource_module/src/classes/resource.dart';
import 'package:softi_resource_module/src/interfaces/i_collection_service.dart';

class CollectionOptions {
  final int pageSize;
  final int maxRecordNumber;
  final bool reactiveRecords;
  final bool reactiveChanges;
  final bool reactiveLastPage;

  const CollectionOptions({
    this.reactiveRecords = true,
    this.reactiveChanges = true,
    this.reactiveLastPage = true,
    this.pageSize = 10,
    this.maxRecordNumber = 100,
  });

  bool get reactive => reactiveRecords && reactiveChanges;
}

class ResourceCollection<T extends IResourceData> {
  ResourceCollection(ICollectionService collectionService, IResource<T> res)
      : _collectionService = collectionService,
        _res = res;

  final ICollectionService _collectionService;
  final IResource<T> _res;

  // Pagination variables
  StreamSubscription _mainSubscription;
  int _recordCount;
  int _eventCount;
  dynamic _lastCursor;
  QueryPagination _pagination;

  //  Cache Query params for next call
  QueryParameters _params;
  CollectionOptions _options;

  // Returned info
  final hasMoreData = true.obs;
  final data = <T>[].obs;
  final changes = <DataChange<T>>[].obs;
  final waiting = false.obs;

  //+ Exposed data
  // RxBool get hasMoreData => _hasMoreData;
  // RxList<DataChange<T>> get changes => _changes;
  // RxList<T> get data => _data;
  // RxBool get waiting => _waiting;

  void requestData(
    QueryParameters params, {
    CollectionOptions options,
  }) {
    // reset on each call of requestData, use requestMoreData for more data
    _reset();

    // Save params for next call
    _params = params;
    _options = options ?? _options;

    // request data
    _requestData();
  }

  void requestMoreData({refresh = false}) {
    if (refresh) _reset();
    _requestData();
  }

  void _requestData() async {
    if (!hasMoreData()) return;

    waiting(true);

    //* Update pagination params and Create next query pagination
    var _queryPageSize = (_options.maxRecordNumber == null || _options.maxRecordNumber == double.infinity)
        ? _options.pageSize
        : min(_options.maxRecordNumber - _recordCount, _options.pageSize);

    _recordCount += _queryPageSize;

    //! If reactive query all docs each time and ecreas limit
    _pagination = QueryPagination(
      limit: _options.reactiveLastPage ? _recordCount : _queryPageSize,
      cursor: _options.reactiveLastPage ? null : _lastCursor,
    );

    await _mainSubscription?.cancel();
    _eventCount = 0;

    _mainSubscription = _collectionService
        .find(
      _res,
      _params,
      pagination: _pagination,
      reactive: _options.reactive,
    )
        .listen((queryResult) {
      _eventCount++;
      _lastCursor = queryResult.cursor;

      //
      if (_options.reactiveRecords) {
        data.assignAll(queryResult.data);
      } else {
        if (_eventCount == 1) data.assignAll(queryResult.data);
      }

      if (_options.reactiveChanges) {
        if (_eventCount > 1) changes.addAll(queryResult.changes);
      }

      // Check if we have more data
      hasMoreData(
        data.length >= _recordCount && _recordCount <= (_options.maxRecordNumber ?? double.infinity),
      );

      if (!_options.reactive && !hasMoreData()) _mainSubscription?.cancel();
    });
  }

  void _reset() {
    _recordCount = 0;
    _eventCount = 0;

    hasMoreData(true);
    data.assignAll([]);
    changes.assignAll([]);
  }

  void dispose() {
    _mainSubscription?.cancel();
    waiting.close();
    data.close();
    changes.close();
    hasMoreData.close();
  }
}
