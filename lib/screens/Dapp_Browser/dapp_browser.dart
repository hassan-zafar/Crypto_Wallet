import 'package:flutter/material.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class DappBrowser extends StatefulWidget {
  static const String routeName = '/DappBrowserScreen';

  const DappBrowser({Key? key}) : super(key: key);

  @override
  _DappBrowserState createState() => _DappBrowserState();
}

class _DappBrowserState extends State<DappBrowser> {
  @override
  Widget build(BuildContext context) {
    return Container();
    // return const SafeArea(
    //   child: WebviewScaffold(
    //     withZoom: true,
    //     url: 'https://dappradar.com/rankings',
    //     withJavascript: true,
    //   ),
    // );
  }
}
