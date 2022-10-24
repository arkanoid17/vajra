import 'package:json_annotation/json_annotation.dart';

part 'colours.g.dart';

@JsonSerializable()
class Colours{
  @JsonKey(name: 'colour')
  int? colour;
  @JsonKey(name: 'beat')
  int? beat;
  @JsonKey(name: 'sales_territory')
  int? salesTerritory;
  @JsonKey(name: 'visit_date')
  String? visitDate;
  @JsonKey(name: 'bill')
  int? bill;
  @JsonKey(name: 'no_bill')
  int? noBill;

  Colours(this.colour, this.beat, this.salesTerritory, this.visitDate,
      this.bill, this.noBill);

  factory Colours.fromJson(Map<String, dynamic> json) => _$ColoursFromJson(json);

  Map<String, dynamic> toJson() => _$ColoursToJson(this);
}