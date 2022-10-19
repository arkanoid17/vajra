// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_types_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreTypeResponse _$StoreTypeResponseFromJson(Map<String, dynamic> json) =>
    StoreTypeResponse(
      json['status'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => StoreTypesData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StoreTypeResponseToJson(StoreTypeResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };
