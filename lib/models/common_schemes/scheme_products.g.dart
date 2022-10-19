// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheme_products.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SchemeProducts _$SchemeProductsFromJson(Map<String, dynamic> json) =>
    SchemeProducts(
      json['id'] as int?,
      json['product'] == null
          ? null
          : ProductDetails.fromJson(json['product'] as Map<String, dynamic>),
      json['min_qty'] as int?,
      json['is_free'] as bool?,
    );

Map<String, dynamic> _$SchemeProductsToJson(SchemeProducts instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product': instance.product,
      'min_qty': instance.minQty,
      'is_free': instance.isFree,
    };
