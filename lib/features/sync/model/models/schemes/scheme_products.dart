import 'package:hive/hive.dart';
import 'package:vajra_test/features/sync/model/models/schemes/scheme_product_details.dart';

part 'scheme_products.g.dart';

@HiveType(typeId: 14, adapterName: 'SchemeProductsAdapter')
class SchemeProducts {
  @HiveField(0)
  int? id;

  @HiveField(1)
  SchemeProductDetails? product;

  @HiveField(2)
  int? minQty;

  @HiveField(3)
  bool? isFree;

  SchemeProducts({this.id, this.product, this.minQty, this.isFree});

  SchemeProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'] != null
        ? SchemeProductDetails.fromJson(json['product'])
        : null;
    minQty = json['min_qty'];
    isFree = json['is_free'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['min_qty'] = this.minQty;
    data['is_free'] = this.isFree;
    return data;
  }
}
