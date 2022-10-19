import 'package:json_annotation/json_annotation.dart';
import 'package:vajra/models/pending_tasks_data/activity_data.dart';
import 'package:vajra/models/pending_tasks_data/p_data.dart';
import 'package:vajra/models/pending_tasks_data/process_task.dart';
import 'package:vajra/models/pending_tasks_data/step.dart';

part 'instance.g.dart';

@JsonSerializable()
class Instance{
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'process')
  ProcessTask? process;

  @JsonKey(name: 'step')
  Step? step;

  @JsonKey(name: 'document_id')
  String? documentId;

  @JsonKey(name: 'document_type')
  String? documentType;

  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'data')
  PData? data;

  @JsonKey(name: 'created_at')
  String? createdAt;

  @JsonKey(name: 'updated_at')
  String? updatedAt;

  @JsonKey(name: 'created_by')
  int? createdBy;

  @JsonKey(name: 'updated_by')
  int? updatedBy;

  @JsonKey(name: 'activity')
  ActivityData? activity;

  Instance(
      this.id,
      this.process,
      this.step,
      this.documentId,
      this.documentType,
      this.status,
      this.data,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      this.activity);

  factory Instance.fromJson(Map<String, dynamic> json) => _$InstanceFromJson(json);

  Map<String, dynamic> toJson() => _$InstanceToJson(this);
}