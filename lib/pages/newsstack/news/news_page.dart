import 'package:flutter/material.dart';
import 'package:my_app/widgets/menu.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Menu(),
        appBar: AppBar(title: Text('ข่าวสาร')),
        body: Text('news'));
  }
}
