// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserGroup _$UserGroupFromJson(Map<String, dynamic> json) => UserGroup(
      json['id'] as int?,
      (json['permissions'] as List<dynamic>?)
          ?.map((e) => UserPermissions.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['name'] as String?,
      json['tenant_id'] as String?,
    );

Map<String, dynamic> _$UserGroupToJson(UserGroup instance) => <String, dynamic>{
      'id': instance.id,
      'permissions': instance.permissions,
      'name': instance.name,
      'tenant_id': instance.tenantId,
    };
