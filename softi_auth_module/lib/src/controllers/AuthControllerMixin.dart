import 'package:get/get.dart';
import 'package:softi_auth_module/index.dart';
import 'package:softi_core_module/index.dart';

mixin AuthControllerMixin on BaseController {
  IAuthService get authApi => Get.find();

  final authEventCount = 0.obs;

  final authUser = AuthUser().obs;

  /// GETTERS
  String get uid => authUser().uid;
  Stream<AuthUser> get authUserStream => authUser.stream;

  /// METHODS
  void initAuth() {
    return authUser.bindStream(authApi.authUserStream.skip(0).map((event) {
      authEventCount.value++;
      print('authUser.bindStream fired: ${event?.uid}');
      return event ?? AuthUser(uid: null);
    }));
  }
}
