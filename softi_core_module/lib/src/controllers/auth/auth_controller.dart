import 'dart:async';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:softi_core_module/src/interfaces/auth/i_auth_service.dart';
import 'package:softi_core_module/src/models/auth_user.dart';

class AuthController {
  static AuthController get find => Get.find();

  final IAuthService _auth;
  final Logger _logger;

  IAuthService get api => _auth;

  AuthController([IAuthService auth, Logger logger])
      : _auth = auth ?? Get.find(),
        _logger = logger ?? Get.find();

  final authUser = AuthUser().obs;

  /// GETTERS
  String get uid => authUser().uid;
  Stream<AuthUser> get authUserStream => authUser.stream;

  /// METHODS

  void init() async {
    authUser(await _auth.getCurrentUser);

    await authUser.bindStream(_auth.authUserStream.skip(1).map((event) {
      return event ?? AuthUser(uid: null);
    }));

    _auth.errorStream.listen((event) {
      _logger.d('[AUTH ERROR STREAM] ' + event.toString());
    });
  }
}
