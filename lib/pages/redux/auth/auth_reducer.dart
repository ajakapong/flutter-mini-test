import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:my_app/models/product_modal.dart';

@immutable
class AuthState {
  final Map<String, dynamic> profile;
  AuthState(
      {this.profile = const {
        "email": "bob@gmail.com",
        "name": "bob",
        "role": "member"
      }});

  AuthState copyWith({Map<String, dynamic> profile}) {
    return AuthState(profile: profile ?? this.profile);
  }
}

authReducer(AuthState prevState, dynamic action) {
  return prevState;
}
