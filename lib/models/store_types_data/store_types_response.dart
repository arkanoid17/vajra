import 'package:json_annotation/json_annotation.dart';
import 'package:vajra/models/store_types_data/store_types_data.dart';

part 'store_types_response.g.dart';

@JsonSerializable()
class StoreTypeResponse{
  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'data')
  List<StoreTypesData>? data;

  StoreTypeResponse(this.status, this.data);

  factory StoreTypeResponse.fromJson(Map<String, dynamic> json) => _$StoreTypeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StoreTypeResponseToJson(this);

}