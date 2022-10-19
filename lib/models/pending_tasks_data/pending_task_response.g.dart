// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_task_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PendingTaskResponse _$PendingTaskResponseFromJson(Map<String, dynamic> json) =>
    PendingTaskResponse(
      json['page'] == null
          ? null
          : Page.fromJson(json['page'] as Map<String, dynamic>),
      json['links'] == null
          ? null
          : Link.fromJson(json['links'] as Map<String, dynamic>),
      (json['results'] as List<dynamic>?)
          ?.map((e) => PendingTask.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PendingTaskResponseToJson(
        PendingTaskResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'links': instance.links,
      'results': instance.results,
    };
