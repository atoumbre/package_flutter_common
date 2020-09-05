import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:softi_core_module/softi_core_module.dart';
import 'package:softi_firebase_module/src/settings.dart';
import 'package:softi_firebase_module/src/ui/facebook_signin_webview.dart';

class FirebaseAuthService implements IAuthService {
  FirebaseAuthService(this.firebaseAuth, this.settings);

  final FirebaseAuth firebaseAuth;
  final FirebaseSettings settings;

  AuthUser _userFromFirebase(User user) {
    if (user == null) {
      return null;
    }

    // user.
    return AuthUser(
      uid: user.uid,
      // info
      displayName: user.displayName,
      photoUrl: user.photoURL,
      email: user.email,
      phoneNumber: user.phoneNumber,
      // account
      // providerId: user.providerData,
      isAnonymous: user.isAnonymous,
      isEmailVerified: user.emailVerified,
      creationTime: user.metadata.creationTime,
      lastSignInTime: user.metadata.lastSignInTime,
    );
  }

  Future<AuthUser> _signInWithCredential(AuthCredential credential, {String displayName, String photoURL}) async {
    final authResult = await firebaseAuth.signInWithCredential(credential);
    final firebaseUser = authResult.user;
    if (displayName != null || photoURL != null)
      await firebaseUser.updateProfile(displayName: displayName, photoURL: photoURL);

    return _userFromFirebase(firebaseUser);
  }

  Stream<AuthUser> streamCurrentUser() {
    return firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<AuthUser> getCurrentUser() async {
    final User user = firebaseAuth.currentUser;
    return _userFromFirebase(user);
  }

  Future<void> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();

    return firebaseAuth.signOut();
  }

  Future<AuthUser> linkWithCredential(AuthCredential credential) async {
    UserCredential authResult = await firebaseAuth.currentUser.linkWithCredential(credential);
    return _userFromFirebase(authResult.user);
  }

  ///! Ananymous sign in

  Future<AuthUser> signInAnonymously() async {
    final UserCredential authResult = await firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  ///! Email link sign in

  Future<AuthCredential> getCredentialForEmailAndLink(String email, String link) async {
    return EmailAuthProvider.credentialWithLink(email: email, emailLink: link);
  }

  Future<AuthUser> signInWithEmailAndLink({String email, String link}) async {
    return _signInWithCredential(await getCredentialForEmailAndLink(email, link));
  }

  Future<bool> isSignInWithEmailLink(String link) async {
    return Future.value(firebaseAuth.isSignInWithEmailLink(link));
  }

  Future<void> sendSignInWithEmailLink({@required String email}) async {
    return await firebaseAuth.sendSignInLinkToEmail(
      email: email,
      actionCodeSettings: ActionCodeSettings(
        url: settings.url,
        android: {
          'packageName': settings.androidPackageName,
          'installApp': settings.androidInstallIfNotAvailable,
          'minimumVersion': settings.androidMinimumVersion,
        },
        iOS: {
          'bundleId': settings.iOSBundleID,
        },
        // dynamicLinkDomain: null,
        // handleCodeInApp: false,
      ),
    );
  }

  ///! Google sign in

  Future<AuthCredential> getCredentialForGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        return GoogleAuthProvider.credential(
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
        clientId: settings.appleSignInClientId,
        redirectUri: Uri.parse(
          //. 'https://us-central1-resto-ci.cloudfunctions.net/appleSignInCallback',
          settings.appleSignInCallbackUrl,
        ),
      ),
    );

    final oAuthProvider = OAuthProvider('apple.com');

    return oAuthProvider.credential(
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

    String result = await navigator(facebookLoginWebView(settings.facebookClientId));

    if (result != null) {
      return FacebookAuthProvider.credential(result);
    } else {
      throw PlatformException(code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  Future<AuthUser> signInWithFacebook(dynamic context) async {
    return _signInWithCredential(await getFacebookAuthCredential(context));
  }

  ///! Email and Password sign in

  Future<AuthCredential> getCredentialForEmailPassword(String email, String password) async {
    return EmailAuthProvider.credential(email: email, password: password);
  }

  Future<AuthUser> signInWithEmailAndPassword(String email, String password) async {
    return _signInWithCredential(await getCredentialForEmailPassword(email, password));
  }

  Future<AuthUser> createUserWithEmailAndPassword(String email, String password) async {
    final UserCredential authResult =
        await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  ///! Phone sign in

  Future<AuthCredential> getCredentialForPhone(String verificationId, String smsCode) async {
    return PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
  }

  Future<AuthUser> signInWithPhone(verificationId, smsOTP) async {
    return _signInWithCredential(await getCredentialForPhone(verificationId, smsOTP));
  }

  Future<PhoneAuthResult> sendSignInWithPhoneCode({
    String phoneNumber,
    dynamic resendingId,
    bool autoRetrive = true,
    int autoRetrievalTimeoutSeconds = 30,
  }) async {
    Completer<SendCodeResult> sendCodeCompleter = Completer<SendCodeResult>();
    Completer<AuthUser> autoRetriveCompleter = Completer<AuthUser>();

    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      forceResendingToken: resendingId,
      codeSent: (verificationId, [resendingId]) {
        var result = SendCodeResult(
          phoneNumber: phoneNumber,
          codeVerification: (code) => signInWithPhone(verificationId, code),
          resendCode: () => sendSignInWithPhoneCode(
            phoneNumber: phoneNumber,
            resendingId: resendingId,
            autoRetrive: autoRetrive,
            autoRetrievalTimeoutSeconds: autoRetrievalTimeoutSeconds,
          ),
        );

        sendCodeCompleter.complete(result);
      },

      verificationFailed: (FirebaseAuthException authException) {
        sendCodeCompleter.completeError(authException);

        return;
      },

      //? Auto retrieving flow

      timeout: Duration(seconds: autoRetrive ? autoRetrievalTimeoutSeconds : 0),

      verificationCompleted: (AuthCredential authCredential) async {
        AuthUser _user = await _signInWithCredential(authCredential);
        autoRetriveCompleter.complete(_user);
      },

      codeAutoRetrievalTimeout: (String verificationId) {
        // Dismiss autoretrieve timeout
        return;
      },
    );

    return PhoneAuthResult(
      sendCodeFuture: sendCodeCompleter.future,
      autoRetriveFuture: autoRetriveCompleter.future,
    );
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
