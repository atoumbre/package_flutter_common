import 'package:softi_common/src/core/controllers/BaseController.dart';
import 'package:softi_common/src/core/controllers/BaseService.dart';

class StoppableServiceController<T extends IStoppableService> extends IBaseLifeCycleController {
  final IStoppableService service;

  StoppableServiceController(this.service);

  @override
  void onInit() async {
    super.onInit();
    await service.start();
  }

  @override
  void onClose() async {
    super.onClose();
    await service.stop();
  }

  @override
  void onDetached() async => await service.stop();

  @override
  void onInactive() async => await service.stop();

  @override
  void onPaused() async => await service.stop();

  @override
  void onResumed() async => await service.start();
}
