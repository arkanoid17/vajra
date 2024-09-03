import 'package:hive/hive.dart';

part 'brand.g.dart';

@HiveType(typeId: 12, adapterName: 'BrandAdapter')
class Brand {
  @HiveField(0)
  int? id;

  @HiveField(1)
  int? parent;

  @HiveField(2)
  String? tenantId;

  @HiveField(3)
  String? name;

  @HiveField(4)
  int? companyCode;

  @HiveField(5)
  String? brandFranchise;

  @HiveField(6)
  String? manufacturer;

  @HiveField(7)
  String? createdAt;

  @HiveField(8)
  String? updatedAt;

  Brand(
      {this.id,
      this.parent,
      this.tenantId,
      this.name,
      this.companyCode,
      this.brandFranchise,
      this.manufacturer,
      this.createdAt,
      this.updatedAt});

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parent = json['parent'];
    tenantId = json['tenant_id'];
    name = json['name'];
    companyCode = json['company_code'];
    brandFranchise = json['brand_franchise'];
    manufacturer = json['manufacturer'];
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
    data['brand_franchise'] = this.brandFranchise;
    data['manufacturer'] = this.manufacturer;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
