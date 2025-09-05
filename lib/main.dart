import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


void main() {
WidgetsFlutterBinding.ensureInitialized();
// Android-specific: required for some Android versions
if (Platform.isAndroid) {
WebView.platform = AndroidWebView();
}
runApp(const MyApp());
}


class MyApp extends StatelessWidget {
const MyApp({Key? key}) : super(key: key);
final String initialUrl = 'https://www.mahamayastationery.com/shop';


@override
Widget build(BuildContext context) {
return MaterialApp(
debugShowCheckedModeBanner: false,
title: 'Mahamaya Stationery',
theme: ThemeData(
primarySwatch: Colors.blue,
),
home: WebAppHome(url: initialUrl),
);
}
}


class WebAppHome extends StatefulWidget {
final String url;
const WebAppHome({Key? key, required this.url}) : super(key: key);


@override
State<WebAppHome> createState() => _WebAppHomeState();
}


class _WebAppHomeState extends State<WebAppHome> {
late final WebViewController _controller;
bool _isLoading = true;


@override
void initState() {
super.initState();
_controller = WebViewController()
..setJavaScriptMode(JavaScriptMode.unrestricted)
..setNavigationDelegate(
NavigationDelegate(
onPageStarted: (url) => setState(() => _isLoading = true),
onPageFinished: (url) => setState(() => _isLoading = false),
onNavigationRequest: (req) {
// अगर external link हो तो ब्राउज़र में खोलना चाहें
final uri = Uri.tryParse(req.url);
if (uri != null && !_isSameHost(uri)) {
_launchExternalUrl(req.url);
return NavigationDecision.prevent;
}
return NavigationDecision.navigate;
},
),
)
}
