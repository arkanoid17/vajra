// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'distributor_types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DistributorTypes _$DistributorTypesFromJson(Map<String, dynamic> json) =>
    DistributorTypes(
      json['id'] as int?,
      json['name'] as String?,
      json['description'] as String?,
      json['code'] as String?,
      json['status'] as bool?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
      json['created_by'] as int?,
      json['updated_by'] as int?,
    );

Map<String, dynamic> _$DistributorTypesToJson(DistributorTypes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'code': instance.code,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'created_by': instance.createdBy,
      'updated_by': instance.updatedBy,
    };
