import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

abstract class BinderWidget<T extends GetxController> extends StatelessWidget {
  BinderWidget({Key key}) : super(key: key);

  Widget builder(T model);
  T controller();

  void ready(T model) {}
  void dispose(T model) {}

  T get con => Get.find();

  T _init() {
    // var _con;
    // try {
    //   _con = Get.find<T>();
    // } catch (e) {
    //   _con = null;
    // }

    return Get.put<T>(controller());
  }

  @override
  Widget build(BuildContext context) {
    return GetX<T>(
      init: _init(),
      builder: (ctrl) => builder(ctrl),
      dispose: (_) => dispose(con),
      initState: (_) => ready(con),
    );
    // return ObxValue<Rx<T>>((Rx<T> model) => builder(model.value), _init().obs);
  }
}
