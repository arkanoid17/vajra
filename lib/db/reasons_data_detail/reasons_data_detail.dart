class ReasonDataDetailsFields{
  static const String id = '_id';
  static const String tenantId = 'tenantId';
  static const String value = 'value';
  static const String groupName = 'groupName';
  static const String label = 'label';
  static const String status = 'status';
  static const String createdAt = 'createdAt';
  static const String updatedAt = 'updatedAt';
}
class ReasonDataDetails{
  int? id;
  String? tenantId;
  String? value;
  String? groupName;
  String? label;
  bool? status;
  String? createdAt;
  String? updatedAt;

  ReasonDataDetails(this.id, this.tenantId, this.value, this.groupName,
      this.label, this.status, this.createdAt, this.updatedAt);

  Map<String, Object?> toJson() => {
    ReasonDataDetailsFields.id:id,
    ReasonDataDetailsFields.tenantId:tenantId,
    ReasonDataDetailsFields.value:value,
    ReasonDataDetailsFields.groupName:groupName,
    ReasonDataDetailsFields.label:label,
    ReasonDataDetailsFields.status:status,
    ReasonDataDetailsFields.createdAt:createdAt,
    ReasonDataDetailsFields.updatedAt:updatedAt
  };

}