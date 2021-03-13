import 'package:flutter/material.dart';

@immutable
abstract class LoginEvent {}

class OnLoginEvent extends LoginEvent {
  final String email;
  final String password;
  final bool save;

  OnLoginEvent({this.email, this.password, this.save = true});
}

class OnLogoutEvent extends LoginEvent {}