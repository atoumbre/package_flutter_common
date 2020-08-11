abstract class IDynamicLinkService {
  registerhandleDeeplinks(DeepLinkHandler uri);
  handleDeeplinks();
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

  final Uri link;
  final int androidMinimumVersion;
  final int androidClickTimestamp;
  final String iosMinimumVersion;
}
