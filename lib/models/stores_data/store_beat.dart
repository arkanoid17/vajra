import 'package:json_annotation/json_annotation.dart';

part 'store_beat.g.dart';

@JsonSerializable()
class StoreBeat{
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'tenant_id')
  String? tenantId;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  @JsonKey(name: 'created_by')
  int? createdBy;

  StoreBeat(this.id, this.tenantId, this.name, this.description, this.type,
      this.createdAt, this.updatedAt, this.createdBy);

  factory StoreBeat.fromJson(Map<String, dynamic> json) => _$StoreBeatFromJson(json);

  Map<String, dynamic> toJson() => _$StoreBeatToJson(this);
}