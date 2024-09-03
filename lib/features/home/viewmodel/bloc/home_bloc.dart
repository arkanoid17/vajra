import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:vajra_test/cores/model/user/locations.dart';
import 'package:vajra_test/features/home/model/repositories/home_local_repository.dart';
import 'package:vajra_test/init_dependencies.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final homeLocalRepository = HomeLocalRepository();

  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(_handleInitialHomeEvent);
    on<HomeSyncCompleted>(_handleSyncUpdated);
  }

  FutureOr<void> _handleInitialHomeEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) {
    emit(HomeLoadingState());
    emit(
      HomeFetchUserData(
          name: homeLocalRepository.getUserName(),
          empId: homeLocalRepository.getEmpId(),
          loactions: homeLocalRepository.getPlaces(),
          lastSyncTime: homeLocalRepository.getLastSyncTime()),
    );
  }

  FutureOr<void> _handleSyncUpdated(
      HomeSyncCompleted event, Emitter<HomeState> emit) {
    Box box = serviceLocator();
    box.put('last_sync_time', event.lastSyncTime);
    emit(HomeSyncTimeUpdated(lastSyncTime: event.lastSyncTime));
  }
}
