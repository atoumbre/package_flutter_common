import 'package:softi_common/src/core/controllers/BaseService.dart';

abstract class IDynamicLinkService extends IBaseService {
  /// Resgister deeplink handler
  /// Many handlers can be registered, incomimg deepLink will be pass through
  /// all of them
  ///
  void registerhandleDeeplinks(DeepLinkHandler handler);

  /// Initiate handling of deepLinks
  void handleDeeplinks();

  /// Create DeepLink
  Future<String> createDeepLink(String queryString);
}

class DeepLinkHandler {
  DeepLinkHandler(this.handler, {this.stopAfter = false});

  final bool stopAfter;
  final Function(DynamicLinkData) handler;
}

class DynamicLinkData {
  DynamicLinkData({
    this.iosMinimumVersion,
    this.link,
    this.androidMinimumVersion,
    this.androidClickTimestamp,
  });

  final Uri? link;
  final int? androidMinimumVersion;
  final int? androidClickTimestamp;
  final String? iosMinimumVersion;
}
