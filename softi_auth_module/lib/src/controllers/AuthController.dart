import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:softi_auth_module/index.dart';
import 'package:softi_core_module/index.dart';

class AuthController extends BaseController {
  static AuthController get find => Get.find<AuthController>();

  final IAuthService _auth;

  AuthController([IAuthService auth, Logger logger]) : _auth = auth ?? Get.find();

  final authUser = AuthUser().obs;

  /// GETTERS
  String get uid => authUser().uid;
  Stream<AuthUser> get authUserStream => authUser.stream;

  /// METHODS
  void init() async {
    authUser.bindStream(_auth.authUserStream.skip(0).map((event) {
      print('authUser.bindStream fired: ${event?.uid}');
      return event ?? AuthUser(uid: null);
    }));

    // _auth.errorStream.listen((event) {
    //   _logger.d('[AUTH ERROR STREAM] ' + event.toString());
    // });
  }

  /// Exposed AUTH SERVICE API
  IAuthService get api => _auth;
}
