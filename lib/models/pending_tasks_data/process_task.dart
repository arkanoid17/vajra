import 'package:json_annotation/json_annotation.dart';

part 'process_task.g.dart';

@JsonSerializable()
class ProcessTask{
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'status')
  bool? status;

  @JsonKey(name: 'params')
  String? params;

  @JsonKey(name: 'created_at')
  String? createdAt;

  @JsonKey(name: 'updated_at')
  String? updatedAt;

  ProcessTask(this.id, this.name, this.description, this.status, this.params,
      this.createdAt, this.updatedAt);

  factory ProcessTask.fromJson(Map<String, dynamic> json) => _$ProcessTaskFromJson(json);

  Map<String, dynamic> toJson() => _$ProcessTaskToJson(this);
}