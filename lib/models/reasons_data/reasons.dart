import 'package:json_annotation/json_annotation.dart';
import 'package:vajra/models/reasons_data/extra_obj.dart';
part 'reasons.g.dart';

@JsonSerializable()
class Reasons{
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'tenant_id')
  String? tenantId;
  @JsonKey(name: 'value')
  String? value;
  @JsonKey(name: 'group_name')
  String? groupName;
  @JsonKey(name: 'label')
  String? label;
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'extras')
  ExtraObj? extras;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;

  Reasons(this.id, this.tenantId, this.value, this.groupName, this.label,
      this.status, this.extras, this.createdAt, this.updatedAt);

  factory Reasons.fromJson(Map<String, dynamic> json) => _$ReasonsFromJson(json);

  Map<String, dynamic> toJson() => _$ReasonsToJson(this);
}