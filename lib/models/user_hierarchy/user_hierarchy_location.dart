import 'package:json_annotation/json_annotation.dart';
part 'user_hierarchy_location.g.dart';

@JsonSerializable()
class UserHierarchyLocation{
  @JsonKey(name: 'id')
  int? id;
  
  @JsonKey(name: 'tenant_id')
  String? tenantId;
  
  @JsonKey(name: 'name')
  String? name;
  
  @JsonKey(name: 'created_at')
  String? createdAt;
  
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  
  @JsonKey(name: 'is_territory')
  bool? isTerritory;
  
  @JsonKey(name: 'type')
  int? type;
  
  @JsonKey(name: 'parent')
  int? parent;

  UserHierarchyLocation(this.id, this.tenantId, this.name, this.createdAt,
      this.updatedAt, this.isTerritory, this.type, this.parent);

  factory UserHierarchyLocation.fromJson(Map<String, dynamic> json) => _$UserHierarchyLocationFromJson(json);

  Map<String?, dynamic> toJson() => _$UserHierarchyLocationToJson(this);
}