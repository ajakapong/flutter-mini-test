import 'package:meta/meta.dart';
import 'package:my_app/models/product_modal.dart';
import 'package:my_app/pages/redux/app_reducer.dart';
import 'package:my_app/pages/redux/product/product_reducer.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

@immutable
class ProductAction {
  final ProductState productState;
  ProductAction(this.productState);
}

//action
ThunkAction<AppState> getProductAction() {
  return (Store<AppState> store) async {
    store.dispatch(ProductAction(ProductState(isLoading: true)));

    const url = 'https://api.codingthailand.com/api/course';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      // print(response.body);
      final product _product = product.fromJson(json.decode(response.body));
      store.dispatch(ProductAction(
          ProductState(isLoading: false, course: _product.course)));
    } else {
      store.dispatch(ProductAction(ProductState(isLoading: false)));
      print("Error : StatusCode ${response.statusCode}");
    }
  };
}
