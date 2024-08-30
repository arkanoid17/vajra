part of 'auth_bloc_bloc.dart';

sealed class AuthBlocState {}

final class AuthBlocInitial extends AuthBlocState {}

class AuthLoadingState extends AuthBlocState {}

class AuthSuccessState extends AuthBlocState {
  final AuthResp response;

  AuthSuccessState({required this.response});
}

class AuthErrorState extends AuthBlocState {
  final AuthError error;

  AuthErrorState({required this.error});
}

class AuthUserDetailsSaveSuccess extends AuthBlocState {}

class AuthUserAuthenticated extends AuthBlocState {}

class AuthUserNotAuthenticated extends AuthBlocState {}
