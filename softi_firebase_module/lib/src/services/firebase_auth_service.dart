import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:softi_db_module/softi_db_module.dart';
import 'package:softi_firebase_module/src/settings.dart';
import 'package:softi_firebase_module/src/ui/facebook_signin_webview.dart';

class FirebaseAuthService implements IAuthService {
  FirebaseAuthService(this.firebaseAuth, this.settings);

  final FirebaseAuth firebaseAuth;
  final FirebaseSettings settings;

  AuthUser _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    }

    // user.
    return AuthUser(
      uid: user.uid,
      // info
      displayName: user.displayName,
      photoUrl: user.photoUrl,
      email: user.email,
      phoneNumber: user.phoneNumber,
      // account
      providerId: user.providerId,
      isAnonymous: user.isAnonymous,
      isEmailVerified: user.isEmailVerified,
      creationTime: user.metadata.creationTime,
      lastSignInTime: user.metadata.lastSignInTime,
    );
  }

  Future<AuthUser> _signInWithCredential(AuthCredential credential, [UserUpdateInfo updateUser]) async {
    final authResult = await firebaseAuth.signInWithCredential(credential);
    final firebaseUser = authResult.user;
    if (updateUser != null) await firebaseUser.updateProfile(updateUser);

    return _userFromFirebase(firebaseUser);
  }

  Stream<AuthUser> streamCurrentUser() {
    return firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  Future<AuthUser> getCurrentUser() async {
    final FirebaseUser user = await firebaseAuth.currentUser();
    return _userFromFirebase(user);
  }

  Future<void> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();

    return firebaseAuth.signOut();
  }

  Future<AuthUser> linkWithCredential(AuthCredential credential) async {
    AuthResult authResult = await (await firebaseAuth.currentUser()).linkWithCredential(credential);
    return _userFromFirebase(authResult.user);
  }

  ///! Ananymous sign in

  Future<AuthUser> signInAnonymously() async {
    final AuthResult authResult = await firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  ///! Email link sign in

  Future<AuthCredential> getCredentialForEmailAndLink(String email, String link) async {
    return EmailAuthProvider.getCredentialWithLink(email: email, link: link);
  }

  Future<AuthUser> signInWithEmailAndLink({String email, String link}) async {
    return _signInWithCredential(await getCredentialForEmailAndLink(email, link));
  }

  Future<bool> isSignInWithEmailLink(String link) async {
    return await firebaseAuth.isSignInWithEmailLink(link);
  }

  Future<void> sendSignInWithEmailLink({@required String email}) async {
    return await firebaseAuth.sendSignInWithEmailLink(
      email: email,
      url: settings.url,
      iOSBundleID: settings.iOSBundleID,
      androidPackageName: settings.androidPackageName,
      androidInstallIfNotAvailable: settings.androidInstallIfNotAvailable,
      androidMinimumVersion: settings.androidMinimumVersion,
      handleCodeInApp: true,
    );
  }

  ///! Google sign in

  Future<AuthCredential> getCredentialForGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        return GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );
      } else {
        throw PlatformException(code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN', message: 'Missing Google Auth Token');
      }
    } else {
      throw PlatformException(code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  Future<AuthUser> signInWithGoogle() async => _signInWithCredential(await getCredentialForGoogle());

  ///! Apple sign in

  Future<AuthCredential> getCredentialForApple() async {
    final appleIdCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      webAuthenticationOptions: WebAuthenticationOptions(
        // clientId: 'com.winsoluce.resto',
        clientId: settings.appleSignInClientId,
        redirectUri: Uri.parse(
          //. 'https://us-central1-resto-ci.cloudfunctions.net/appleSignInCallback',
          settings.appleSignInCallbackUrl,
        ),
      ),
    );

    final oAuthProvider = OAuthProvider(providerId: 'apple.com');

    return oAuthProvider.getCredential(
      idToken: appleIdCredential.identityToken,
      accessToken: appleIdCredential.authorizationCode,
    );
  }

  Future<AuthUser> signInWithApple() async => _signInWithCredential(await getCredentialForApple());

  ///! Facebook Sign in

  Future<AuthCredential> getFacebookAuthCredential(Future<String> Function(Widget) navigator) async {
    // String result = await Navigator.push(
    //   context,
    //   //! CustomWebView for Facebook login
    //   MaterialPageRoute(
    //     builder: (context) => getFacebookLoginWebView(context, settings.facebookClientId),
    //     maintainState: true,
    //   ),
    // );

    String result = await navigator(getFacebookLoginWebView(settings.facebookClientId));

    if (result != null) {
      return FacebookAuthProvider.getCredential(accessToken: result);
    } else {
      throw PlatformException(code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  Future<AuthUser> signInWithFacebook(dynamic context) async {
    return _signInWithCredential(await getFacebookAuthCredential(context));
  }

  ///! Email and Password sign in

  Future<AuthCredential> getCredentialForEmailPassword(String email, String password) async {
    return EmailAuthProvider.getCredential(email: email, password: password);
  }

  Future<AuthUser> signInWithEmailAndPassword(String email, String password) async {
    return _signInWithCredential(await getCredentialForEmailPassword(email, password));
  }

  Future<AuthUser> createUserWithEmailAndPassword(String email, String password) async {
    final AuthResult authResult = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  ///! Phone sign in

  Future<AuthCredential> getCredentialForPhone(String verificationId, String smsCode) async {
    return PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: smsCode);
  }

  Future<AuthUser> signInWithPhone(verificationId, smsOTP) async {
    return _signInWithCredential(await getCredentialForPhone(verificationId, smsOTP));
  }

  Future<PhoneCodeResult> sendSignInWithPhoneCode({
    String phoneNumber,
    dynamic resendingId,
    bool autoRetrive = true,
    int autoRetrievalTimeoutSeconds = 30,
  }) async {
    Completer<PhoneCodeResult> sendCodeCompleter;

    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      forceResendingToken: resendingId,
      codeSent: (verificationId, [resendingId]) {
        sendCodeCompleter.complete(PhoneCodeResult(
          verificationId: verificationId,
          resendindId: resendingId,
        ));
      },

      verificationFailed: (AuthException authException) {
        sendCodeCompleter.completeError(authException);
        return;
      },

      //? Auto retrieving flow

      timeout: Duration(seconds: autoRetrive ? autoRetrievalTimeoutSeconds : 0),

      verificationCompleted: (AuthCredential authCredential) async {
        sendCodeCompleter.complete(PhoneCodeResult(
          authCredential: authCredential,
        ));
      },

      codeAutoRetrievalTimeout: (String verificationId) {
        return;
      },
    );

    return sendCodeCompleter.future;
  }

  @override
  void refresh() {
    // TODO: implement refresh
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
