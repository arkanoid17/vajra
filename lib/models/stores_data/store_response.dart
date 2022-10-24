import 'package:json_annotation/json_annotation.dart';
import 'package:vajra/models/stores_data/store_data.dart';

part 'store_response.g.dart';

@JsonSerializable()
class StoreResponse{
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  List<StoreData>? data;
  @JsonKey(name: 'last_update')
  String? lastUpdate;
  @JsonKey(name: 'removeOldData')
  int? removeOldData;

  StoreResponse(this.status, this.message, this.data, this.lastUpdate,
      this.removeOldData);

  factory StoreResponse.fromJson(Map<String, dynamic> json) => _$StoreResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StoreResponseToJson(this);
}