import 'package:get/get.dart';
import 'package:softi_core_module/index.dart';
import 'package:softi_resource_module/src/classes/DataCollection.dart';
import 'package:softi_resource_module/src/classes/query.dart';
import 'package:softi_resource_module/src/classes/resource.dart';
import 'package:softi_resource_module/src/interfaces/i_collection_service.dart';

mixin CollectionControllerMixin<T extends IResourceData> on BaseController {
  //
  DataCollection<T> get collection;
  QueryParameters get queryParameters;
  CollectionOptions get collectionOptions;

  RxList<T> get recordList => collection.data;
  RxList<DataChange<T>> get changesList => collection.changes;
  RxBool get hasMoreData => collection.hasMoreData;

  void handleListItemCreation(int index) {
    // when the item is created we request more data when we reached the end of current page
    // print('index $index created');
    if (collection.data.length == (index + 1) && collection.hasMoreData()) {
      collection.requestMoreData();
    }
  }

  void initCollection() {
    busy.bindStream(collection.waiting.stream);
    collection.requestData(
      queryParameters,
      options: collectionOptions,
    );
  }

  void disposeCollection() {
    print('Dispose Collection Controller');
    collection.dispose();
  }
}
