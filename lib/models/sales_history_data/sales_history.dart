import 'package:json_annotation/json_annotation.dart';
part 'sales_history.g.dart';

@JsonSerializable()
class SalesHistoryData{
  @JsonKey(name: 'date')
  String? date;
  @JsonKey(name: 'orders')
  int? orders;
  @JsonKey(name: 'nrv')
  String? nrv;
  @JsonKey(name: 'ptr')
  String? ptr;

  SalesHistoryData(this.date, this.orders, this.nrv, this.ptr);

  factory SalesHistoryData.fromJson(Map<String, dynamic> json) => _$SalesHistoryDataFromJson(json);

  Map<String?, dynamic> toJson() => _$SalesHistoryDataToJson(this);
}