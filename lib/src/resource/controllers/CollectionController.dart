import 'package:softi_common/src/core/base_controller.dart';
import 'package:softi_common/src/resource/classes/ResourceCollection.dart';
import 'package:softi_common/src/resource/classes/filters.dart';
import 'package:softi_common/src/resource/classes/query.dart';
import 'package:softi_common/src/resource/controllers/CollectionControllerMixin.dart';
import 'package:softi_common/src/resource/interfaces/i_resource.dart';

class CollectionController<T extends IResourceData> extends BaseViewController with CollectionControllerMixin<T> {
  @override
  final ResourceCollection<T> collection;

  @override
  final QueryParameters queryParameters;

  @override
  final CollectionOptions options;

  CollectionController(
    this.collection, {
    Filter filter,
    CollectionOptions options,
  })  : queryParameters = (filter ?? Filter()).build(),
        options = options ?? CollectionOptions();
}
