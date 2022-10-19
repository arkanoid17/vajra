// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pack.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pack _$PackFromJson(Map<String, dynamic> json) => Pack(
      json['id'] as int?,
      json['tenant_id'] as String?,
      json['name'] as String?,
      json['label'] as String?,
      json['units'] as int?,
      json['status'] as bool?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
      json['product'] as int?,
      json['isSelected'] as bool?,
    );

Map<String, dynamic> _$PackToJson(Pack instance) => <String, dynamic>{
      'id': instance.id,
      'tenant_id': instance.tenantId,
      'name': instance.name,
      'label': instance.label,
      'units': instance.units,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'product': instance.product,
      'isSelected': instance.isSelected,
    };
