// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_obj.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChannelObj _$ChannelObjFromJson(Map<String, dynamic> json) => ChannelObj(
      json['id'] as int?,
      json['tenant_id'] as String?,
      json['name'] as String?,
      json['status'] as bool?,
      json['description'] as String?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
    );

Map<String, dynamic> _$ChannelObjToJson(ChannelObj instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tenant_id': instance.tenantId,
      'name': instance.name,
      'status': instance.status,
      'description': instance.description,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
