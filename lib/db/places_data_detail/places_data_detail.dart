class PlacesDataDetailFields{
  static const String id = '_id';
  static const String placeId = 'placeId';
  static const String tenantId = 'tenantId';
  static const String name = 'name';
  static const String createdAt = 'createdAt';
  static const String updatedAt = 'updatedAt';
  static const String isTerritory = 'isTerritory';
  static const String type = 'type';
  static const String parent = 'parent';
}


class PlacesDataDetail{
  int? id;
  int? placeId;
  String? tenantId;
  String? name;
  String? createdAt;
  String? updatedAt;
  bool? isTerritory;
  int? type;
  int? parent;

  PlacesDataDetail(this.placeId, this.tenantId, this.name,
      this.createdAt, this.updatedAt, this.isTerritory, this.type, this.parent);

  Map<String, Object?> toJson() => {
    PlacesDataDetailFields.id:id,
    PlacesDataDetailFields.placeId:placeId,
    PlacesDataDetailFields.tenantId:tenantId,
    PlacesDataDetailFields.name:name,
    PlacesDataDetailFields.createdAt:createdAt,
    PlacesDataDetailFields.updatedAt:updatedAt,
    PlacesDataDetailFields.isTerritory:isTerritory,
    PlacesDataDetailFields.type:type,
    PlacesDataDetailFields.parent:parent,
  };

}