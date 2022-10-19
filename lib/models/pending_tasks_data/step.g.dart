// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Step _$StepFromJson(Map<String, dynamic> json) => Step(
      json['id'] as int?,
      json['name'] as String?,
      json['step_type'] as String?,
      json['actor'] as String?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
      json['process'] as int?,
      json['sla'] as int?,
      json['form'] as int?,
    );

Map<String, dynamic> _$StepToJson(Step instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'step_type': instance.stepType,
      'actor': instance.actor,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'process': instance.process,
      'sla': instance.sla,
      'form': instance.form,
    };
