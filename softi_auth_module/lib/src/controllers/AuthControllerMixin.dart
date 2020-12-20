import 'package:get/get.dart';
import 'package:softi_auth_module/index.dart';
import 'package:softi_core_module/index.dart';

mixin AuthControllerMixin on BaseController {
  IAuthService get authApi => Get.find();

  final authUser = AuthUser().obs;

  /// GETTERS
  String get uid => authUser().uid;
  Stream<AuthUser> get authUserStream => authUser.stream;

  /// METHODS
  Future<void> initAuth() async {
    authUser(await authApi.getCurrentUser);

    return authUser.bindStream(authApi.authUserStream.skip(1).map((event) {
      print('authUser.bindStream fired: ${event?.uid}');
      return event ?? AuthUser(uid: null);
    }));
  }
}
