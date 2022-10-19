import 'package:json_annotation/json_annotation.dart';
import 'package:vajra/models/product/pack.dart';
import 'package:vajra/models/product/product_brand.dart';
import 'package:vajra/models/user_hierarchy/distributor_types.dart';
part 'product.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: 'product_name')
  String? productName;
  @JsonKey(name: 'product_id')
  int? productId;
  @JsonKey(name: 'barcode_number')
  String? barcodeNumber;
  @JsonKey(name: 'hsn_number')
  String? hsnNumber;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'manufacturer')
  String? manufacturer;
  @JsonKey(name: 'product_category')
  String? productCategory;
  @JsonKey(name: 'scope')
  String? scope;
  @JsonKey(name: 'mrp')
  String? mrp;
  @JsonKey(name: 'nrv')
  String? nrv;
  @JsonKey(name: 'ptr')
  String? ptr;
  @JsonKey(name: 'tax_type')
  String? taxType;
  @JsonKey(name: 'isQps')
  bool? isQps;
  @JsonKey(name: 'discount_value')
  int? discountValue;
  @JsonKey(name: 'product_status')
  bool? productStatus;
  @JsonKey(name: 'quantity_limit')
  int? quantityLimit;
  @JsonKey(name: 'tax_value')
  String? taxValue;
  @JsonKey(name: 'pts')
  String? pts;
  @JsonKey(name: 'net_price')
  String? netPrice;
  @JsonKey(name: 'is_feature_product')
  bool? isFeatureProduct;
  @JsonKey(name: 'packs')
  List<Pack>? packs;
  @JsonKey(name: 'pricing_id')
  int? pricingId;
  @JsonKey(name: 'pricing_node_id')
  int? pricingNodeId;
  @JsonKey(name: 'query_node_id')
  int? queryNodeId;
  @JsonKey(name: 'channel')
  int? channel;
  @JsonKey(name: 'image')
  String? image;
  @JsonKey(name: 'brand')
  ProductBrand? brand;
  @JsonKey(name: 'distributor_types')
  List<DistributorTypes>? distributorTypes;

  Product(
      this.productName,
      this.productId,
      this.barcodeNumber,
      this.hsnNumber,
      this.description,
      this.manufacturer,
      this.productCategory,
      this.scope,
      this.mrp,
      this.nrv,
      this.ptr,
      this.taxType,
      this.isQps,
      this.discountValue,
      this.productStatus,
      this.quantityLimit,
      this.taxValue,
      this.pts,
      this.netPrice,
      this.isFeatureProduct,
      this.packs,
      this.pricingId,
      this.pricingNodeId,
      this.queryNodeId,
      this.channel,
      this.image,
      this.brand,
      this.distributorTypes);

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String?, dynamic> toJson() => _$ProductToJson(this);

}
