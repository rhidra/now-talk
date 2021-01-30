import 'package:equatable/equatable.dart';
import 'package:now_talk/bloc/auth/auth-state.dart';

abstract class AuthEvent extends Equatable {
  final List _props;

  AuthEvent([this._props = const []]) : super();

  List<Object> get props => _props;
}

class LoginAnonymously extends AuthEvent {}

class SetUsername extends AuthEvent {
  final String username;

  SetUsername(this.username) : super([username]);
}
