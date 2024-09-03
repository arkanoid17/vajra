part of 'sync_bloc.dart';

sealed class SyncEvent {}

class SyncStartEvent extends SyncEvent {
  final bool isForced;

  SyncStartEvent({required this.isForced});
}
