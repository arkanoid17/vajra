import 'package:hive/hive.dart';
import 'package:vajra_test/features/sync/model/models/schemes/scheme_products.dart';
import 'package:vajra_test/features/sync/model/models/schemes/scheme_type.dart';

part 'schemes.g.dart';

@HiveType(typeId: 13, adapterName: 'SchemesAdapter')
class Schemes {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? minPurchaseValue;

  @HiveField(2)
  String? schemeValue;

  @HiveField(3)
  int? tenure;

  @HiveField(4)
  String? name;

  @HiveField(5)
  SchemeType? schemeType;

  @HiveField(6)
  String? startDate;

  @HiveField(7)
  String? endDate;

  @HiveField(8)
  String? description;

  @HiveField(9)
  bool? isActive;

  @HiveField(10)
  List<SchemeProducts>? products;

  @HiveField(11)
  int? salesmanId;

  Schemes(
      {this.id,
      this.minPurchaseValue,
      this.schemeValue,
      this.tenure,
      this.name,
      this.schemeType,
      this.startDate,
      this.endDate,
      this.description,
      this.isActive,
      this.products});

  Schemes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    minPurchaseValue = json['min_purchase_value'];
    schemeValue = json['scheme_value'];
    tenure = json['tenure'];
    name = json['name'];
    schemeType = json['scheme_type'] != null
        ? SchemeType.fromJson(json['scheme_type'])
        : null;
    startDate = json['start_date'];
    endDate = json['end_date'];
    description = json['description'];
    isActive = json['is_active'];
    if (json['products'] != null) {
      products = <SchemeProducts>[];
      json['products'].forEach((v) {
        products!.add(SchemeProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['min_purchase_value'] = this.minPurchaseValue;
    data['scheme_value'] = this.schemeValue;
    data['tenure'] = this.tenure;
    data['name'] = this.name;
    if (this.schemeType != null) {
      data['scheme_type'] = this.schemeType!.toJson();
    }
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['description'] = this.description;
    data['is_active'] = this.isActive;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
