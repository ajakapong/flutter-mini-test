import 'package:meta/meta.dart';
import 'package:my_app/pages/redux/auth/auth_reducer.dart';
import 'package:my_app/pages/redux/product/product_reducer.dart';

@immutable
class AppState {
  final AuthState authState;
  final ProductState productState;

  AppState({this.authState, this.productState});
  factory AppState.inittal() {
    return AppState(authState: AuthState(), productState: ProductState());
  }
}

AppState appReducer(AppState state, dynamic action) {
  return AppState(
      authState: authReducer(state.authState, action),
      productState: productReducer(state.productState, action));
}
