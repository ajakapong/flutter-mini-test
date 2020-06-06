import 'package:flutter/material.dart';
import 'company/company_page.dart';
import 'home/home_pages.dart';

class HomeStack extends StatelessWidget {
  const HomeStack({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'homestack/home',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'homestack/home':
            builder = (BuildContext _) => HomePage();
             print("home page");
            break;
          case 'homestack/company':
            builder = (BuildContext _) => CompanyPage();
            print("company page");
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
