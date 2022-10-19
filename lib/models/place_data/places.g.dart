// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'places.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Places _$PlacesFromJson(Map<String, dynamic> json) => Places(
      json['id'] as int?,
      json['tenant_id'] as String?,
      json['name'] as String?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
      json['is_territory'] as bool?,
      json['type'] as int?,
      json['parent'] as int?,
    );

Map<String, dynamic> _$PlacesToJson(Places instance) => <String, dynamic>{
      'id': instance.id,
      'tenant_id': instance.tenantId,
      'name': instance.name,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'is_territory': instance.isTerritory,
      'type': instance.type,
      'parent': instance.parent,
    };
