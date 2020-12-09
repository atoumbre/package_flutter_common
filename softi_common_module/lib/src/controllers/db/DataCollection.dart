import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';
import 'package:softi_core_module/src/interfaces/db/i_collection_service.dart';

class DataCollection<T extends IResourceData> {
  DataCollection(ICollectionService collectionService, IResource<T> res)
      : _collectionService = collectionService,
        _res = res;

  final ICollectionService _collectionService;
  final IResource<T> _res;

  // Pagination variables
  List<_DataPageInfo<T>> _allPages = [];
  dynamic _lastCursor;

  // Save params for next call
  int _pageSize;
  QueryParameters _params;
  int _maxRecordNumber;
  bool _reactive;

  //
  QueryPagination _pagination;

  final RxBool _hasMoreData = true.obs;
  final RxList<T> _data = <T>[].obs;
  final RxList<DataChange<T>> _changes = <DataChange<T>>[].obs;
  final RxBool _waiting = false.obs;

  //+ Exposed data
  RxBool get hasMoreData => _hasMoreData;
  RxList<DataChange<T>> get changes => _changes;
  RxList<T> get data => _data;
  RxBool get waiting => _waiting;

  void requestData(QueryParameters params, {int pageSize, bool reactive, int maxRecordNumber}) {
    // reset on each call of streamData, use streamMoreData for more data
    _reset();

    _params = params;
    _pageSize = pageSize ?? _pageSize;
    _reactive = reactive ?? _reactive;
    _maxRecordNumber = maxRecordNumber ?? _maxRecordNumber;
    _requestData();
  }

  void requestMoreData({refresh = false}) {
    if (refresh) _reset();
    _requestData();
  }

  void _requestData() async {
    if (!_hasMoreData.value) return;

    _waiting(true);

    /// Update pagination params
    var _queryLimit =
        _maxRecordNumber == null ? _pageSize : min(_maxRecordNumber - _allPages.length * _pageSize, _pageSize);

    _pagination = QueryPagination(
      limit: _queryLimit,
      startCursor: _lastCursor,
    );

    //* Create the new page if it is a new batch
    var currentRequestIndex = _allPages.length;
    var currentPage = _DataPageInfo<T>(
      snapshotCount: 0,
      docs: [],
      changes: [],
    );
    _allPages.add(currentPage);

    var queryResultStream = _collectionService.find(
      _res,
      _params,
      pagination: _pagination,
      reactive: _reactive,
    );

    /// Reques a page and listen to the result event
    _allPages[currentRequestIndex].subscription = queryResultStream.listen((queryResult) {
      // Increment Snapshot count
      _allPages[currentRequestIndex].snapshotCount++;

      // Stream data
      if (_allPages[currentRequestIndex].snapshotCount == 1 || _reactive) {
        _processDocumentsSnapshot(queryResult, currentRequestIndex);
      }

      // Stream changes
      if (_allPages[currentRequestIndex].snapshotCount > 1 && _reactive) {
        _processChangesSnapshot(queryResult, currentRequestIndex);
      } else {
        _changes.assignAll([]);
      }

      _waiting(false);
    });

    _allPages[currentRequestIndex].subscription.onDone(() {
      print('Page $currentRequestIndex done');
    });
  }

  void _processDocumentsSnapshot(QueryResult querResult, int requestIndex) {
    var data = querResult.data;

    _allPages[requestIndex].docs = data;

    var allData = _allPages.fold<List<T>>(
      <T>[],
      (initialValue, pageItems) => initialValue..addAll(pageItems.docs),
    );
    _data.assignAll(allData);

    if (requestIndex == _allPages.length - 1 && data.isNotEmpty) {
      _lastCursor = querResult.endCursor;
    }

    _hasMoreData.value = (data.length >= _pageSize) ||
        (data.length >= _pageSize && _maxRecordNumber != null && allData.length < _maxRecordNumber);

    _hasMoreData.refresh();

    print('_hasMoreData : ${_hasMoreData()} ${T.toString()}');
  }

  void _processChangesSnapshot(QueryResult querResult, int requestIndex) {
    List<DataChange<T>> changes = querResult.changes;
    if (changes.isNotEmpty) {
      _allPages[requestIndex].changes.addAll(changes);

      var allChanges = _allPages.fold<List<DataChange<T>>>(
        <DataChange<T>>[],
        (initialValue, pageItems) => initialValue..addAll(pageItems.changes),
      );
      _changes.assignAll(allChanges);
    }
  }

  void _reset() {
    _allPages = [];
    _hasMoreData.value = true;
    _lastCursor = null;

    _data.assignAll([]);
    _changes.assignAll([]);
  }

  void dispose() {
    _allPages.forEach((pageInfo) => pageInfo.dispose());
  }

  //? Extends With add and delete

}

class _DataPageInfo<T extends IResourceData> {
  List<T> docs;
  List<DataChange<T>> changes;
  int snapshotCount;
  StreamSubscription subscription;

  _DataPageInfo({
    this.docs,
    this.changes,
    this.snapshotCount,
  });

  void dispose() {
    if (subscription != null) subscription.cancel();
  }
}
