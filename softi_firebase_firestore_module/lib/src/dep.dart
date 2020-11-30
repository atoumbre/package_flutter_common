import 'package:firebase_core/firebase_core.dart';

Future<void> firebaseFirestoreSetup() async {
  /// Third party lib initialization
  await Firebase.initializeApp();
}

Future<void> firebaseFirestoreInit() async {}
