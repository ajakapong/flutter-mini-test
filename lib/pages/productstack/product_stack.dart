import 'package:flutter/material.dart';
import 'product/product_page.dart';
import 'productdetail/product_detail_page.dart';

class ProductStack extends StatelessWidget {
  const ProductStack({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'productstack/product',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'productstack/product':
            builder = (BuildContext _) => ProductPage();
             print("product page");
            break;
          case 'productstack/productdetail':
            builder = (BuildContext _) => ProductDetailPage();
            print("productdetail page");
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
