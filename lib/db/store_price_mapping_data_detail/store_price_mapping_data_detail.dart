class StorePriceMappingDataDetailFields{
  static const String id = '_id';
  static const String storeId = 'storeId';
  static const String scope = 'scope';
  static const String pricingList = 'pricingList';
  static const String status = 'status';
  static const String userId = 'userId';
}
class StorePriceMappingDataDetail{
  int? id;
  String? storeId;
  String? scope;
  int? pricingList;
  bool? status;
  int? userId;

  StorePriceMappingDataDetail(
      this.storeId, this.scope, this.pricingList, this.status, this.userId);

  Map<String, Object?> toJson() => {
    StorePriceMappingDataDetailFields.id:id,
    StorePriceMappingDataDetailFields.storeId:storeId,
    StorePriceMappingDataDetailFields.scope:scope,
    StorePriceMappingDataDetailFields.pricingList:pricingList,
    StorePriceMappingDataDetailFields.status:status,
    StorePriceMappingDataDetailFields.userId:userId,
  };
}