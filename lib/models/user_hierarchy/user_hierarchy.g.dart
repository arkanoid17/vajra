// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_hierarchy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserHierarchy _$UserHierarchyFromJson(Map<String, dynamic> json) =>
    UserHierarchy(
      json['id'] as int?,
      json['employ_name'] as String?,
      json['employ_id'] as String?,
      (json['locations'] as List<dynamic>?)
          ?.map(
              (e) => UserHierarchyLocation.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['salesman_distributors'] as List<dynamic>?)
          ?.map((e) => UserHierarchySalesmanDistributor.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      (json['beats'] as List<dynamic>?)
          ?.map((e) => UserHierarchyBeat.fromJson(e as Map<String, dynamic>))
          .toList(),
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
      json['place'] as int?,
      json['role'] as int?,
      json['manager'] as int?,
      json['created_by'] as int?,
      json['updated_by'] as int?,
    );

Map<String, dynamic> _$UserHierarchyToJson(UserHierarchy instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employ_name': instance.employName,
      'employ_id': instance.employId,
      'locations': instance.locations,
      'salesman_distributors': instance.salesmanDistributors,
      'beats': instance.beats,
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
      'is_geo_restricted': instance.isGeoRestricted,
      'place': instance.place,
      'role': instance.role,
      'manager': instance.manager,
      'created_by': instance.createdBy,
      'updated_by': instance.updatedBy,
    };
