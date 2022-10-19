// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PendingTask _$PendingTaskFromJson(Map<String, dynamic> json) => PendingTask(
      json['id'] as int?,
      json['form'] == null
          ? null
          : Form.fromJson(json['form'] as Map<String, dynamic>),
      json['instance'] == null
          ? null
          : Instance.fromJson(json['instance'] as Map<String, dynamic>),
      json['submitted_by'] == null
          ? null
          : SubmittedBy.fromJson(json['submitted_by'] as Map<String, dynamic>),
      json['task_name'] as String?,
      json['status'] as String?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
      json['start_date'] as String?,
      json['expire_date'] as String?,
      json['submitted_at'] as String?,
      json['checksum'] as String?,
      json['data'] == null
          ? null
          : TaskData.fromJson(json['data'] as Map<String, dynamic>),
      json['actor'] as String?,
      json['group'] as int?,
      json['step'] as int?,
      json['activity'] == null
          ? null
          : TaskActivity.fromJson(json['activity'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PendingTaskToJson(PendingTask instance) =>
    <String, dynamic>{
      'id': instance.id,
      'form': instance.form,
      'instance': instance.instance,
      'submitted_by': instance.submittedBy,
      'task_name': instance.taskName,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'start_date': instance.startDate,
      'expire_date': instance.expireDate,
      'submitted_at': instance.submittedAt,
      'checksum': instance.checksum,
      'data': instance.data,
      'actor': instance.actor,
      'group': instance.group,
      'step': instance.step,
      'activity': instance.taskActivity,
    };
