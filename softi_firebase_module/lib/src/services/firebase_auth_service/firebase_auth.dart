import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:softi_core_module/softi_core_module.dart';
import 'package:softi_firebase_module/src/services/firebase_auth_service/providers/firebase_auth_apple.dart';
import 'package:softi_firebase_module/src/services/firebase_auth_service/providers/firebase_auth_email.dart';
import 'package:softi_firebase_module/src/services/firebase_auth_service/providers/firebase_auth_email_link.dart';
import 'package:softi_firebase_module/src/services/firebase_auth_service/providers/firebase_auth_facebook.dart';
import 'package:softi_firebase_module/src/services/firebase_auth_service/providers/firebase_auth_google.dart';
import 'package:softi_firebase_module/src/services/firebase_auth_service/providers/firebase_auth_phone.dart';
import 'package:softi_firebase_module/src/settings.dart';

class FirebaseAuthService implements IAuthService {
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

  final FirebaseAuth firebaseAuth;
  final FirebaseSettings settings;

  final FirebaseAppleSignin appleSignin;
  final FirebaseGoogleSignin googleSignin;
  final FirebaseAuthFacebookSignIn facebookSignin;
  final FirebaseAuthEmalPassword emailSignin;
  final FirebaseAuthPhone phoneSignin;
  final FirebaseAuthEmailLink emailLinkSignin;

  final StreamController _errorStreamController = StreamController();

  Future<T> _catchError<T>(Future<T> Function() task) {
    return task().catchError((onError) => _errorStreamController.sink.add(onError));
  }

  @override
  Stream<dynamic> get authErrorStream => _errorStreamController.stream;

  Stream<AuthUser> get authUserStream => firebaseAuth.authStateChanges().map(emailSignin.userFromFirebase);

  // AuthUser _userFromFirebase(User user) {
  //   if (user == null) {
  //     return null;
  //   }

  //   user.uid;
  //   user.displayName;
  //   user.email;
  //   user.emailVerified;
  //   user.isAnonymous;
  //   user.metadata.lastSignInTime;
  //   user.metadata.creationTime;
  //   user.phoneNumber;
  //   user.photoURL;
  //   user.providerData;
  //   user.refreshToken;
  //   // user.multiFactor;
  //   // user.providerId;

  //   // user.
  //   return AuthUser(
  //     uid: user.uid,
  //     // info
  //     displayName: user.displayName,
  //     photoUrl: user.photoURL,
  //     email: user.email,
  //     phoneNumber: user.phoneNumber,
  //     // account
  //     // providerId: user.providerData,
  //     isAnonymous: user.isAnonymous,
  //     isEmailVerified: user.emailVerified,

  //     creationTime: user.metadata.creationTime,
  //     lastSignInTime: user.metadata.lastSignInTime,
  //   );
  // }

  // Future<AuthUser> _signInWithCredential(AuthCredential credential, {String displayName, String photoURL}) async {
  //   final authResult = await firebaseAuth.signInWithCredential(credential);
  //   final firebaseUser = authResult.user;
  //   if (displayName != null || photoURL != null)
  //     await firebaseUser.updateProfile(displayName: displayName, photoURL: photoURL);

  //   return _userFromFirebase(firebaseUser);
  // }

  // Future<void> _signOut() async {
  //   final GoogleSignIn googleSignIn = GoogleSignIn();
  //   await googleSignIn.signOut();

  //   return firebaseAuth.signOut();
  // }

  // Future<AuthUser> _linkWithCredential(AuthCredential credential) async {
  //   UserCredential authResult = await firebaseAuth.currentUser.linkWithCredential(credential);
  //   return _userFromFirebase(authResult.user);
  // }

  ///! Ananymous sign in

  Future<AuthUser> _signInAnonymously() async {
    final UserCredential authResult = await firebaseAuth.signInAnonymously();
    return emailSignin.userFromFirebase(authResult.user);
  }

  Future<void> _signOut() async {
    return firebaseAuth.signOut();
  }

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
    // return _sendSignInWithPhoneCode(
    //   phoneNumber: phoneNumber,
    //   resendingId: resendingId,
    //   autoRetrive: true,
    //   autoRetrievalTimeoutSeconds: autoRetrievalTimeoutSeconds,
    // );
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
    return _catchError<AuthUser>(
      () => _signInAnonymously(),
    );
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
  Future<void> signOut() {
    return _catchError<void>(
      () => _signOut(),
    );
  }

  @override
  Future<bool> isSignInWithEmailLink({String link}) {
    return _catchError<bool>(() => emailLinkSignin.isSignInWithEmailLink(link));
  }
}
