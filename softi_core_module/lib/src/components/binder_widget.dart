import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

abstract class BinderWidget<T extends GetxController> extends StatelessWidget {
  BinderWidget({Key key}) : super(key: key);

  Widget builder(T model);
  T controller();

  void ready() {}
  void dispose() {}

  // T get con => Get.find<T>();

  T _init() {
    try {
      return Get.find<T>();
    } catch (e) {
      Get.put<T>(controller());
      return Get.find<T>();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MixinBuilder<T>(
      init: _init(),
      builder: builder,
      dispose: (_) => dispose(),
      initState: (_) => ready(),
    );
    // return Obx(() => builder(_init()));
  }
}
