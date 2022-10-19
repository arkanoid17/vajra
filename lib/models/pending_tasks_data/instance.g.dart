// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Instance _$InstanceFromJson(Map<String, dynamic> json) => Instance(
      json['id'] as int?,
      json['process'] == null
          ? null
          : ProcessTask.fromJson(json['process'] as Map<String, dynamic>),
      json['step'] == null
          ? null
          : Step.fromJson(json['step'] as Map<String, dynamic>),
      json['document_id'] as String?,
      json['document_type'] as String?,
      json['status'] as String?,
      json['data'] == null
          ? null
          : PData.fromJson(json['data'] as Map<String, dynamic>),
      json['created_at'] as String?,
      json['updated_at'] as String?,
      json['created_by'] as int?,
      json['updated_by'] as int?,
      json['activity'] == null
          ? null
          : ActivityData.fromJson(json['activity'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InstanceToJson(Instance instance) => <String, dynamic>{
      'id': instance.id,
      'process': instance.process,
      'step': instance.step,
      'document_id': instance.documentId,
      'document_type': instance.documentType,
      'status': instance.status,
      'data': instance.data,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'created_by': instance.createdBy,
      'updated_by': instance.updatedBy,
      'activity': instance.activity,
    };
