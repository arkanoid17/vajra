import 'package:json_annotation/json_annotation.dart';

part 'activity_data.g.dart';

@JsonSerializable()
class ActivityData{
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'start_date')
  String? startDate;

  @JsonKey(name: 'end_date')
  String? endDate;

  @JsonKey(name: 'is_active')
  bool? isActive;

  ActivityData(this.id, this.name, this.startDate, this.endDate, this.isActive);

  factory ActivityData.fromJson(Map<String, dynamic> json) => _$ActivityDataFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityDataToJson(this);
}