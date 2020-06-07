
import 'package:flutter/material.dart';
import 'news/news_page.dart';
import 'webview/webview_page.dart';

class NewsStack extends StatelessWidget {
  const NewsStack({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'newsstack/news',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'newsstack/news':
            builder = (BuildContext _) => NewsPage();
            break;
          case 'newsstack/webview':
            builder = (BuildContext _) => WebViewPage();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}