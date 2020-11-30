import 'package:firebase_core/firebase_core.dart';

Future<void> firestoreDependenciesSetup() async {
  /// Third party lib initialization
  await Firebase.initializeApp();
}
