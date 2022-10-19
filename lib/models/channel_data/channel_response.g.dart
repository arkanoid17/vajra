// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChannelResponse _$ChannelResponseFromJson(Map<String, dynamic> json) =>
    ChannelResponse(
      json['page'] == null
          ? null
          : Page.fromJson(json['page'] as Map<String, dynamic>),
      json['links'] == null
          ? null
          : Link.fromJson(json['links'] as Map<String, dynamic>),
      (json['results'] as List<dynamic>?)
          ?.map((e) => ChannelObj.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChannelResponseToJson(ChannelResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'links': instance.links,
      'results': instance.results,
    };
