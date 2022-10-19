// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceResponse _$PlaceResponseFromJson(Map<String, dynamic> json) =>
    PlaceResponse(
      json['page'] == null
          ? null
          : Page.fromJson(json['page'] as Map<String, dynamic>),
      json['links'] == null
          ? null
          : Link.fromJson(json['links'] as Map<String, dynamic>),
      (json['results'] as List<dynamic>?)
          ?.map((e) => Places.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlaceResponseToJson(PlaceResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'links': instance.links,
      'results': instance.places,
    };
