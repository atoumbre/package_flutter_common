import 'package:softi_common/src/core/BaseController.dart';
import 'package:softi_common/src/services/interfaces/device/i_connectivity_service.dart';
import 'package:get/get.dart';

// enum LoadingStatus { idle, loading, error }

mixin ConnectivityControllerMixin on BaseController {
  IConnectivityService connectivityService = Get.find<IConnectivityService>();

  Rx<ConnectivityType> connectivityType = ConnectivityType.none.obs;

  void initConnectivityMonitoring() {
    connectivityType.bindStream(connectivityService.streamConectivity);
  }
}

// class LoadingStatusWidget extends StatelessWidget {
//   final LoadingStatusControllerMixin? controller;
//   final Widget Function()? loadingWidget, errorWidget, builder;

//   const LoadingStatusWidget({
//     Key? key,
//     this.controller,
//     this.builder,
//     this.errorWidget,
//     this.loadingWidget,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) => Obx(() {
//         switch (controller!.loadingStatus()) {
//           case LoadingStatus.error:
//             return errorWidget!();

//           case LoadingStatus.loading:
//             return loadingWidget!();

//           default:
//             return builder!();
//         }
//       });
// }
