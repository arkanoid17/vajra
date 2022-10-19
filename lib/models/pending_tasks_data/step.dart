import 'package:json_annotation/json_annotation.dart';

part 'step.g.dart';

@JsonSerializable()
class Step{
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'step_type')
  String? stepType;

  @JsonKey(name: 'actor')
  String? actor;
  
  @JsonKey(name: 'created_at')
  String? createdAt;

  @JsonKey(name: 'updated_at')
  String? updatedAt;

  @JsonKey(name: 'process')
  int? process;

  @JsonKey(name: 'sla')
  int? sla;

  @JsonKey(name: 'form')
  int? form;

  Step(this.id, this.name, this.stepType, this.actor, this.createdAt,
      this.updatedAt, this.process, this.sla, this.form);

  factory Step.fromJson(Map<String, dynamic> json) => _$StepFromJson(json);

  Map<String, dynamic> toJson() => _$StepToJson(this);
}