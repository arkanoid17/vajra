// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeData _$EmployeeDataFromJson(Map<String, dynamic> json) => EmployeeData(
      json['id'] as int?,
      json['employ_name'] as String?,
      json['employ_id'] as String?,
      (json['groups'] as List<dynamic>?)
          ?.map((e) => EmployeeGroups.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['settings'] == null
          ? null
          : EmployeeSettings.fromJson(json['settings'] as Map<String, dynamic>),
      json['last_login'] as String?,
      json['tenant_id'] as String?,
      json['user_id'] as String?,
      json['name'] as String?,
      json['mobile_number'] as String?,
      json['email'] as String?,
      json['is_external'] as bool?,
      json['is_active'] as bool?,
      json['date_joined'] as String?,
      json['fcm_token'] as String?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
      json['is_salesman'] as bool?,
      json['is_geo_restricted'] as bool?,
      json['role'] as int?,
      json['manager'] as int?,
      json['created_by'] as int?,
      json['updated_by'] as int?,
      json['token'] as String?,
    );

Map<String, dynamic> _$EmployeeDataToJson(EmployeeData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employ_name': instance.employeeName,
      'employ_id': instance.employeeId,
      'groups': instance.groups,
      'settings': instance.settings,
      'last_login': instance.lastLogin,
      'tenant_id': instance.tenantId,
      'user_id': instance.userId,
      'name': instance.name,
      'mobile_number': instance.mobileNumber,
      'email': instance.email,
      'is_external': instance.isExternal,
      'is_active': instance.isActive,
      'date_joined': instance.dateJoined,
      'fcm_token': instance.fcmToken,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'is_salesman': instance.isSalesman,
      'is_geo_restricted': instance.isGeoRestriced,
      'role': instance.role,
      'manager': instance.manager,
      'created_by': instance.createdBy,
      'updated_by': instance.updatedBy,
      'token': instance.token,
    };
