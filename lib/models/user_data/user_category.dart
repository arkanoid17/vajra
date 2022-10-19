import 'package:json_annotation/json_annotation.dart';
import 'package:vajra/models/user_data/parent.dart';
part 'user_category.g.dart';

@JsonSerializable()
class UserCategory{
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'parent')
  Parent? parent;
  @JsonKey(name: 'tenant_id')
  String? tenantId;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;

  UserCategory(this.id, this.parent, this.tenantId, this.name, this.status,
      this.createdAt, this.updatedAt);

  factory UserCategory.fromJson(Map<String, dynamic> json) => _$UserCategoryFromJson(json);

  Map<String?, dynamic> toJson() => _$UserCategoryToJson(this);
}