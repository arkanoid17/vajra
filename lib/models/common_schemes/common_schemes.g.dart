// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_schemes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonSchemes _$CommonSchemesFromJson(Map<String, dynamic> json) =>
    CommonSchemes(
      json['id'] as int?,
      json['name'] as String?,
      json['min_purchase_value'] as String?,
      json['scheme_value'] as String?,
      json['tenure'] as int?,
      json['scheme_type'] == null
          ? null
          : SchemeType.fromJson(json['scheme_type'] as Map<String, dynamic>),
      json['start_date'] as String?,
      json['end_date'] as String?,
      json['description'] as String?,
      json['is_active'] as bool?,
      (json['products'] as List<dynamic>?)
          ?.map((e) => SchemeProducts.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CommonSchemesToJson(CommonSchemes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'min_purchase_value': instance.minPurchaseValue,
      'scheme_value': instance.schemeValue,
      'tenure': instance.tenure,
      'scheme_type': instance.schemeType,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'description': instance.description,
      'is_active': instance.isActive,
      'products': instance.products,
    };
