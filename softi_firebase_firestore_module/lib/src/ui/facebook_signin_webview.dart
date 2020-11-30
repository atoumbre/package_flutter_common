import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

String facebookRedirectUrl; //'https://www.facebook.com/connect/login_success.html';

Widget facebookLoginWebView(
  // BuildContext context,
  String facebookClientId,
) {
  return _CustomWebView(
    selectedUrl:
        'https://www.facebook.com/dialog/oauth?client_id=$facebookClientId&redirect_uri=$facebookRedirectUrl&response_type=token&scope=email,public_profile,',
  );
}

class _CustomWebView extends StatefulWidget {
  final String selectedUrl;

  _CustomWebView({this.selectedUrl});

  @override
  _CustomWebViewState createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<_CustomWebView> {
  final flutterWebviewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();

    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (url.contains('#access_token')) {
        succeed(url);
      }

      if (url.contains(
          'https://www.facebook.com/connect/login_success.html?error=access_denied&error_code=200&error_description=Permissions+error&error_reason=user_denied')) {
        denied();
      }
    });
  }

  void denied() {
    Navigator.pop(context);
  }

  void succeed(String url) {
    var params = url.split('access_token=');

    var endparam = params[1].split('&');

    Navigator.pop(context, endparam[0]);
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
        url: widget.selectedUrl,
        hidden: true,
        initialChild: Center(child: CircularProgressIndicator()),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(66, 103, 178, 1),
          title: Text('Facebook login'),
        ));
  }
}
