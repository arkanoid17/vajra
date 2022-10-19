class UserStatsDataDetailFields{
  static const String id = '_id';
  static const String status = 'status';
  static const String monthNrv = 'monthNrv';
  static const String todayNrv = 'todayNrv';
  static const String monthBilled = 'monthBilled';
  static const String monthUnbilled =' monthUnbilled';
  static const String todayBilled = 'todayBilled';
  static const String todayUnbilled = 'todayUnbilled';
}

class UserStatsDataDetail{
  int? id;
  String? status;
  double? monthNrv;
  double? todayNrv;
  int? monthBilled;
  int? monthUnbilled;
  int? todayBilled;
  int? todayUnbilled;

  UserStatsDataDetail(
      this.status,
      this.monthNrv,
      this.todayNrv,
      this.monthBilled,
      this.monthUnbilled,
      this.todayBilled,
      this.todayUnbilled);

  Map<String, Object?> toJson() => {
    UserStatsDataDetailFields.id:id,
    UserStatsDataDetailFields.status:status,
    UserStatsDataDetailFields.monthNrv:monthNrv,
    UserStatsDataDetailFields.todayNrv:todayNrv,
    UserStatsDataDetailFields.monthBilled:monthBilled,
    UserStatsDataDetailFields.monthUnbilled:monthUnbilled,
    UserStatsDataDetailFields.todayBilled:todayBilled,
    UserStatsDataDetailFields.todayUnbilled:todayUnbilled,
  };

}