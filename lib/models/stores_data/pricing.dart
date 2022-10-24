import 'package:json_annotation/json_annotation.dart';

part 'pricing.g.dart';

@JsonSerializable()
class Pricing{
  @JsonKey(name: 'scope')
  String? scope;
  @JsonKey(name: 'pricing_list')
  int? pricingList;
  @JsonKey(name: 'status')
  bool? status;

  Pricing(this.scope, this.pricingList, this.status);

  factory Pricing.fromJson(Map<String, dynamic> json) => _$PricingFromJson(json);

  Map<String, dynamic> toJson() => _$PricingToJson(this);
}