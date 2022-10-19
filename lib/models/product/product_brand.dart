import 'package:json_annotation/json_annotation.dart';
part 'product_brand.g.dart';

@JsonSerializable()
class ProductBrand{
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'parent')
  Object? parent;
  @JsonKey(name: 'tenant_id')
  String? tenantId;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'brand_franchise')
  String? brandFranchise;
  @JsonKey(name: 'manufacturer')
  String? manufacturer;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;

  ProductBrand(this.id, this.parent, this.tenantId, this.name,
      this.brandFranchise, this.manufacturer, this.createdAt, this.updatedAt);

  factory ProductBrand.fromJson(Map<String, dynamic> json) => _$ProductBrandFromJson(json);

  Map<String?, dynamic> toJson() => _$ProductBrandToJson(this);

}

