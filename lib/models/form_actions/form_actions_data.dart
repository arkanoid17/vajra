import 'package:json_annotation/json_annotation.dart';

part 'form_actions_data.g.dart';

@JsonSerializable()
class FormActions{
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'tenant_id')
  String? tenantId;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  @JsonKey(name: 'actor')
  int? actor;
  @JsonKey(name: 'group')
  int? group;
  @JsonKey(name: 'process')
  int? process;
  @JsonKey(name: 'form_content')
  String? formContent;
  @JsonKey(name: 'category')
  String? category;
  @JsonKey(name: 'document_type')
  String? documentType;
  @JsonKey(name: 'permission')
  int? permissionId;

  FormActions(
      this.id,
      this.tenantId,
      this.name,
      this.description,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.actor,
      this.group,
      this.process,
      this.formContent,
      this.category,
      this.documentType,
      this.permissionId);

  factory FormActions.fromJson(Map<String, dynamic> json) => _$FormActionsFromJson(json);

  Map<String, dynamic> toJson() => _$FormActionsToJson(this);
}