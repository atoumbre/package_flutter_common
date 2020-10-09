import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';
import 'package:softi_core_module/softi_core_module.dart';

class DataCollection<T extends IBaseModel> {
  DataCollection(ICollectionService collectionService, Resource<T> res)
      : _collectionService = collectionService,
        _res = res;

  final ICollectionService _collectionService;
  final Resource<T> _res;

  // Pagination variables
  List<_PageData<T>> _allPages = [];
  dynamic _cursor;

  // Save params for next call
  QueryParam _queryParams;
  int _pageSize;
  int _limit;
  bool _realtime;

  RxBool _hasMoreData = true.obs;
  RxList<T> _data = <T>[].obs;
  RxList<Change<T>> _changes = <Change<T>>[].obs;
  RxBool _waiting = false.obs;

  //+ Exposed data
  RxBool get hasMoreData => _hasMoreData;
  RxList<Change<T>> get changes => _changes;
  RxList<T> get data => _data;
  RxBool get waiting => _waiting;

  //+ Exposed data Streams
  Stream<bool> get noMoreDataStream => _hasMoreData.stream;
  Stream<List<Change<T>>> get changesStream => _changes.stream;
  Stream<List<T>> get dataStream => _data.stream;
  Stream<bool> get waitingStream => _waiting.stream;

  //+ PageSize
  int get pageSize => _pageSize;

  void requestData(QueryParam queryParam, {int pageSize, bool realtime, int limit}) {
    // reset on each call of streamData, use streamMoreData for more data
    _reset();
    _queryParams = queryParam;
    _pageSize = pageSize ?? _pageSize;
    _realtime = realtime ?? _realtime;
    _limit = limit ?? _limit;
    _requestData();
  }

  void requestMoreData() => _requestData();

  void _requestData() async {
    if (!_hasMoreData.value) return;

    _waiting(true);

    int _queryLimit = _limit == null ? _pageSize : min(_limit - _allPages.length * _pageSize, _pageSize);

    int currentRequestIndex = _allPages.length;
    _PageData<T> currentPage = _PageData<T>(
      snapshotCount: 0,
      docs: [],
      changes: [],
    );

    //* Create the new page
    _allPages.add(currentPage);

    Stream<QueryResult<T>> snapshots = await _collectionService.streamData(
      _res,
      _queryParams,
      limit: _queryLimit, // Api call with pagesize as linimt
      cursor: _cursor,
    );

    _allPages[currentRequestIndex].subscription = snapshots.listen((queryResult) {
      // Increment Snapshot count
      _allPages[currentRequestIndex].snapshotCount++;

      // Stream data
      if (_allPages[currentRequestIndex].snapshotCount == 1 || _realtime) {
        _processDocumentsSnapshot(queryResult, currentRequestIndex);
      }

      // Stream changes
      if (_allPages[currentRequestIndex].snapshotCount > 1 || _realtime) {
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
    // if (data.isNotEmpty) {
    _allPages[requestIndex].docs = data;

    List<T> allData = _allPages.fold<List<T>>(
      List<T>(),
      (initialValue, pageItems) => initialValue..addAll(pageItems.docs),
    );
    _data.assignAll(allData);

    if (requestIndex == _allPages.length - 1 && data.isNotEmpty) {
      _cursor = querResult.cursor;
    }

    _hasMoreData.value =
        (data.length >= _pageSize) || (data.length >= _pageSize && _limit != null && allData.length < _limit);

    print('_hasMoreData : $_hasMoreData ${T.toString()}');
    // }
  }

  void _processChangesSnapshot(QueryResult querResult, int requestIndex) {
    List<Change<T>> changes = querResult.changes;
    if (changes.isNotEmpty) {
      _allPages[requestIndex].changes.addAll(changes);

      List<Change<T>> allChanges = _allPages.fold<List<Change<T>>>(
        List<Change<T>>(),
        (initialValue, pageItems) => initialValue..addAll(pageItems.changes),
      );
      _changes.assignAll(allChanges);
    }
  }

  void _reset() {
    _queryParams = null;
    _pageSize = 10;
    _realtime = true;
    _limit = null;

    _allPages = [];
    _hasMoreData.value = true;
    _cursor = null;

    _data.assignAll([]);
    _changes.assignAll([]);
  }

  void dispose() {
    _allPages.forEach((element) => element.dispose());
  }

  // Extends With add and delete

}

class _PageData<T extends IBaseModel> {
  List<T> docs;
  List<Change<T>> changes;
  int snapshotCount;
  StreamSubscription subscription;

  _PageData({
    this.docs,
    this.changes,
    this.snapshotCount,
  });

  dispose() {
    if (subscription != null) subscription.cancel();
  }
}
