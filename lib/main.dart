
import 'package:flutter/material.dart';
import 'package:my_app/pages/homestack/home_stack.dart';
import 'package:my_app/pages/productstack/product_stack.dart';

import 'pages/newsstack/news_stack.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // primarySwatch: Colors.yellow,
          primaryColor: Colors.yellow,
          accentColor: Colors.yellowAccent,
          canvasColor: Colors.yellow[50],
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(headline3: TextStyle(color: Colors.brown))),
      // home: HomePage(),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        "/": (context) => HomeStack(),
        "/product": (context) => ProductStack(),
         '/newsstack': (context) => NewsStack()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
