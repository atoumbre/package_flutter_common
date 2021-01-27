import 'package:softi_common/src/core/base_controller.dart';
import 'package:softi_common/src/resource/classes/ResourceCollection.dart';
import 'package:softi_common/src/resource/classes/filters.dart';
import 'package:softi_common/src/resource/classes/query.dart';
import 'package:softi_common/src/resource/classes/resource.dart';
import 'package:softi_common/src/resource/controllers/CollectionControllerMixin.dart';

abstract class BaseCollectionController<T extends IResourceData> extends BaseController
    with CollectionControllerMixin<T> {
  //
  @override
  ResourceCollection<T> get collection => _collection;

  @override
  QueryParameters get queryParameters => _queryParams.build();

  @override
  CollectionOptions get collectionOptions => _options;

  //
  final ResourceCollection<T> _collection;
  final Filter _queryParams;
  final CollectionOptions _options;

  BaseCollectionController(
    this._collection, {
    Filter filter,
    CollectionOptions options,
  })  : _queryParams = filter ?? Filter(),
        _options = options ?? CollectionOptions();

  @override
  void onInit() {
    initCollection();
    super.onInit();
  }

  @override
  void onClose() {
    disposeCollection();
    super.onClose();
  }
}
