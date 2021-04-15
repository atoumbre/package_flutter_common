import 'package:get/get.dart';
import 'package:softi_common/src/core/controllers/BaseController.dart';
import 'package:softi_common/src/services/interfaces/device/i_connectivity_service.dart';

mixin ConnectivityControllerMixin on IBaseController {
  IConnectivityService connectivityService = Get.find<IConnectivityService>();

  Rx<ConnectivityType> connectivityType = ConnectivityType.none.obs;

  void initConnectivityMonitoring() {
    connectivityType.bindStream(connectivityService.streamConectivity);
  }
}

class ConnectivityController extends IBaseController with ConnectivityControllerMixin {
  @override
  final IConnectivityService connectivityService;

  ConnectivityController(this.connectivityService);
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
