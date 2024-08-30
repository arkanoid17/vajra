part of 'auth_bloc_bloc.dart';

sealed class AuthBlocEvent {}

class AuthBlocInitialEvent extends AuthBlocEvent {}

class AuthLoginEvent extends AuthBlocEvent {
  final String number;
  final String password;
  final String company;

  AuthLoginEvent(
      {required this.number, required this.password, required this.company});
}

class AuthSaveUserDetailsEvent extends AuthBlocEvent {
  final AuthResp resp;

  AuthSaveUserDetailsEvent({required this.resp});
}
