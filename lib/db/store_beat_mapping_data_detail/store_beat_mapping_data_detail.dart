class StoreBeatMappingDataDetailFields{
  static const String id = '_id';
  static const String storeId = 'storeId';
  static const String beatId = 'beatId';
  static const String beatName = 'beatName';
  static const String salesmanId = 'salesmanId';
}
class StoreBeatMappingDataDetail{
  int? id;
  String? storeId;
  int? beatId;
  String? beatName;
  int? salesmanId;

  StoreBeatMappingDataDetail(
       this.storeId, this.beatId, this.beatName, this.salesmanId);

  Map<String, Object?> toJson() => {
    StoreBeatMappingDataDetailFields.id:id,
    StoreBeatMappingDataDetailFields.storeId:storeId,
    StoreBeatMappingDataDetailFields.beatId:beatId,
    StoreBeatMappingDataDetailFields.beatName:beatName,
    StoreBeatMappingDataDetailFields.salesmanId:salesmanId,
  };
}