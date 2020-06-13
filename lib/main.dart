import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_app/pages/homestack/home_stack.dart';
import 'package:my_app/pages/login/login_page.dart';
import 'package:my_app/pages/productstack/product_stack.dart';
import 'package:my_app/pages/redux/app_reducer.dart';
import 'package:my_app/pages/register/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/newsstack/news_stack.dart';
import 'package:redux/redux.dart';

String token;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  token = prefs.getString('token');

  final _store = Store<AppState>(appReducer, initialState: AppState.inittal());

  runApp(MyApp(store: _store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  MyApp({this.store});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
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
            //  "/": (context) => HomeStack(),
            "/": (context) => token == null ? LoginPage() : HomeStack(),
            "/login": (context) => LoginPage(),
            "/homestack": (context) => HomeStack(),
            "/register": (context) => RegisterPage(),
            "/product": (context) => ProductStack(),
            '/newsstack': (context) => NewsStack()
          },
          debugShowCheckedModeBanner: false,
        ));
  }
}
