import 'package:json_annotation/json_annotation.dart';
import 'package:vajra/models/pending_tasks_data/instance.dart';
import 'package:vajra/models/pending_tasks_data/submitted_by.dart';
import 'package:vajra/models/pending_tasks_data/task_activity.dart';
import 'package:vajra/models/pending_tasks_data/task_data.dart';

import 'form.dart';
part 'pending_task.g.dart';

@JsonSerializable()
class PendingTask{
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'form')
  Form? form;

  @JsonKey(name: 'instance')
  Instance? instance;

  @JsonKey(name: 'submitted_by')
  SubmittedBy? submittedBy;

  @JsonKey(name: 'task_name')
  String? taskName;

  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'created_at')
  String? createdAt;

  @JsonKey(name: 'updated_at')
  String? updatedAt;

  @JsonKey(name: 'start_date')
  String? startDate;

  @JsonKey(name: 'expire_date')
  String? expireDate;

  @JsonKey(name: 'submitted_at')
  String? submittedAt;

  @JsonKey(name: 'checksum')
  String? checksum;

  @JsonKey(name: 'data')
  TaskData? data;

  @JsonKey(name: 'actor')
  String? actor;

  @JsonKey(name: 'group')
  int? group;

  @JsonKey(name: 'step')
  int? step;

  @JsonKey(name: 'activity')
  TaskActivity? taskActivity;

  PendingTask(
      this.id,
      this.form,
      this.instance,
      this.submittedBy,
      this.taskName,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.startDate,
      this.expireDate,
      this.submittedAt,
      this.checksum,
      this.data,
      this.actor,
      this.group,
      this.step,
      this.taskActivity);

  factory PendingTask.fromJson(Map<String, dynamic> json) => _$PendingTaskFromJson(json);

  Map<String, dynamic> toJson() => _$PendingTaskToJson(this);
}