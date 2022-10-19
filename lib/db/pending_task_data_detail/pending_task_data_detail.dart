class PendingTaskDataDetailFields{
  static const String id = '_id';
  static const String form = 'form';
  static const String instance = 'instance';
  static const String submittedBy = 'submittedBy';
  static const String taskName = 'taskName';
  static const String status = 'status';
  static const String createdAt = 'createdAt';
  static const String updatedAt = 'updatedAt';
  static const String startDate = 'startDate';
  static const String expireDate = 'expireDate';
  static const String submittedAt = 'submittedAt';
  static const String checksum = 'checksum';
  static const String data = 'data';
  static const String actor = 'actor';
  static const String group = 'group';
  static const String step = 'step';
  static const String storeId = 'storeId';
}

class PendingTaskDataDetail{
  int? id;
  String? form;
  String? instance;
  String? submittedBy;
  String? taskName;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? startDate;
  String? expireDate;
  String? submittedAt;
  String? checksum;
  String? data;
  String? actor;
  int? group;
  int? step;
  String? storeId;

  PendingTaskDataDetail(
      this.id,
      this.form,
      this.instance,
      this.submittedBy,
      this.taskName,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.startDate,
      this.expireDate,
      this.submittedAt,
      this.checksum,
      this.data,
      this.actor,
      this.group,
      this.step,
      this.storeId);

  Map<String, Object?> toJson() => {
    PendingTaskDataDetailFields.id:id,
    PendingTaskDataDetailFields.form:form,
    PendingTaskDataDetailFields.instance:instance,
    PendingTaskDataDetailFields.submittedBy:submittedBy,
    PendingTaskDataDetailFields.taskName:taskName,
    PendingTaskDataDetailFields.status:status,
    PendingTaskDataDetailFields.createdAt:createdAt,
    PendingTaskDataDetailFields.updatedAt:updatedAt,
    PendingTaskDataDetailFields.startDate:startDate,
    PendingTaskDataDetailFields.expireDate:expireDate,
    PendingTaskDataDetailFields.submittedAt:submittedAt,
    PendingTaskDataDetailFields.checksum:checksum,
    PendingTaskDataDetailFields.data:data,
    PendingTaskDataDetailFields.actor:actor,
    PendingTaskDataDetailFields.group:group,
    PendingTaskDataDetailFields.step:step,
    PendingTaskDataDetailFields.storeId:storeId
  };

}