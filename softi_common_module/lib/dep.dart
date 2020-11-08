// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:logger/logger.dart';
// import 'package:market_core/src/constants/settings.dart';
// import 'package:market_core/src/controllers/app_controller.dart';
// import 'package:market_core/src/controllers/auth_controller.dart';
// import 'package:market_core/src/controllers/user_controller.dart';
// import 'package:market_core/src/providers/db_resources.dart';
// import 'package:market_core/src/services/helpers_services/sizing.dart';
// import 'package:market_core/src/services/helpers_services/spacing.dart';
// import 'package:softi_common_module/softi_common_module.dart';
// import 'package:softi_core_module/softi_core_module.dart';
// import 'package:softi_firebase_module/softi_firebase_module.dart';
// import 'package:stacked_services/stacked_services.dart' show DialogService, SnackbarService;

// Future<void> setupCoreDependencies() async {
//   /// Third party lib initialization
//   await Future.wait([
//     Firebase.initializeApp(),
//     GetStorage.init(),
//   ]);

//   await FirebaseStorage.instance.setMaxUploadRetryTime(Duration(minutes: 5));

//   Get.put<Logger>(Logger(printer: PrettyPrinter()));
//   Get.put<Logger>(Logger(printer: PrettyPrinter()), tag: 'NoStack');

//   var firebaseAuthService = FirebaseAuthService(
//     FirebaseAuth.instance,
//     firebaseSettings,
//   );

//   var firebaseDeeplinkService = FirebaseDeeplinkService(
//     firebaseSettings,
//   );

//   ///Auth and DB Services
//   Get.put<IAuthService>(firebaseAuthService);
//   Get.put<ICollectionService>(FirestoreCollectionService(FirebaseFirestore.instance));

//   /// External services
//   Get.put<IDynamicLinkService>(firebaseDeeplinkService);
//   Get.put<IRemoteStorageService>(FirebaseStorageService());

//   /// Device services
//   Get.put<ILocationService>(LocationService());
//   Get.put<IMediaPicker>(MediaPicker());

//   /// App services
//   Get.put<IAlertService>(DefaultAlertService());
//   Get.put<ILocalStore>(DefaultLocalStore());
//   Get.put<INavigationService>(NavigationService());
//   Get.put<DialogService>(DialogService());
//   Get.put<SnackbarService>(SnackbarService());

//   ///
//   Get.put<AuthController>(AuthController());
//   Get.put<UserController>(UserController());
//   Get.put<DatabaseController>(DatabaseController(Get.find(), resourceMapper));
//   Get.put<AppController>(AppController());

//   ///
//   Get.put<Sizing>(Sizing());
//   Get.put<Spacing>(Spacing());

//   /// Aditionnal Services setup
//   // Firebase
// }

// /// Controllers
// class CoreState {
//   static AppController get app => Get.find();
//   static UserController get user => Get.find();
//   static AuthController get auth => Get.find();
//   static DatabaseController get db => Get.find();
// }

// /// Services
// class CoreServices {
//   static IAuthService get auth => Get.find();
//   static IDynamicLinkService get dynLink => Get.find();
//   static IAlertService get alert => Get.find();
//   static ILocalStore get store => Get.find();
//   static INavigationService get nav => Get.find();
//   static ILocationService get location => Get.find();
//   static IRemoteConfigService get remoteConfig => Get.find();
//   static IRemoteStorageService get cloudStorage => Get.find();
//   static IMediaPicker get mediaPicker => Get.find();

//   ///
//   static DialogService get dialog => Get.find<DialogService>();
//   static SnackbarService get snack => Get.find<SnackbarService>();
// }

// /// Helpers Services
// class CoreHelpers {
//   static Sizing get sizing => Get.find();
//   static Spacing get spacing => Get.find();
//   static Logger get logger => Get.find<Logger>();
//   static Logger get loggerNoStack => Get.find<Logger>(tag: 'NoStack');
// }
