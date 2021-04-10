import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:softi_common/src/core/BaseService.dart';
import 'package:softi_common/src/core/controllers/LoadingStateControllerMixin.dart';
import 'package:softi_common/src/core/controllers/TaskHandlerControllerMixin.dart';

abstract class IBaseController extends GetxController {}

abstract class BaseController extends IBaseController with LoadingStatusControllerMixin {
  Future<Result<ServiceFailure, R>> failureCatcher<R>(Future<R> Function() task) async {
    try {
      return Success(await task());
    } on ServiceFailure catch (e) {
      return Error(e);
    } catch (e) {
      rethrow;
    }
  }
}

class BaseViewSettings {}

abstract class BaseViewController extends BaseController with TaskHandlerControllerMixin {
  @mustCallSuper
  Future<void> onViewInit() async {}

  @mustCallSuper
  Future<void> onViewReady() async {}

  @mustCallSuper
  Future<void> onViewClose() async {}

  Future<void> _initView() async {
    await controllerTaskHandler(
        task: () async {
          await onViewInit();
        },
        toggleViewState: true,
        showViewState: false,
        busyMessage: 'Loading ...',
        completedMessage: 'Loding completed',
        rethrowError: true,
        errorHandler: (error) {
          return '';
        });
  }

  Future<void> _onViewReady() async {
    await controllerTaskHandler(
        task: () async {
          await onViewReady();
        },
        toggleViewState: true,
        showViewState: false,
        busyMessage: 'Loading ...',
        completedMessage: 'Loding completed',
        rethrowError: true,
        errorHandler: (error) {
          return '';
        });
  }

  @override
  void onInit() async {
    await _initView();
    super.onInit();
  }

  @override
  void onReady() async {
    await _onViewReady();
    super.onReady();
  }

  @override
  void onClose() {
    onViewClose();
    super.onClose();
  }

  void navigateBack() => Get.back();
}

abstract class BaseView<T extends BaseViewController> extends StatelessWidget {
  Widget loadingBuilder(T controller) => Center(child: CircularProgressIndicator());
  Widget errorBuilder(T controller) => Center(child: Text('An Error Occurs', style: TextStyle(color: Colors.red)));
  Widget builder(T controller);
  T init();

  String? get tag => null;

  const BaseView({
    Key? key,
  }) : super(key: key);

  T get controller => Get.put<T>(init(), tag: tag);

  // @override
  // Widget build(BuildContext context) {
  //   return GetX<T>(
  //     init: init(),
  //     tag: tag,
  //     builder: (controller) {
  //       if (controller.loadingStatus() == LoadingStatus.error) {
  //         return errorBuilder(controller);
  //       }

  //       if (controller.loadingStatus() == LoadingStatus.loading) {
  //         return loadingBuilder(controller);
  //       }

  //       return builder(controller);
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.loadingStatus() == LoadingStatus.error) {
        return errorBuilder(controller);
      }

      if (controller.loadingStatus() == LoadingStatus.loading) {
        return loadingBuilder(controller);
      }

      return builder(controller);
    });
  }
}

// typedef VoidAsyncCallback = Future<void> Function();
typedef ServiceCall<R, T> = Future<R> Function(T);

extension ServiceFailerCatcher<R, T> on ServiceCall<R, T> {
  Future<Result<ServiceFailure, R>> failureCatcher(T params) async {
    try {
      return Success(await this.call(params));
    } catch (e) {
      try {
        return Error(e as ServiceFailure);
      } catch (e) {
        rethrow;
      }
    }

    // var res = await Task(() => this.call(params)) //
    //     .attempt()
    //     .map(
    //       // Grab only the *left* side of Either<Object, Post>
    //       (either) => either.leftMap((obj) {
    //         try {
    //           // Cast the Object into a Failure
    //           return obj as ServiceFailure;
    //         } catch (e) {
    //           // 'rethrow' the original exception
    //           throw obj;
    //         }
    //       }),
    //     )
    //     .run();

    // return res;
  }
}

void test() {}
