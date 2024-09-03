part of 'sync_bloc.dart';

sealed class SyncState {}

final class SyncInitial extends SyncState {}

class SyncSuccessState extends SyncState {}

class SyncErrorState extends SyncState {}

class NoSyncState extends SyncState {}

class SyncLoadingState extends SyncState {}
