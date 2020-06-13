import 'package:meta/meta.dart';
import 'package:my_app/pages/redux/auth/auth_reducer.dart';

@immutable
class AppState {
  final AuthState authState;

  AppState({this.authState});
  factory AppState.inittal() {
    return AppState(authState: AuthState());
  }
}

AppState appReducer(AppState state, dynamic action) {
  return AppState(authState: authReducer(state.authState, action));
}
