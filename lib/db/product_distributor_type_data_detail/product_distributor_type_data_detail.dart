class ProductDataDistributorTypeDataDetailFields{
  static const String id ='_id';
  static const String productId = 'productId';
  static const String salesmanId = 'salesmanId';
  static const String distributorTypeId = 'distributorTypeId';
  static const String distributorTypeName = 'distributorTypeName';
}

class ProductDataDistributorTypeDataDetail{
  int? id;
  int? productId;
  int? salesmanId;
  int? distributorTypeId;
  String? distributorTypeName;

  ProductDataDistributorTypeDataDetail(this.productId, this.salesmanId, this.distributorTypeId, this.distributorTypeName);

  Map<String, Object?> toJson() => {
    ProductDataDistributorTypeDataDetailFields.id:id,
    ProductDataDistributorTypeDataDetailFields.productId:productId,
    ProductDataDistributorTypeDataDetailFields.salesmanId:salesmanId,
    ProductDataDistributorTypeDataDetailFields.distributorTypeId:distributorTypeId,
    ProductDataDistributorTypeDataDetailFields.distributorTypeName:distributorTypeName,
  };
  factory ProductDataDistributorTypeDataDetail.fromJson(Map<dynamic, dynamic> json) => ProductDataDistributorTypeDataDetail(
    json['productId'],
    json['salesmanId'],
    json['distributorTypeId'],
    json['distributorTypeName'],
  );

}