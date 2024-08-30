import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vajra_test/cores/model/user/locations.dart';
import 'package:vajra_test/features/home/model/repositories/home_local_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final homeLocalRepository = HomeLocalRepository();

  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(_handleInitialHomeEvent);
  }

  FutureOr<void> _handleInitialHomeEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) {
    emit(HomeLoadingState());
    emit(
      HomeFetchUserData(
        name: homeLocalRepository.getUserName(),
        empId: homeLocalRepository.getEmpId(),
        loactions: homeLocalRepository.getPlaces(),
      ),
    );
  }
}
