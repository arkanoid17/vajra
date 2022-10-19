// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCategory _$UserCategoryFromJson(Map<String, dynamic> json) => UserCategory(
      json['id'] as int?,
      json['parent'] == null
          ? null
          : Parent.fromJson(json['parent'] as Map<String, dynamic>),
      json['tenant_id'] as String?,
      json['name'] as String?,
      json['status'] as bool?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
    );

Map<String, dynamic> _$UserCategoryToJson(UserCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'parent': instance.parent,
      'tenant_id': instance.tenantId,
      'name': instance.name,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
