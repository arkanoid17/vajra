import 'package:json_annotation/json_annotation.dart';
part 'channel_obj.g.dart';

@JsonSerializable()
class ChannelObj{
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'tenant_id')
  String? tenantId;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;

  ChannelObj(this.id, this.tenantId, this.name, this.status, this.description,
      this.createdAt, this.updatedAt);

  factory ChannelObj.fromJson(Map<String, dynamic> json) => _$ChannelObjFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelObjToJson(this);
}