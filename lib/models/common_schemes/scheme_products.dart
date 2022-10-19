import 'package:json_annotation/json_annotation.dart';
import 'package:vajra/models/common_schemes/product_details.dart';
part 'scheme_products.g.dart';

@JsonSerializable()
class SchemeProducts{
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'product')
  ProductDetails? product;
  @JsonKey(name: 'min_qty')
  int? minQty;
  @JsonKey(name: 'is_free')
  bool? isFree;

  SchemeProducts(this.id, this.product, this.minQty, this.isFree);

  factory SchemeProducts.fromJson(Map<String, dynamic> json) => _$SchemeProductsFromJson(json);

  Map<String, dynamic> toJson() => _$SchemeProductsToJson(this);
}