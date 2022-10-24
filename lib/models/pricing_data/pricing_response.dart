import 'package:json_annotation/json_annotation.dart';
import 'package:vajra/models/pricing_data/product_pricing_obj.dart';

part 'pricing_response.g.dart';

@JsonSerializable()
class PricingResponse{
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'products')
  List<ProductPricingObj>? pricings;

  PricingResponse(this.id, this.name, this.code, this.description,
      this.createdAt, this.updatedAt, this.status, this.pricings);

  factory PricingResponse.fromJson(Map<String, dynamic> json) => _$PricingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PricingResponseToJson(this);
}