// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_code.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryCode _$CountryCodeFromJson(Map<String, dynamic> json) => CountryCode(
      json['name'] as String,
      json['dial_code'] as String,
      json['code'] as String,
    );

Map<String, dynamic> _$CountryCodeToJson(CountryCode instance) =>
    <String, dynamic>{
      'name': instance.name,
      'dial_code': instance.dialCode,
      'code': instance.code,
    };
