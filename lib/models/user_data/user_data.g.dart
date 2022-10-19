// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      json['id'] as int?,
      json['employ_name'] as String?,
      json['employ_id'] as String?,
      (json['groups'] as List<dynamic>?)
          ?.map((e) => UserGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['settings'] == null
          ? null
          : UserSettings.fromJson(json['settings'] as Map<String, dynamic>),
      (json['user_permissions'] as List<dynamic>?)
          ?.map((e) => UserPermissions.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['distributors_mapping'] as List<dynamic>?)
          ?.map((e) => e as Object)
          .toList(),
      (json['salesman_distributors'] as List<dynamic>?)
          ?.map((e) => UserHierarchySalesmanDistributor.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      (json['beats'] as List<dynamic>?)
          ?.map((e) => UserHierarchyBeat.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['products'] as List<dynamic>?)?.map((e) => e as Object).toList(),
      (json['categories'] as List<dynamic>?)
          ?.map((e) => UserCategory.fromJson(e as Map<String, dynamic>))
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
      json['place'] as int?,
      json['role'] as int?,
      json['manager'] as int?,
      json['created_by'] as int?,
      json['updated_by'] as int?,
      (json['distributors'] as List<dynamic>?)?.map((e) => e as int).toList(),
      (json['locations'] as List<dynamic>?)
          ?.map(
              (e) => UserHierarchyLocation.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['is_geo_restricted'] as bool?,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'id': instance.id,
      'employ_name': instance.employName,
      'employ_id': instance.employId,
      'groups': instance.groups,
      'settings': instance.settings,
      'user_permissions': instance.userPermissions,
      'distributors_mapping': instance.distributorsMapping,
      'salesman_distributors': instance.salesmanDistributors,
      'beats': instance.beats,
      'products': instance.products,
      'categories': instance.categories,
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
      'place': instance.place,
      'role': instance.role,
      'manager': instance.manager,
      'created_by': instance.createdBy,
      'updated_by': instance.updatedBy,
      'distributors': instance.distributors,
      'locations': instance.locations,
      'is_geo_restricted': instance.isGeoRestricted,
    };
