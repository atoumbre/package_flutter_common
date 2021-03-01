import 'package:get/get.dart';
import 'package:softi_common/src/core/base_controller.dart';
import 'package:softi_common/src/resource/classes/ResourceCollection.dart';
import 'package:softi_common/src/resource/classes/filters.dart';
import 'package:softi_common/src/resource/classes/query.dart';
import 'package:softi_common/src/resource/interfaces/i_resource.dart';
import 'package:softi_common/src/resource/interfaces/i_collection_service.dart';

mixin CollectionControllerMixin<T extends IResourceData> on BaseController {
  //
  ResourceCollection<T> get collection;

  //
  QueryParameters get queryParameters => Filter().build();
  CollectionOptions get collectionOptions => CollectionOptions();
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
