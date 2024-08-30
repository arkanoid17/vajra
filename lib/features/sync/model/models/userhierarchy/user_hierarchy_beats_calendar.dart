class UserHierarchyBeatCalendar {
  int? id;
  int? weekNo;
  String? dayName;

  UserHierarchyBeatCalendar({this.id, this.weekNo, this.dayName});

  UserHierarchyBeatCalendar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    weekNo = json['week_no'];
    dayName = json['day_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['week_no'] = this.weekNo;
    data['day_name'] = this.dayName;
    return data;
  }
}
