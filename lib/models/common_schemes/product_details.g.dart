// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetails _$ProductDetailsFromJson(Map<String, dynamic> json) =>
    ProductDetails(
      json['name'] as String?,
      json['id'] as int?,
      json['company_code'],
      json['product_status'] as bool?,
    );

Map<String, dynamic> _$ProductDetailsToJson(ProductDetails instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'company_code': instance.companyCode,
      'product_status': instance.productStatus,
    };
