// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'p_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PData _$PDataFromJson(Map<String, dynamic> json) => PData(
      json['zone_id'] as int?,
      json['outlet_id'] as String?,
      json['image_url'] as String?,
      json['scheme_id'] as int?,
      json['store_name'] as String?,
      json['activity_id'] as int?,
      json['document_id'] as String?,
      json['salesman_id'] as String?,
      json['activity_type'] as String?,
      json['document_type'] as String?,
      json['salesman_name'] as String?,
      json['present_status'] as String?,
      json['distributor_status'] as String?,
      json['ase_territory_id'] as int?,
      json['asm_territory_id'] as int?,
    );

Map<String, dynamic> _$PDataToJson(PData instance) => <String, dynamic>{
      'zone_id': instance.zoneId,
      'outlet_id': instance.storeId,
      'image_url': instance.imageUrl,
      'scheme_id': instance.schemeId,
      'store_name': instance.storeName,
      'activity_id': instance.activityId,
      'document_id': instance.documentId,
      'salesman_id': instance.salesmanId,
      'activity_type': instance.activityType,
      'document_type': instance.documentType,
      'salesman_name': instance.salesmanName,
      'present_status': instance.presentStatus,
      'distributor_status': instance.distributorStatus,
      'ase_territory_id': instance.aseTerritoryId,
      'asm_territory_id': instance.asmTerritoryId,
    };
