class UserCategories {
  int? id;
  String? parent;
  String? tenantId;
  String? name;
  Null companyCode;
  bool? status;
  String? createdAt;
  String? updatedAt;

  UserCategories(
      {this.id,
      this.parent,
      this.tenantId,
      this.name,
      this.companyCode,
      this.status,
      this.createdAt,
      this.updatedAt});

  UserCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parent = json['parent'];
    tenantId = json['tenant_id'];
    name = json['name'];
    companyCode = json['company_code'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['parent'] = this.parent;
    data['tenant_id'] = this.tenantId;
    data['name'] = this.name;
    data['company_code'] = this.companyCode;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
