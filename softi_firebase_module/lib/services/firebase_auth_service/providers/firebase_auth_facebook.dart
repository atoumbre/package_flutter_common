import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:softi_core_module/softi_core_module.dart';
import 'package:softi_firebase_module/services/firebase_auth_service/firebase_auth_provider.dart';
import 'package:softi_firebase_module/ui/facebook_signin_webview.dart';

class FirebaseAuthFacebookSignIn extends FirebaseAuthProvider {
  final String facebookClientId;

  FirebaseAuthFacebookSignIn(FirebaseAuth firebaseAuth, {this.facebookClientId}) : super(firebaseAuth);

  Future<AuthCredential> getFacebookAuthCredential(Future<String> Function(Widget) navigator) async {
    // String result = await Navigator.push(
    //   context,
    //   //! CustomWebView for Facebook login
    //   MaterialPageRoute(
    //     builder: (context) => getFacebookLoginWebView(context, settings.facebookClientId),
    //     maintainState: true,
    //   ),
    // );

    var result = await navigator(facebookLoginWebView(facebookClientId));

    if (result != null) {
      return FacebookAuthProvider.credential(result);
    } else {
      throw PlatformException(code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  Future<AuthUser> signInWithFacebook(dynamic context) async {
    return signInWithCredential(await getFacebookAuthCredential(context));
  }
}
