// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductResponse _$ProductResponseFromJson(Map<String, dynamic> json) =>
    ProductResponse(
      json['status'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['isDeletePrevious'] as bool?,
      (json['deleteProductIds'] as List<dynamic>?)
          ?.map((e) => e as Object)
          .toList(),
      json['last_update'] as String?,
    );

Map<String, dynamic> _$ProductResponseToJson(ProductResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'isDeletePrevious': instance.isDeletePrevious,
      'deleteProductIds': instance.deleteProductIds,
      'last_update': instance.lastUpdate,
    };
