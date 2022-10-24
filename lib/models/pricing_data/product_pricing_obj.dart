import 'package:json_annotation/json_annotation.dart';
import 'package:vajra/models/common_schemes/product_details.dart';

part 'product_pricing_obj.g.dart';

@JsonSerializable()
class ProductPricingObj{
  @JsonKey(name: 'product')
  ProductDetails? product;
  @JsonKey(name: 'mrp')
  String? mrp;
  @JsonKey(name: 'ptr')
  String? ptr;
  @JsonKey(name: 'pts')
  String? pts;
  @JsonKey(name: 'nrv')
  String? nrv;
  @JsonKey(name: 'is_feature_product')
  bool? isFeatureProduct;
  @JsonKey(name: 'status')
  bool? status;

  ProductPricingObj(this.product, this.mrp, this.ptr, this.pts, this.nrv,
      this.isFeatureProduct, this.status);

  factory ProductPricingObj.fromJson(Map<String, dynamic> json) => _$ProductPricingObjFromJson(json);

  Map<String, dynamic> toJson() => _$ProductPricingObjToJson(this);
}