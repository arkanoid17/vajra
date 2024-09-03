import 'package:hive/hive.dart';

part 'user_hierarchy_distributor_types.g.dart';

@HiveType(typeId: 6, adapterName: 'UserHierarchyDistributorTypesAdapter')
class UserHierarchyDistributorTypes {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? tenantId;

  @HiveField(2)
  String? name;

  @HiveField(3)
  String? description;

  @HiveField(4)
  bool? status;

  @HiveField(5)
  int? code;

  @HiveField(6)
  String? createdAt;

  @HiveField(7)
  String? updatedAt;

  @HiveField(8)
  int? createdBy;

  @HiveField(9)
  int? updatedBy;

  UserHierarchyDistributorTypes(
      {this.id,
      this.tenantId,
      this.name,
      this.description,
      this.status,
      this.code,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy});

  UserHierarchyDistributorTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tenantId = json['tenant_id'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
    code = json['code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['tenant_id'] = this.tenantId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['status'] = this.status;
    data['code'] = this.code;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}
