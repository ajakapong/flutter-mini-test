import 'package:meta/meta.dart';

import 'auth_reducer.dart';

@immutable
class ProfileAction {
  final AuthState authState;
  ProfileAction(this.authState);
}

//action
getProfileAction(Map<String, dynamic> profile) {
  return ProfileAction(AuthState(profile: profile));
}
