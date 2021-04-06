import 'package:softi_common/resource.dart';
import 'package:softi_common/src/resource/classes/ResourceCollection.dart';
import 'package:softi_common/src/resource/interfaces/i_resource.dart';
import 'package:softi_common/src/resource/interfaces/i_resource_adapter.dart';

abstract class IResourceBase {
  //! To override
  IResourceAdapter<T> adapter<T extends IResourceData>(IResource<T> res);
  IResource<T> resourceResolver<T extends IResourceData>();

  //
  ResourceCollection<T> collection<T extends IResourceData>() {
    // return ResourceCollection<T>((_res ?? _resourceResolver<T>()).adapter);
    return ResourceCollection<T>(adapter<T>(resourceResolver<T>()));
  }

  ResourceRecord<T> record<T extends IResourceData>() {
    // return ResourceRecord<T>(_res ?? _resourceResolver<T>().adapter);
    return ResourceRecord<T>(adapter<T>(resourceResolver<T>()));
  }

  IResource<T> resource<T extends IResourceData>() => resourceResolver<T>();

  IResourceAdapter<T> api<T extends IResourceData>([String? endpoint]) {
    var _res = resourceResolver<T>();
    return endpoint == null ? adapter<T>(_res) : adapter<T>(_res.setEndpoint(endpoint));
  }
}
