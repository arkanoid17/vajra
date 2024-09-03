import 'package:hive/hive.dart';

part 'product_distributor_types.g.dart';

@HiveType(typeId: 10, adapterName: 'ProductDistributorTypesAdapter')
class ProductDistributorTypes {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? description;

  @HiveField(3)
  String? code;

  @HiveField(4)
  bool? status;

  @HiveField(5)
  String? createdAt;

  @HiveField(6)
  String? updatedAt;

  @HiveField(7)
  int? createdBy;

  @HiveField(8)
  int? updatedBy;

  ProductDistributorTypes(
      {this.id,
      this.name,
      this.description,
      this.code,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy});

  ProductDistributorTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    code = json['code'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['code'] = this.code;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}
