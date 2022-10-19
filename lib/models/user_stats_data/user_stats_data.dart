import 'package:json_annotation/json_annotation.dart';
part 'user_stats_data.g.dart';

@JsonSerializable()
class UserStatsData{
  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'month_nrv')
  double? monthNrv;

  @JsonKey(name: 'today_nrv')
  double? todayNrv;

  @JsonKey(name: 'month_billed')
  int? monthBilled;

  @JsonKey(name: 'month_unbilled')
  int? monthUnbilled;

  @JsonKey(name: 'today_billed')
  int? todayBilled;

  @JsonKey(name: 'today_unbilled')
  int? todayUnbilled;

  UserStatsData(this.status, this.monthNrv, this.todayNrv, this.monthBilled,
      this.monthUnbilled, this.todayBilled, this.todayUnbilled);

  factory UserStatsData.fromJson(Map<String, dynamic> json) => _$UserStatsDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserStatsDataToJson(this);

}