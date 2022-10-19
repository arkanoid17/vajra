import 'package:json_annotation/json_annotation.dart';
part 'pack.g.dart';

@JsonSerializable()
class Pack{
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'tenant_id')
  String? tenantId;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'label')
  String? label;
  @JsonKey(name: 'units')
  int? units;
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  @JsonKey(name: 'product')
  int? product;
  bool? isSelected;

  Pack(this.id, this.tenantId, this.name, this.label, this.units, this.status,
      this.createdAt, this.updatedAt, this.product, this.isSelected);

  factory Pack.fromJson(Map<String, dynamic> json) => _$PackFromJson(json);

  Map<String?, dynamic> toJson() => _$PackToJson(this);

}