// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_hierarchy_salesman_distributors.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserHierarchySalesmanDistributor _$UserHierarchySalesmanDistributorFromJson(
        Map<String, dynamic> json) =>
    UserHierarchySalesmanDistributor(
      json['id'] as int?,
      json['tenant_id'] as String?,
      json['name'] as String?,
      json['description'] as String?,
      json['code'] as String?,
      json['contact_number'] as String?,
      json['type'] as String?,
      json['email_id'] as String?,
      json['distributor_status'] as bool?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
      json['territory'] as int?,
      json['created_by'] as int?,
      json['updated_by'] as int?,
      (json['territories'] as List<dynamic>?)?.map((e) => e as int).toList(),
      (json['distributor_types'] as List<dynamic>?)
          ?.map((e) => DistributorTypes.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserHierarchySalesmanDistributorToJson(
        UserHierarchySalesmanDistributor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tenant_id': instance.tenantId,
      'name': instance.name,
      'description': instance.description,
      'code': instance.code,
      'contact_number': instance.contactNumber,
      'type': instance.type,
      'email_id': instance.emailId,
      'distributor_status': instance.distributorStatus,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'territory': instance.territory,
      'created_by': instance.createdBy,
      'updated_by': instance.updatedBy,
      'territories': instance.territories,
      'distributor_types': instance.distributorTypes,
    };
