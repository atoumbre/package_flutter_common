import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:softi_core_module/softi_core_module.dart';
import 'package:softi_firebase_module/src/settings.dart';

class FirebaseDeeplinkService implements IDynamicLinkService {
  FirebaseDeeplinkService(this.settings);

  final FirebaseSettings settings;
  final FirebaseDynamicLinks deepLinkInstance = FirebaseDynamicLinks.instance;

  List<DeepLinkHandler> _deepLinkHandler = [];

  Future<void> handleDeeplinks() async {
    // Get the initial dynamic link if the app is opened with a dynamic link
    final PendingDynamicLinkData data = await deepLinkInstance.getInitialLink();

    // handle link that has been retrieved
    _handleDeeplink(data);

    // Register a link callback to fire if the app is opened up from the background
    // using a dynamic link.
    FirebaseDynamicLinks.instance.onLink(
      onSuccess: (PendingDynamicLinkData dynamicLink) async {
        // handle link that has been retrieved
        _handleDeeplink(dynamicLink);
      },
      onError: (OnLinkErrorException e) async {
        print('DeepLink Failed: ${e.message}');
      },
    );
  }

  // DeepLink handler helper
  void _handleDeeplink(PendingDynamicLinkData data) async {
    if (data == null) return;

    DynamicLinkData _data = DynamicLinkData(
      link: data.link,
      iosMinimumVersion: data.ios.minimumVersion,
      androidMinimumVersion: data?.android?.minimumVersion,
      androidClickTimestamp: data?.android?.clickTimestamp,
    );

    // bool _stop = false;
    // _deepLinkHandler.takeWhile((_) => _stop).forEach((element) {
    _deepLinkHandler.forEach((element) {
      element.handler(_data);
      // _stop = element.stopAfter ?? false;
    });
  }

  registerhandleDeeplinks(deepLinkHandler) {
    _deepLinkHandler.add(deepLinkHandler);
  }

  /// create a
  Future<String> createDeepLink(String queryString) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: settings.dynamicLinkPrefix,
      link: Uri.parse('${settings.url}/?$queryString'),

      dynamicLinkParametersOptions: DynamicLinkParametersOptions(
        shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
      ),

      // ANDROID
      androidParameters: AndroidParameters(
        packageName: settings.androidPackageName,
        minimumVersion: int.parse(settings.androidMinimumVersion),
      ),

      // IOS
      iosParameters: IosParameters(
        bundleId: settings.iOSBundleID,
        appStoreId: settings.appStoreId,
        minimumVersion: settings.iOSMinimumVersion,
      ),
    );

    final Uri dynamicUrl = await parameters.buildUrl();

    return dynamicUrl.toString();
  }
}
