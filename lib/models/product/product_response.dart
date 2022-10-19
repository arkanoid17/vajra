import 'package:json_annotation/json_annotation.dart';
import 'package:vajra/models/product/product.dart';
part 'product_response.g.dart';

@JsonSerializable()
class ProductResponse{
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'data')
  List<Product>? data ;
  @JsonKey(name: 'isDeletePrevious')
  bool? isDeletePrevious;
  @JsonKey(name: 'deleteProductIds')
  List<Object>? deleteProductIds ;
  @JsonKey(name: 'last_update')
  String? lastUpdate;

  ProductResponse(this.status, this.data, this.isDeletePrevious,
      this.deleteProductIds, this.lastUpdate);

  factory ProductResponse.fromJson(Map<String, dynamic> json) => _$ProductResponseFromJson(json);

  Map<String?, dynamic> toJson() => _$ProductResponseToJson(this);
}