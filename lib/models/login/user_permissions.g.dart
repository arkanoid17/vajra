// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_permissions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPermissions _$UserPermissionsFromJson(Map<String, dynamic> json) =>
    UserPermissions(
      json['id'] as int?,
      json['content_type'] as String?,
      json['name'] as String?,
      json['codename'] as String?,
    );

Map<String, dynamic> _$UserPermissionsToJson(UserPermissions instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content_type': instance.contentType,
      'name': instance.name,
      'codename': instance.codeName,
    };
