import 'package:json_annotation/json_annotation.dart';

part 'store_types_data.g.dart';

@JsonSerializable()
class StoreTypesData{
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;

  StoreTypesData(this.id, this.name);

  factory StoreTypesData.fromJson(Map<String, dynamic> json) => _$StoreTypesDataFromJson(json);

  Map<String, dynamic> toJson() => _$StoreTypesDataToJson(this);
}