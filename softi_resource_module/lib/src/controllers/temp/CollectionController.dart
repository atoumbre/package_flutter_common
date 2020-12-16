import 'package:get/get.dart';
import 'package:softi_core_module/index.dart';
import 'package:softi_resource_module/src/classes/DataCollection.dart';
import 'package:softi_resource_module/src/classes/filters.dart';
import 'package:softi_resource_module/src/classes/query.dart';
import 'package:softi_resource_module/src/classes/resource.dart';
import 'package:softi_resource_module/src/interfaces/i_collection_service.dart';

class CollectionControllerOptions {
  final int pageSize;
  final int maxRecordNumber;
  final CollectionReactivity reactivity;

  const CollectionControllerOptions({
    this.pageSize,
    this.maxRecordNumber,
    this.reactivity,
  });
}

class BaseCollectionController<T extends IResourceData> extends BaseController {
  //
  final DataCollection<T> collection;
  //
  final QueryParameters _params;
  final int _pageSize;
  final int _maxRecordNumber;
  final CollectionReactivity _reactivity;

  BaseCollectionController(
    this.collection, {
    Filter filter,
    CollectionControllerOptions options,
  })  : _params = (filter ?? Filter()).build(),
        _pageSize = options?.pageSize ?? 10,
        _maxRecordNumber = options?.maxRecordNumber ?? 100,
        _reactivity = options?.reactivity ?? CollectionReactivity.none;

  RxList<T> get recordList => collection.data;
  RxList<DataChange<T>> get changesList => collection.changes;
  RxBool get hasMoreData => collection.hasMoreData;

  void init() {
    collection.requestData(
      _params,
      pageSize: _pageSize,
      maxRecordNumber: _maxRecordNumber,
      reactive: _reactivity,
    );
    busy.bindStream(collection.waiting.stream);
  }

  void handleListItemCreation(int index) {
    // when the item is created we request more data when we reached the end of current page
    // print('index $index created');
    if (collection.data.length == (index + 1) && collection.hasMoreData()) {
      collection.requestMoreData();
    }
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    print('Dispose Collection Controller');
    collection.dispose();
  }
}
