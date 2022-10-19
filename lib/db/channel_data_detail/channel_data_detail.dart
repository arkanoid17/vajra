class ChannelDataDetailFields{
  static const String  id = '_id';
  static const String tenantId = 'tenantId';
  static const String name = 'name';
  static const String status = 'status';
  static const String description = 'description';
  static const String createdAt = 'createdAt';
  static const String updatedAt = 'updatedAt';
}

class ChannelDataDetail{
  int? id;

  String? tenantId;

  String? name;

  bool? status;

  String? description;

  String? createdAt;

  String? updatedAt;

  ChannelDataDetail(this.id, this.tenantId, this.name, this.status,
      this.description, this.createdAt, this.updatedAt);

  Map<String, Object?> toJson() => {
    ChannelDataDetailFields.id:id,
    ChannelDataDetailFields.tenantId:tenantId,
    ChannelDataDetailFields.name:name,
    ChannelDataDetailFields.status:status,
    ChannelDataDetailFields.description:description,
    ChannelDataDetailFields.createdAt:createdAt,
    ChannelDataDetailFields.updatedAt:updatedAt
  };
}