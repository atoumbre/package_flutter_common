import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';
import 'package:softi_core_module/src/interfaces/db/i_collection_service.dart';

enum CollectionReactivity { none, changes, records, all }

class DataCollection<T extends IResourceData> {
  DataCollection(ICollectionService collectionService, IResource<T> res)
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

  //  Query params for next call
  QueryParameters _params;
  int _maxRecordNumber;
  int _pageSize;
  CollectionReactivity _reactive;
  // bool _changesOnly;

  // Returned info
  final RxBool _hasMoreData = true.obs;
  final RxList<T> _data = <T>[].obs;
  final RxList<DataChange<T>> _changes = <DataChange<T>>[].obs;
  final RxBool _waiting = false.obs;

  //+ Exposed data
  RxBool get hasMoreData => _hasMoreData;
  RxList<DataChange<T>> get changes => _changes;
  RxList<T> get data => _data;
  RxBool get waiting => _waiting;

  void requestData(
    QueryParameters params, {
    int pageSize,
    CollectionReactivity reactive,
    bool changesOnly = false,
    int maxRecordNumber,
  }) {
    // reset on each call of requestData, use requestMoreData for more data
    _reset();

    // Save params for next call
    _params = params;
    _pageSize = pageSize ?? _pageSize;
    _reactive = reactive ?? _reactive;
    _maxRecordNumber = maxRecordNumber ?? _maxRecordNumber;

    // request data
    _requestData(_reactive);
  }

  void requestMoreData({refresh = false}) {
    if (refresh) _reset();
    _requestData(_reactive);
  }

  void _requestData(CollectionReactivity reactive) async {
    if (!_hasMoreData()) return;

    _waiting(true);

    //* Update pagination params and Create next  page query
    var _queryPageSize = (_maxRecordNumber == null || _maxRecordNumber == double.infinity)
        ? _pageSize
        : min(_maxRecordNumber - _recordCount, _pageSize);

    _recordCount += _queryPageSize;

    //! If reactive query all docs each time and ecreas limit
    _pagination = QueryPagination(
      limit: reactive != CollectionReactivity.none ? _recordCount : _queryPageSize,
      cursor: reactive != CollectionReactivity.none ? null : _lastCursor,
    );

    await _mainSubscription?.cancel();
    _eventCount = 0;

    _mainSubscription = _collectionService
        .find(
      _res,
      _params,
      pagination: _pagination,
      reactive: (reactive != CollectionReactivity.none),
    )
        .listen((queryResult) {
      //
      _eventCount++;
      _lastCursor = queryResult.cursor;

      //
      if (reactive == CollectionReactivity.all) {
        _data.assignAll(queryResult.data);
        _changes.addAll(queryResult.changes);
      } else if (reactive == CollectionReactivity.changes) {
        if (_eventCount == 1) _data.assignAll(queryResult.data);
        _changes.addAll(queryResult.changes);
      } else if (reactive == CollectionReactivity.records) {
        _data.assignAll(queryResult.data);
      } else {
        if (_eventCount == 1) _data.addAll(queryResult.data);
      }

      // Check if we have more data
      _hasMoreData(
        _data.length >= _recordCount && _recordCount <= (_maxRecordNumber ?? double.infinity),
      );
    });
  }

  void _reset() {
    _recordCount = 0;
    _eventCount = 0;

    _hasMoreData(true);
    _data.assignAll([]);
    _changes.assignAll([]);
  }

  void dispose() {
    _mainSubscription?.cancel();
  }
}
