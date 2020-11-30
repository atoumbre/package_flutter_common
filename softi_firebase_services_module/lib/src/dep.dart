import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:softi_core_module/softi_core_module.dart';
import 'package:softi_firebase_auth_module/index.dart';
import 'package:softi_firebase_services_module/src/services/firebase_deeplink_service.dart';

Future<void> firebaseDependenciesSetup(FirebaseSettings firebaseSettings) async {
  /// Third party lib initialization
  await Firebase.initializeApp();

  // Global setings
  FirebaseStorage.instance.setMaxUploadRetryTime(Duration(minutes: 5));

  var firebaseDeeplinkService = FirebaseDeeplinkService(
    firebaseSettings,
  );

  ///  Services
  Get.put<IDynamicLinkService>(firebaseDeeplinkService);
}

Future<void> firebaseServicesInit(ILocalStore store, FirebaseAuthService auth) async {
  /// Handle dynamic links
  Get.find<IDynamicLinkService>().registerhandleDeeplinks(DeepLinkHandler((deepLink) async {
    var _authLink = deepLink.link.toString();
    if (await auth.isSignInWithEmailLink(link: _authLink)) {
      var email = await store.getSecuredKey('UserEmail');
      await auth.signInWithEmailAndLink(email: email, link: deepLink.link.toString());
    }
  }));

  Get.find<IDynamicLinkService>().handleDeeplinks();
}
