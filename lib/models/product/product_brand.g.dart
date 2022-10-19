// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_brand.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductBrand _$ProductBrandFromJson(Map<String, dynamic> json) => ProductBrand(
      json['id'] as int?,
      json['parent'],
      json['tenant_id'] as String?,
      json['name'] as String?,
      json['brand_franchise'] as String?,
      json['manufacturer'] as String?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
    );

Map<String, dynamic> _$ProductBrandToJson(ProductBrand instance) =>
    <String, dynamic>{
      'id': instance.id,
      'parent': instance.parent,
      'tenant_id': instance.tenantId,
      'name': instance.name,
      'brand_franchise': instance.brandFranchise,
      'manufacturer': instance.manufacturer,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
