import 'package:json_annotation/json_annotation.dart';
import 'package:vajra/models/login/user_permissions.dart';
part 'employee_groups.g.dart';

@JsonSerializable()
class EmployeeGroups{

  EmployeeGroups(this.id, this.permissions, this.name, this.tenantId);

  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'permissions')
  List<UserPermissions>? permissions;

  @JsonKey(name: 'name')
  String? name;
  
  @JsonKey(name: 'tenant_id')
  String? tenantId;

  factory EmployeeGroups.fromJson(Map<String, dynamic> json) => _$EmployeeGroupsFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeGroupsToJson(this);

}