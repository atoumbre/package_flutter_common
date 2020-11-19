import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:softi_common_module/src/controllers/base/BaseController.dart';
import 'package:softi_common_module/src/controllers/db/DataCollection.dart';
import 'package:softi_common_module/src/controllers/db/Database.dart';
import 'package:softi_core_module/softi_core_module.dart';

abstract class DataCollectionController<T extends IResourceData> extends BaseController {
  final Logger _logger;
  final DataCollection<T> collection;

  DataCollectionController([DatabaseController db, Logger logger])
      : collection = (db ?? Get.find()).collection<T>(),
        _logger = logger ?? Get.find();

  QueryParameters get filter;

  int get pageSize => 10;
  int get maxRecordNumber => 100;
  bool get reactive => true;

  RxList<T> get recordList => collection.data;
  RxBool get hasMoreData => collection.hasMoreData;

  void init() {
    collection.requestData(
      filter,
      pageSize: pageSize,
      maxRecordNumber: maxRecordNumber,
      reactive: reactive,
    );
    busy.bindStream(collection.waiting.stream);
  }

  void handleListItemCreation(int index) {
    // when the item is created we request more data when we reached the end of current page
    _logger.d('index $index created');
    if (collection.data.length == (index + 1) && collection.hasMoreData()) {
      collection.requestMoreData();
    }
  }

  @override
  void onReady() {
    init();
    super.onReady();
  }

  @override
  void onClose() {
    _logger.d('Dispose Collection Controller');
    collection.dispose();
  }
}
