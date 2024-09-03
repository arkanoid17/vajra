import 'package:hive/hive.dart';

part 'scheme_product_details.g.dart';

@HiveType(typeId: 15, adapterName: 'SchemeProductDetailsAdapter')
class SchemeProductDetails {
  @HiveField(0)
  String? name;

  @HiveField(1)
  int? id;

  @HiveField(2)
  int? companyCode;

  @HiveField(3)
  bool? productStatus;

  SchemeProductDetails(
      {this.name, this.id, this.companyCode, this.productStatus});

  SchemeProductDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    companyCode = json['company_code'];
    productStatus = json['product_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['company_code'] = this.companyCode;
    data['product_status'] = this.productStatus;
    return data;
  }
}
