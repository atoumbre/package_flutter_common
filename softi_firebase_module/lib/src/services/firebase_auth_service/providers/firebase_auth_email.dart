import 'package:firebase_auth/firebase_auth.dart';
import 'package:softi_core_module/softi_core_module.dart';
import 'package:softi_firebase_module/src/services/firebase_auth_service/firebase_auth_provider.dart';

class FirebaseAuthEmalPassword extends FirebaseAuthProvider {
  FirebaseAuthEmalPassword(FirebaseAuth firebaseAuth) : super(firebaseAuth);

  Future<AuthCredential> getCredentialForEmailPassword(String email, String password) async {
    return EmailAuthProvider.credential(email: email, password: password);
  }

  Future<AuthUser> signInWithEmailAndPassword(String email, String password) async {
    return signInWithCredential(await getCredentialForEmailPassword(email, password));
  }

  Future<AuthUser> createUserWithEmailAndPassword(String email, String password) async {
    final UserCredential authResult =
        await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return FirebaseAuthProvider.userFromFirebase(authResult.user);
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
