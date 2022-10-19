// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_hierarchy_beat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserHierarchyBeat _$UserHierarchyBeatFromJson(Map<String, dynamic> json) =>
    UserHierarchyBeat(
      json['id'] as int?,
      (json['calendar'] as List<dynamic>?)
          ?.map(
              (e) => HierarchyBeatCalendar.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['tenant_id'] as String?,
      json['name'] as String?,
      json['description'] as String?,
      json['type'] as String?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
      json['created_by'] as int?,
      json['selected'] as bool?,
    );

Map<String, dynamic> _$UserHierarchyBeatToJson(UserHierarchyBeat instance) =>
    <String, dynamic>{
      'id': instance.id,
      'calendar': instance.calendar,
      'tenant_id': instance.tenantId,
      'name': instance.name,
      'description': instance.description,
      'type': instance.type,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'created_by': instance.createdBy,
      'selected': instance.selected,
    };
