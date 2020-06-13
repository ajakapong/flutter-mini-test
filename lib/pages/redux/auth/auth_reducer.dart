import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:my_app/pages/redux/auth/auth_action.dart';

@immutable
class AuthState {
  final Map<String, dynamic> profile;
  AuthState(
      {this.profile = const {
        "email": "",
        "name": "",
        "role": ""
      }});

  AuthState copyWith({Map<String, dynamic> profile}) {
    return AuthState(profile: profile ?? this.profile);
  }
}

authReducer(AuthState prevState, dynamic action) {
  if(action is ProfileAction) {
    return prevState.copyWith(
      profile: action.authState.profile
    );
  }
  return prevState;
}
