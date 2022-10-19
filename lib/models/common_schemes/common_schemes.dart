import 'package:json_annotation/json_annotation.dart';
import 'package:vajra/models/common_schemes/scheme_products.dart';
import 'package:vajra/models/common_schemes/scheme_type.dart';
part 'common_schemes.g.dart';


@JsonSerializable()
class CommonSchemes{
  CommonSchemes(
      this.id,
      this.name,
      this.minPurchaseValue,
      this.schemeValue,
      this.tenure,
      this.schemeType,
      this.startDate,
      this.endDate,
      this.description,
      this.isActive,
      this.products);

  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'min_purchase_value')
  String? minPurchaseValue;
  @JsonKey(name: 'scheme_value')
  String? schemeValue;
  @JsonKey(name: 'tenure')
  int? tenure;
  @JsonKey(name: 'scheme_type')
  SchemeType? schemeType;
  @JsonKey(name: 'start_date')
  String? startDate;
  @JsonKey(name: 'end_date')
  String? endDate;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'is_active')
  bool? isActive;
  @JsonKey(name: 'products')
  List<SchemeProducts>? products = null;

  factory CommonSchemes.fromJson(Map<String, dynamic> json) => _$CommonSchemesFromJson(json);

  Map<String, dynamic> toJson() => _$CommonSchemesToJson(this);
}