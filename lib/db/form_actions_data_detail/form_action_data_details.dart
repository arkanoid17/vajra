class FormActionsDataDetailsFields{
  static const String id = '_id';
  static const String tenantId = 'tenantId';
  static const String name = 'name';
  static const String description = 'description';
  static const String status = 'status';
  static const String createdAt = 'createdAt';
  static const String updatedAt = 'updatedAt';
  static const String actor = 'actor';
  static const String group = 'group';
  static const String process = 'process';
  static const String category = 'category';
  static const String formContent = 'formContent';
  static const String documentType = 'documentType';
  static const String permissionId = 'permissionId';

}

class FormActionsDataDetails{
  int? id;
  String? tenantId;
  String? name;
  String? description;
  bool? status;
  String? createdAt;
  String? updatedAt;
  int? actor;
  int? group;
  int? process;
  String? category;
  String? formContent;
  String? documentType;
  int? permissionId;

  FormActionsDataDetails(
      this.id,
      this.tenantId,
      this.name,
      this.description,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.actor,
      this.group,
      this.process,
      this.category,
      this.formContent,
      this.documentType,
      this.permissionId);

  Map<String, Object?> toJson() => {
    FormActionsDataDetailsFields.id:id,
    FormActionsDataDetailsFields.tenantId:tenantId,
    FormActionsDataDetailsFields.name:name,
    FormActionsDataDetailsFields.description:description,
    FormActionsDataDetailsFields.status:status,
    FormActionsDataDetailsFields.createdAt:createdAt,
    FormActionsDataDetailsFields.updatedAt:updatedAt,
    FormActionsDataDetailsFields.actor:actor,
    FormActionsDataDetailsFields.group:group,
    FormActionsDataDetailsFields.process:process,
    FormActionsDataDetailsFields.category:category,
    FormActionsDataDetailsFields.formContent:formContent,
    FormActionsDataDetailsFields.documentType:documentType,
    FormActionsDataDetailsFields.permissionId:permissionId
  };
}