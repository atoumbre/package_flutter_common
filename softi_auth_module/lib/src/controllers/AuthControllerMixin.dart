import 'package:get/get.dart';
import 'package:softi_auth_module/index.dart';
import 'package:softi_core_module/index.dart';

mixin AuthControllerMixin on BaseController {
  static AuthController get find => Get.find<AuthController>();

  IAuthService get authApi => Get.find();

  final authUser = AuthUser().obs;

  /// GETTERS
  String get uid => authUser().uid;
  Stream<AuthUser> get authUserStream => authUser.stream;

  /// METHODS
  void initAuth() async {
    authUser.bindStream(authApi.authUserStream.skip(0).map((event) {
      print('authUser.bindStream fired: ${event?.uid}');
      return event ?? AuthUser(uid: null);
    }));

    // _auth.errorStream.listen((event) {
    //   _logger.d('[AUTH ERROR STREAM] ' + event.toString());
    // });
  }

  /// Exposed AUTH SERVICE API
  // IAuthService get authApi => _auth;
}
