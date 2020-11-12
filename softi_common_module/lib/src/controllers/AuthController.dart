import 'dart:async';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:softi_core_module/softi_core_module.dart';

class AuthController extends GetxController {
  static AuthController get find => Get.find();

  final IAuthService _auth;
  final Logger _logger;

  AuthController([IAuthService auth, Logger logger])
      : _auth = auth ?? Get.find(),
        _logger = logger ?? Get.find();

  final authUser = AuthUser().obs;

  /// GETTERS
  String get uid => authUser().uid;
  Stream<AuthUser> get authUserStream => authUser.stream;

  /// METHODS

  void init() async {
    // var _authUser = await _auth.getCurrentUser;

    authUser((await _auth.getCurrentUser) ?? AuthUser(uid: null));

    authUser.bindStream(_auth.authUserStream.map((event) {
      return event ?? AuthUser(uid: null);
    }));

    _auth.errorStream.listen((event) {
      _logger.d('[AUTH ERROR STREAM] ' + event.toString());
    });
  }

  /// AUTH METHODS
  IAuthService get api => _auth;
}
