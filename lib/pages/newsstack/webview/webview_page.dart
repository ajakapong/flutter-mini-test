import 'package:flutter/material.dart';

class WebViewPage extends StatefulWidget {
  WebViewPage({Key key}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(title: Text('รายละเอียดข่าว')),
      body: Text('webview')
    );
  }
}