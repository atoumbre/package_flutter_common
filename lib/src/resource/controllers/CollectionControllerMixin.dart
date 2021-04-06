import 'package:get/get.dart';
import 'package:softi_common/src/core/base_controller.dart';
import 'package:softi_common/src/resource/classes/ResourceCollection.dart';
import 'package:softi_common/src/resource/classes/filters.dart';
import 'package:softi_common/src/resource/classes/query.dart';
import 'package:softi_common/src/resource/interfaces/i_resource_adapter.dart';
import 'package:softi_common/src/resource/interfaces/i_resource.dart';

mixin CollectionControllerMixin<T extends IResourceData> on BaseViewController {
  @override
  Future<void> loadView() async => initCollection();

  @override
  Future<void> disposeView() async => disposeCollection();

  //! Parameters
  ResourceCollection<T> get collection;
  QueryParameters get queryParameters => Filter().build();
  CollectionOptions get options => CollectionOptions();

  //! Getters
  RxList<T?> get recordList => collection.data;
  RxList<DataChange<T>> get changesList => collection.changes;
  RxBool get hasMoreData => collection.hasMoreData;
  RxBool get isResourceLoading => collection.loading;

  void handleListItemCreation(int index, [int itemCount = 0]) {
    // when item is created we request more data when we reached the end of current page
    if (collection.data.length == (index + 1) && collection.hasMoreData()) {
      collection.requestMoreData();
    }
  }

  void initCollection() {
    collection.requestData(
      queryParameters,
      options: options,
    );
  }

  void disposeCollection() {
    print('Dispose Collection Controller');
    collection.dispose();
  }
}
