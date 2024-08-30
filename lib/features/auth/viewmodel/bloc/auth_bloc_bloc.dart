import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:vajra_test/features/auth/model/models/auth_error.dart';
import 'package:vajra_test/features/auth/model/models/auth_resp.dart';
import 'package:vajra_test/cores/model/user/locations.dart';
import 'package:vajra_test/features/auth/model/repositories/auth_remote_repository.dart';
import 'package:vajra_test/init_dependencies.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final authRemoteRepository = AuthRemoteRepository();
  final Box box = serviceLocator();

  AuthBlocBloc() : super(AuthBlocInitial()) {
    on<AuthBlocInitialEvent>(_handleAuthenticatedUser);
    on<AuthLoginEvent>(_handleLogin);
    on<AuthSaveUserDetailsEvent>(_saveUserData);
  }

  FutureOr<void> _handleLogin(
      AuthLoginEvent event, Emitter<AuthBlocState> emit) async {
    emit(AuthLoadingState());

    final resp = await authRemoteRepository.login(
        event.company, event.number, event.password);

    resp.fold(
      (error) => emit(AuthErrorState(error: error)),
      (response) => emit(
        AuthSuccessState(response: response),
      ),
    );
  }

  FutureOr<void> _saveUserData(
      AuthSaveUserDetailsEvent event, Emitter<AuthBlocState> emit) async {
    if (event.resp.data != null) {
      box.put('name', event.resp.data!.name!);
      box.put('user_id', event.resp.data!.employId!);
      box.put('id', event.resp.data!.id!);
      box.put('number', event.resp.data!.mobileNumber!);
      box.put('token', event.resp.data!.token!);
      box.put('tenant-id', event.resp.data!.tenantId);

      if (event.resp.data!.locations != null &&
          event.resp.data!.locations!.isNotEmpty) {
        Box<Locations> locationBox = serviceLocator();

        for (var location in event.resp.data!.locations!) {
          locationBox.put(location.id!, location);
        }
      }

      emit(AuthUserDetailsSaveSuccess());
    }
  }

  FutureOr<void> _handleAuthenticatedUser(
      AuthBlocInitialEvent event, Emitter<AuthBlocState> emit) async {
    String? token = box.get('token');
    if (token != null && token.isNotEmpty) {
      emit(AuthUserAuthenticated());
    } else {
      emit(AuthUserNotAuthenticated());
    }
  }
}
