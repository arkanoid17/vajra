import 'package:json_annotation/json_annotation.dart';
import 'package:vajra/models/login/user_permissions.dart';
part 'user_group.g.dart';

@JsonSerializable()
class UserGroup{
  @JsonKey(name: 'id')
   int? id;

  @JsonKey(name: 'permissions')
   List<UserPermissions>? permissions ;

  @JsonKey(name: 'name')
   String? name;

  @JsonKey(name: 'tenant_id')
   String? tenantId;

  UserGroup(this.id, this.permissions, this.name, this.tenantId);

  factory UserGroup.fromJson(Map<String, dynamic> json) => _$UserGroupFromJson(json);

  Map<String?, dynamic> toJson() => _$UserGroupToJson(this);
}