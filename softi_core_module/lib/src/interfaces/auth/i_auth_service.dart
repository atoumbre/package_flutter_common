import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:softi_core_module/src/interfaces/i_base_service.dart';
import 'package:softi_core_module/src/models/auth_user.dart';

abstract class IAuthService extends IBaseService {
  Stream<AuthUser> get authUserStream;

  // Anonymous login
  Future<AuthUser> signInAnonymously();

  // Email and password
  Future<AuthUser> signInWithEmailAndPassword(String email, String password);
  Future<AuthUser> createUserWithEmailAndPassword(String email, String password);
  Future<void> sendPasswordResetEmail(String email);

  // OS Login
  Future<AuthUser> signInWithGoogle();
  Future<AuthUser> signInWithApple();

  // Social Login
  Future<AuthUser> signInWithFacebook(dynamic param);

  // Email Link login
  Future<AuthUser> signInWithEmailAndLink({String email, String link});
  Future<bool> isSignInWithEmailLink({String link});
  Future<void> sendSignInWithEmailLink({@required String email});

  // Phone login
  Future<AuthUser> signInWithPhone(verificationId, smsOTP);
  Future<PhoneAuthResult> sendSignInWithPhoneCode({
    String phoneNumber,
    dynamic resendingId,
    bool autoRetrive,
    int autoRetrievalTimeoutSeconds,
  });

  Future<void> signOut();

  void refresh();
  void dispose();
}

class PhoneAuthResult {
  final Future<SendCodeResult> sendCodeFuture;
  final Future<AuthUser> autoRetriveFuture;

  PhoneAuthResult({
    this.sendCodeFuture,
    this.autoRetriveFuture,
  });
}

class SendCodeResult {
  final Future<AuthUser> Function(String) codeVerification;
  final Future<PhoneAuthResult> Function() resendCode;
  final String phoneNumber;

  SendCodeResult({
    @required this.phoneNumber,
    this.codeVerification,
    this.resendCode,
  });
}

class AuthError extends Error {
  AuthError({this.code, this.message});
  final String code;
  final String message;
}
