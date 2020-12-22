import 'package:get/get.dart';
import 'package:softi_core_module/index.dart';
import 'package:softi_resource_module/src/classes/ResourceCollection.dart';
import 'package:softi_resource_module/src/classes/filters.dart';
import 'package:softi_resource_module/src/classes/query.dart';
import 'package:softi_resource_module/src/classes/resource.dart';
import 'package:softi_resource_module/src/interfaces/i_collection_service.dart';

abstract class BaseCollectionController<T extends IResourceData> extends BaseController {
  //
  final ResourceCollection<T> _collection;
  final QueryParameters _queryParams;
  final CollectionOptions _options;

  BaseCollectionController(
    this._collection, {
    Filter filter,
    CollectionOptions options,
  })  : _queryParams = (filter ?? Filter()).build(),
        _options = options ?? CollectionOptions();

  // List<S> get recordList => _collection.data.map(transformer).toList();
  RxList<DataChange<T>> get changesList => _collection.changes;
  RxBool get hasMoreData => _collection.hasMoreData;

  void init() {
    _collection.requestData(
      _queryParams,
      options: _options,
    );
    busy.bindStream(_collection.waiting.stream);
  }

  void handleListItemCreation(int index) {
    // when the item is created we request more data when we reached the end of current page
    // print('index $index created');
    if (_collection.data.length == (index + 1) && _collection.hasMoreData()) {
      _collection.requestMoreData();
    }
  }

  // S transformer(T record);

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
    _collection.dispose();
  }
}
