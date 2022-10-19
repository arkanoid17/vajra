// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_stats_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserStatsData _$UserStatsDataFromJson(Map<String, dynamic> json) =>
    UserStatsData(
      json['status'] as String?,
      (json['month_nrv'] as num?)?.toDouble(),
      (json['today_nrv'] as num?)?.toDouble(),
      json['month_billed'] as int?,
      json['month_unbilled'] as int?,
      json['today_billed'] as int?,
      json['today_unbilled'] as int?,
    );

Map<String, dynamic> _$UserStatsDataToJson(UserStatsData instance) =>
    <String, dynamic>{
      'status': instance.status,
      'month_nrv': instance.monthNrv,
      'today_nrv': instance.todayNrv,
      'month_billed': instance.monthBilled,
      'month_unbilled': instance.monthUnbilled,
      'today_billed': instance.todayBilled,
      'today_unbilled': instance.todayUnbilled,
    };
