// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskActivity _$TaskActivityFromJson(Map<String, dynamic> json) => TaskActivity(
      json['id'] as int?,
      json['name'] as String?,
      json['start_date'] as String?,
      json['end_date'] as String?,
      json['description'] as String?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
      json['is_active'] as bool?,
      json['type'] as int?,
      json['created_by'] as int?,
      json['updated_by'] as int?,
    );

Map<String, dynamic> _$TaskActivityToJson(TaskActivity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'description': instance.description,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'is_active': instance.isActive,
      'type': instance.type,
      'created_by': instance.createdBy,
      'updated_by': instance.updatedBy,
    };
