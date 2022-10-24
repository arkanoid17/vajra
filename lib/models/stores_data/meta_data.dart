import 'package:json_annotation/json_annotation.dart';
part 'meta_data.g.dart';

@JsonSerializable()
class MetaData{
  @JsonKey(name: 'gstn')
  String? gstn;
  @JsonKey(name: 'address')
  String? address;
  @JsonKey(name: 'license')
  String? license;
  @JsonKey(name: 'remarks')
  String? remarks;

  MetaData(this.gstn, this.address, this.license, this.remarks);

  factory MetaData.fromJson(Map<String, dynamic> json) => _$MetaDataFromJson(json);

  Map<String, dynamic> toJson() => _$MetaDataToJson(this);
}