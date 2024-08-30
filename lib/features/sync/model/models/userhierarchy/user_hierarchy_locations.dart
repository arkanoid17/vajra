class UserHierarchyLocations {
  int? id;
  String? tenantId;
  String? name;
  String? companyCode;
  String? createdAt;
  String? updatedAt;
  bool? isTerritory;
  bool? status;
  int? type;
  int? parent;

  UserHierarchyLocations(
      {this.id,
      this.tenantId,
      this.name,
      this.companyCode,
      this.createdAt,
      this.updatedAt,
      this.isTerritory,
      this.status,
      this.type,
      this.parent});

  UserHierarchyLocations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tenantId = json['tenant_id'];
    name = json['name'];
    companyCode = json['company_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isTerritory = json['is_territory'];
    status = json['status'];
    type = json['type'];
    parent = json['parent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['tenant_id'] = this.tenantId;
    data['name'] = this.name;
    data['company_code'] = this.companyCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_territory'] = this.isTerritory;
    data['status'] = this.status;
    data['type'] = this.type;
    data['parent'] = this.parent;
    return data;
  }
}
