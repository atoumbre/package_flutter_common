import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:softi_core_module/softi_core_module.dart';
import 'package:softi_firebase_module/src/services/firebase_auth_service/firebase_auth_provider.dart';
import 'package:softi_firebase_module/src/services/firebase_auth_service/providers/firebase_auth_apple.dart';
import 'package:softi_firebase_module/src/services/firebase_auth_service/providers/firebase_auth_email.dart';
import 'package:softi_firebase_module/src/services/firebase_auth_service/providers/firebase_auth_email_link.dart';
import 'package:softi_firebase_module/src/services/firebase_auth_service/providers/firebase_auth_facebook.dart';
import 'package:softi_firebase_module/src/services/firebase_auth_service/providers/firebase_auth_google.dart';
import 'package:softi_firebase_module/src/services/firebase_auth_service/providers/firebase_auth_phone.dart';
import 'package:softi_firebase_module/src/settings.dart';

class FirebaseAuthService implements IAuthService {
  final FirebaseAuth firebaseAuth;
  final FirebaseSettings settings;

  FirebaseAuthService(this.firebaseAuth, this.settings)
      : appleSignin = FirebaseAppleSignin(
          firebaseAuth,
          appleSignInCallbackUrl: settings.appleSignInCallbackUrl,
          appleSignInClientId: settings.appleSignInClientId,
        ),
        facebookSignin = FirebaseAuthFacebookSignIn(
          firebaseAuth,
          facebookClientId: settings.facebookClientId,
        ),
        emailLinkSignin = FirebaseAuthEmailLink(
          firebaseAuth,
          actionCodeSettings: ActionCodeSettings(
            url: settings.url,
            //
            androidMinimumVersion: settings.androidMinimumVersion,
            androidInstallApp: settings.androidInstallIfNotAvailable,
            androidPackageName: settings.androidPackageName,
            //
            iOSBundleId: settings.iOSBundleID,
            handleCodeInApp: true,
            // dynamicLinkDomain: null,
          ),
        ),
        googleSignin = FirebaseGoogleSignin(firebaseAuth),
        emailSignin = FirebaseAuthEmalPassword(firebaseAuth),
        phoneSignin = FirebaseAuthPhone(firebaseAuth);

  final FirebaseAppleSignin appleSignin;
  final FirebaseGoogleSignin googleSignin;
  final FirebaseAuthFacebookSignIn facebookSignin;
  final FirebaseAuthEmalPassword emailSignin;
  final FirebaseAuthPhone phoneSignin;
  final FirebaseAuthEmailLink emailLinkSignin;

  final StreamController _errorStreamController = StreamController();

  Future<FirebaseAuthService> init() async {
    await Firebase.initializeApp();
    return this;
  }

  Future<T> _catchError<T>(Future<T> Function() task) {
    return task().catchError((onError) => _errorStreamController.sink.add(onError));
  }

  @override
  Stream<dynamic> get errorStream => _errorStreamController.stream;

  @override
  Stream<AuthUser> get authUserStream => firebaseAuth.authStateChanges().map(FirebaseAuthProvider.userFromFirebase);

  @override
  void refresh() {
    // TODO: implement refresh
  }

  @override
  void dispose() {
    _errorStreamController.close();
  }

  @override
  Future<AuthUser> createUserWithEmailAndPassword(String email, String password) {
    return _catchError<AuthUser>(() => emailSignin.createUserWithEmailAndPassword(email, password));
  }

  @override
  Future<void> sendPasswordResetEmail(String email) {
    return _catchError<void>(() => emailSignin.sendPasswordResetEmail(email));
  }

  @override
  Future<void> sendSignInWithEmailLink({String email}) {
    return _catchError<void>(() => emailLinkSignin.sendSignInWithEmailLink(email: email));
  }

  @override
  Future<PhoneAuthResult> sendSignInWithPhoneCode({
    String phoneNumber,
    resendingId,
    bool autoRetrive,
    int autoRetrievalTimeoutSeconds = 30,
  }) {
    return _catchError<PhoneAuthResult>(
      () => phoneSignin.sendSignInWithPhoneCode(
        phoneNumber: phoneNumber,
        resendingId: resendingId,
        autoRetrive: true,
        autoRetrievalTimeoutSeconds: autoRetrievalTimeoutSeconds,
      ),
    );
  }

  @override
  Future<AuthUser> signInAnonymously() {
    return _catchError<AuthUser>(() async {
      final UserCredential authResult = await firebaseAuth.signInAnonymously();
      return FirebaseAuthProvider.userFromFirebase(authResult.user);
    });
  }

  @override
  Future<AuthUser> signInWithApple() {
    return _catchError<AuthUser>(() => appleSignin.signInWithApple());
  }

  @override
  Future<AuthUser> signInWithEmailAndLink({String email, String link}) {
    return _catchError<AuthUser>(() => emailLinkSignin.signInWithEmailAndLink(email: email, link: link));
  }

  @override
  Future<AuthUser> signInWithEmailAndPassword(String email, String password) {
    return _catchError<AuthUser>(() => emailSignin.signInWithEmailAndPassword(email, password));
  }

  @override
  Future<AuthUser> signInWithFacebook(param) {
    return _catchError<AuthUser>(() => facebookSignin.signInWithFacebook(param));
  }

  @override
  Future<AuthUser> signInWithGoogle() {
    return _catchError<AuthUser>(() => googleSignin.signInWithGoogle());
  }

  @override
  Future<AuthUser> signInWithPhone(verificationId, smsOTP) {
    return _catchError<AuthUser>(() => phoneSignin.signInWithPhone(verificationId, smsOTP));
  }

  @override
  Future<bool> isSignInWithEmailLink({String link}) {
    return _catchError<bool>(() => emailLinkSignin.isSignInWithEmailLink(link));
  }

  @override
  Future<void> signOut() {
    return _catchError<void>(() => firebaseAuth.signOut());
  }
}
