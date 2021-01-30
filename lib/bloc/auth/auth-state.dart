import 'package:equatable/equatable.dart';
import 'package:now_talk/models/user.dart';

abstract class AuthState extends Equatable {
  final List _props;

  AuthState([this._props = const []]) : super();

  List<Object> get props => _props;
}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {}

class Unauthenticated extends AuthState {}

class AnonymouslyAuthenticated extends AuthState {}

class Authenticated extends AuthState {
  final UserModel user;

  Authenticated(this.user);
}
