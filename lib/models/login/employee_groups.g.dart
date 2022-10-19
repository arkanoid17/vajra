// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_groups.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeGroups _$EmployeeGroupsFromJson(Map<String, dynamic> json) =>
    EmployeeGroups(
      json['id'] as int?,
      (json['permissions'] as List<dynamic>?)
          ?.map((e) => UserPermissions.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['name'] as String?,
      json['tenant_id'] as String?,
    );

Map<String, dynamic> _$EmployeeGroupsToJson(EmployeeGroups instance) =>
    <String, dynamic>{
      'id': instance.id,
      'permissions': instance.permissions,
      'name': instance.name,
      'tenant_id': instance.tenantId,
    };
