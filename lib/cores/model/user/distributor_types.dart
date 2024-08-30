class DistributorTypes {
  int? id;
  String? tenantId;
  String? name;
  String? description;
  bool? status;
  String? code;
  String? createdAt;
  String? updatedAt;
  int? createdBy;
  int? updatedBy;

  DistributorTypes(
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

  DistributorTypes.fromJson(Map<String, dynamic> json) {
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
