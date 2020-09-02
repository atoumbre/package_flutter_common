import 'dart:async';

import 'package:get/get.dart';
import 'package:softi_core_module/softi_core_module.dart';

class AuthController extends GetxController {
  AuthController(this.authService, this.navService);

  final IAuthService authService; // = Get.find();
  final INavigationService navService; // = Get.find();

  List<Future Function(AuthUser)> _authStateListener = [];
  AuthUser _authUser = AuthUser();
  SendCodeResult _lastSendCodeResult;

  /// GETTERS
  AuthUser get authUser => _authUser;
  String get uid => _authUser?.uid;
  SendCodeResult get lastSendCodeResult => _lastSendCodeResult;
  var i = 0;
  Future<void> init() async {
    _authUser = await authService.getCurrentUser();
    await _updateAuthListners();

    authService.streamCurrentUser().listen((newAuthUser) async {
      if (newAuthUser?.uid == uid) return;
      print("### AuthStateChanged fired : $i");
      i++;
      _authUser = newAuthUser;
      await _updateAuthListners();

      navService.refresh();
    });
  }

  void registerAuthListner(Function(AuthUser) listner) {
    _authStateListener.add(listner);
  }

  _updateAuthListners() async {
    List<Future> _listners = _authStateListener.map<Future>((e) {
      return e(_authUser);
    }).toList();
    await Future.wait(_listners);
  }

  /// AUTH

  Future<void> signInWithGoogle() async {
    await authService.signInWithGoogle();
  }

  Future<void> signInWithApple() async {
    await authService.signInWithApple();
  }

  Future<void> sendSignInWithEmailLink(String email) async {
    await authService.sendSignInWithEmailLink(email: email);
  }

  //TODO: Add auto retrieval interval to app settings
  Future<void> sendSignInWithPhoneCode(String phoneNumber, {String resendingId}) async {
    var result = await authService.sendSignInWithPhoneCode(
      phoneNumber: phoneNumber,
      resendingId: resendingId,
    );
    _lastSendCodeResult = await result.sendCodeFuture;
  }

  Future<void> signInAnonymously() async {
    await authService.signInAnonymously();
  }

  Future<void> logout() async {
    await authService.signOut();
  }
}

class AuthListner {
  final FutureOr<void> Function(AuthUser) listner;
  final bool waitForComplition;

  AuthListner(this.listner, this.waitForComplition);
}
