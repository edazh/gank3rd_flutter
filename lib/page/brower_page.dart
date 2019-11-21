import 'package:flutter/material.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BrowerPage extends StatelessWidget {
  BrowerPage({Key key, this.url, this.title = 'WebView'}) : super(key: key);
  final String url;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: url,
        onWebViewCreated: (WebViewController webViewController) {
          webViewController.getTitle().then((title) => print(title));
        },
      ),
      // body: Center(
      //   child: Text('center'),
      // ),
    );
  }
}
