// import 'dart:async';
// import 'dart:math';

// import 'package:get/get.dart';
// import 'package:softi_core_module/softi_core_module.dart';

// abstract class Repository<T, S> {
//   Repository(this.repoParams);

//   List<T> data;
//   bool hasMoreData;
//   final S repoParams;
//   S _paramCache;

//   List<T> requestData({S param, bool reset});

//   void reset() => _paramCache = repoParam;

//   void init() {}

//   void dispose() {}
// }

// // class _DataPageInfo<T> {
// //   List<T> docs;
// //   int snapshotCount;
// //   StreamSubscription subscription;

// //   _DataPageInfo({
// //     this.docs,
// //     this.changes,
// //     this.snapshotCount,
// //   });

// //   dispose() {
// //     if (subscription != null) subscription.cancel();
// //   }
// // }
