import 'package:json_annotation/json_annotation.dart';

part 'task_activity.g.dart';

@JsonSerializable()
class TaskActivity{
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'start_date')
  String? startDate;
  @JsonKey(name: 'end_date')
  String? endDate;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  @JsonKey(name: 'is_active')
  bool? isActive;
  @JsonKey(name: 'type')
  int? type;
  @JsonKey(name: 'created_by')
  int? createdBy;
  @JsonKey(name: 'updated_by')
  int? updatedBy;

  TaskActivity(
      this.id,
      this.name,
      this.startDate,
      this.endDate,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.isActive,
      this.type,
      this.createdBy,
      this.updatedBy);

  factory TaskActivity.fromJson(Map<String, dynamic> json) => _$TaskActivityFromJson(json);

  Map<String, dynamic> toJson() => _$TaskActivityToJson(this);
}