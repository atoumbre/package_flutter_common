import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:softi_common_module/src/controllers/BaseController.dart';
import 'package:softi_common_module/src/controllers/db/DataCollection.dart';
import 'package:softi_common_module/src/controllers/db/Database.dart';
import 'package:softi_core_module/softi_core_module.dart';

class BaseCollectionController<T extends IResourceData> extends BaseController {
  final Logger _logger;
  final DataCollection<T> _collection;
  final QueryParameters _params;

  final int pageSize;
  final int maxRecordNumber;
  final bool reactive;
  final bool changesOnly;

  BaseCollectionController(
    Filter filter, {
    this.pageSize = 10,
    this.maxRecordNumber = 100,
    this.reactive = true,
    this.changesOnly = true,
    DatabaseController db,
    Logger logger,
  })  : _params = (filter ?? Filter()).build(),
        _collection = (db ?? Get.find()).collection<T>(),
        _logger = logger ?? Get.find();

  RxList<T> get recordList => _collection.data;
  RxList<DataChange<T>> get changesList => _collection.changes;
  RxBool get hasMoreData => _collection.hasMoreData;

  void init() {
    _collection.requestData(
      _params,
      pageSize: pageSize,
      maxRecordNumber: maxRecordNumber,
      reactive: reactive,
      changesOnly: changesOnly,
    );
    busy.bindStream(_collection.waiting.stream);
  }

  void handleListItemCreation(int index) {
    // when the item is created we request more data when we reached the end of current page
    _logger.d('index $index created');
    if (_collection.data.length == (index + 1) && _collection.hasMoreData()) {
      _collection.requestMoreData();
    }
  }

  @override
  void onInit() {
    // init();
    super.onInit();
  }

  @override
  void onReady() {
    // init();
    super.onReady();
  }

  @override
  void onClose() {
    _logger.d('Dispose Collection Controller');
    _collection.dispose();
  }
}
