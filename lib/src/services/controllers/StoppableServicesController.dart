import 'package:softi_common/src/core/controllers/BaseController.dart';
import 'package:softi_common/src/core/controllers/BaseService.dart';

class StoppableServicesController extends IBaseLifeCycleController {
  final Iterable<IStoppableService> service;

  StoppableServicesController(this.service);

  @override
  void onInit() async {
    super.onInit();
    await startServices();
  }

  Future<void> startServices() async {
    await Future.wait(service.map((e) => e.start()));
  }

  Future<void> stopServices() async {
    await Future.wait(service.map((e) => e.stop()));
  }

  @override
  void onClose() async {
    super.onClose();
    await stopServices();
  }

  @override
  void onDetached() async => await stopServices();

  @override
  void onInactive() async => await stopServices();

  @override
  void onPaused() async => await stopServices();

  @override
  void onResumed() async => await startServices();
}
