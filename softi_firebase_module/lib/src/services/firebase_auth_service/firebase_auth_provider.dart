import 'package:firebase_auth/firebase_auth.dart';
import 'package:softi_core_module/softi_core_module.dart';

abstract class FirebaseAuthProvider {
  final FirebaseAuth firebaseAuth;

  FirebaseAuthProvider(this.firebaseAuth);

  Future<AuthUser> signInWithCredential(AuthCredential credential, {String displayName, String photoURL}) async {
    final authResult = await firebaseAuth.signInWithCredential(credential);
    final firebaseUser = authResult.user;
    if (displayName != null || photoURL != null)
      await firebaseUser.updateProfile(displayName: displayName, photoURL: photoURL);

    return userFromFirebase(firebaseUser);
  }

  AuthUser userFromFirebase(User user) {
    if (user == null) {
      return null;
    }

    user.uid;
    user.displayName;
    user.email;
    user.emailVerified;
    user.isAnonymous;
    user.metadata.lastSignInTime;
    user.metadata.creationTime;
    user.phoneNumber;
    user.photoURL;
    user.providerData;
    user.refreshToken;
    // user.multiFactor;
    // user.providerId;

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
}
