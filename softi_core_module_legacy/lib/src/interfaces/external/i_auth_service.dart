import 'dart:async';

import 'package:softi_core_module/src/models/auth_user/auth_user.dart';
import 'package:flutter/foundation.dart';

abstract class IAuthService {
  Stream<AuthUser> streamCurrentUser();
  Future<AuthUser> getCurrentUser();

  Future<AuthUser> signInAnonymously();

  // Email and password
  Future<AuthUser> signInWithEmailAndPassword(String email, String password);
  Future<AuthUser> createUserWithEmailAndPassword(String email, String password);
  Future<void> sendPasswordResetEmail(String email);

  // Social Login
  Future<AuthUser> signInWithGoogle();
  Future<AuthUser> signInWithApple();
  Future<AuthUser> signInWithFacebook(dynamic param);

  // Phone login
  Future<AuthUser> signInWithPhone(verificationId, smsOTP);
  Future<PhoneCodeResult> sendSignInWithPhoneCode({
    String phoneNumber,
    dynamic resendingId,
    bool autoRetrive,
    int autoRetrievalTimeoutSeconds,

    // Function(String, [int]) codeSent,
    // Function(String) codeAutoRetrievalTimeout,
    // Function(AuthUser) authCompleted,
    // Function(Exception) authFailed,
    // int autoRetrievalTimeoutSeconds,
  });

  //Email Link login
  Future<AuthUser> signInWithEmailAndLink({String email, String link});
  Future<bool> isSignInWithEmailLink(String link);
  Future<void> sendSignInWithEmailLink({
    @required String email,
  });

  Future<void> signOut();

  void dispose();
}

class PhoneCodeResult {
  final String verificationId;
  final dynamic resendindId;
  final AuthUser authUser;

  PhoneCodeResult({this.verificationId, this.resendindId, this.authUser});
}
