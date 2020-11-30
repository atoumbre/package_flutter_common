import 'package:firebase_core/firebase_core.dart';

Future<void> firebaseAuthSetup() async {
  /// Third party lib initialization
  await Firebase.initializeApp();
}

Future<void> firebaseAuthInit() async {}
