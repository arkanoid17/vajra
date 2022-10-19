import 'package:json_annotation/json_annotation.dart';
part 'price_label.g.dart';

@JsonSerializable()
class PriceLabel{
  @JsonKey(name: 'label')
  String? label;

  @JsonKey(name: 'visibility')
  bool? visibility;

  PriceLabel(this.label, this.visibility);

  factory PriceLabel.fromJson(Map<String, dynamic> json) => _$PriceLabelFromJson(json);

  Map<String?, dynamic> toJson() => _$PriceLabelToJson(this);
}