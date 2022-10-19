// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'process_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProcessTask _$ProcessTaskFromJson(Map<String, dynamic> json) => ProcessTask(
      json['id'] as int?,
      json['name'] as String?,
      json['description'] as String?,
      json['status'] as bool?,
      json['params'] as String?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
    );

Map<String, dynamic> _$ProcessTaskToJson(ProcessTask instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'status': instance.status,
      'params': instance.params,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
