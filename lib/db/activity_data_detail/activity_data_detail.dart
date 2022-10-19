class ActivityDataDetailFields{
  static const String id = '_id';
  static const String name = 'name';
  static const String startDate = 'startDate';
  static const String endDate = 'endDate';
  static const String isActive = 'isActive';
}
class ActivityDataDetail{
  int? id;
  String? name;
  String? startDate;
  String? endDate;
  bool? isActive;

  ActivityDataDetail(this.id, this.name, this.startDate, this.endDate, this.isActive);

  Map<String, Object?> toJson() => {
    ActivityDataDetailFields.id:id,
    ActivityDataDetailFields.name:name,
    ActivityDataDetailFields.startDate:startDate,
    ActivityDataDetailFields.endDate:endDate,
    ActivityDataDetailFields.isActive:isActive
  };

}