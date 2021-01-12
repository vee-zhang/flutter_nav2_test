import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Auth extends StatelessWidget {
  final client_id =
      '77a05f59086ffbc86109c4c2a4456e498c3bca2452ec4c499a23d1412649cfb3';

  final redirect_uri = 'http://flutterbooksample.com';

  @override
  Widget build(BuildContext context) => WebView(
        javascriptMode: JavascriptMode.unrestricted,
        gestureNavigationEnabled: true,
        initialUrl:
            'https://gitee.com/oauth/authorize?client_id=${client_id}&redirect_uri=${redirect_uri}&response_type=code',
        navigationDelegate: (NavigationRequest navigation) async {
          if (await canLaunch(navigation.url)) {
            launch(navigation.url,
                enableDomStorage: true, enableJavaScript: true);
          } else {
            var i = 0;
          }
        },
      );
}
