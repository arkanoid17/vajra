import 'package:json_annotation/json_annotation.dart';
part 'product_details.g.dart';

@JsonSerializable()
class ProductDetails{
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'company_code')
  Object? companyCode;
  @JsonKey(name: 'product_status')
  bool? productStatus;

  ProductDetails(this.name, this.id, this.companyCode, this.productStatus);

  factory ProductDetails.fromJson(Map<String, dynamic> json) => _$ProductDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailsToJson(this);
}