// import 'package:softi_common/resource.dart';

// typedef Deserializer<T> = T Function(Map<String, dynamic>);

// enum ResourceRequestType { call, find, read, create, replace, update, delete }

// abstract class IServiceResource<Rq, Rs> {
//   //
//   Rs deserializer(Map<String, dynamic> serializedData);

//   //
//   String endpointResolver(Rq params);
// }

// abstract class ICollectionEndpoint<Rq, Rs> extends IServiceResource<Rq, Rs> {
//   Stream<Rs> call(
//     // IService<Rq, Rs> res,
//     // ResourceRequestType type,
//     Rq request, {
//     bool reactive = true,
//   });
// }

// // abstract class IResourceData {
// //   Map<String, dynamic> toJson();
// //   String getId();
// //   String getPath();
// //   bool isValid();
// // }

// // mixin BaseResourceDataMixin {
// //   String id;
// //   String path;
// //   String getId() => id;
// //   String getPath() => path;
// //   bool isValid() => (id ?? '') != '';
// // }

// class FunctionResult {
//   FunctionResult();

//   factory FunctionResult.fromJson(Map<String, dynamic> input) => FunctionResult();
// }

// class FunctionParam {
//   FunctionParam();
// }

// class FunctionsResoure extends IServiceResource<FunctionParam, FunctionResult> {
//   @override
//   FunctionResult deserializer(Map<String, dynamic> serializedData) {
//     return FunctionResult.fromJson(serializedData);
//   }

//   @override
//   String endpointResolver(FunctionParam type) {
//     return 'functions';
//   }
// }

// class FinctionService extends ICollectionService {
//   @override
//   Stream<FunctionResult> call<T extends IResourceData, Rq, Rs>(
//     IServiceResource<T> res,
//     ResourceRequestType type,
//     Rq request, {
//     bool reactive = true,
//   }) {
//     // TODO: implement call
//     throw UnimplementedError();
//   }
// }
