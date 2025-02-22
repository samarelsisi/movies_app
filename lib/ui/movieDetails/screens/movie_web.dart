import 'package:flutter/material.dart';
import 'package:movies/theme/app_style.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MovieWebViewScreen extends StatelessWidget {
  final String url;

  const MovieWebViewScreen({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text("Watch Movie",style: AppStyle.regular16WhiteRoboto,)),
      body: WebViewWidget(controller: WebViewController()..loadRequest(Uri.parse(url))),
    );
  }
}
