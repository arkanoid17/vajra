import 'user_permissions.dart';

class UserGroups {
  int? id;
  List<UserPermissions>? permissions;
  String? name;
  String? tenantId;

  UserGroups({this.id, this.permissions, this.name, this.tenantId});

  UserGroups.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['permissions'] != null) {
      permissions = <UserPermissions>[];
      json['permissions'].forEach((v) {
        permissions!.add(UserPermissions.fromJson(v));
      });
    }
    name = json['name'];
    tenantId = json['tenant_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    if (this.permissions != null) {
      data['permissions'] = this.permissions!.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['tenant_id'] = this.tenantId;
    return data;
  }
}
