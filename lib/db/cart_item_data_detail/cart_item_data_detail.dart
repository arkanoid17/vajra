class CartItemDataDetailFields{
  static const String id = '_id';
  static const String storeId = 'storeId';
  static const String productId = 'productId';
  static const String productName = 'productName';
  static const String isFree = 'isFree';
  static const String packId = 'packId';
  static const String packValue = 'packValue';
  static const String packCount = 'packCount';
  static const String count = '_count';
  static const String schemeId = 'schemeId';
  static const String createdAt = 'createdAt';
  static const String updatedAt = 'updatedAt';
}

class CartItemDataDetail{
  int? id;
  String? storeId;
  int? productId;
  String? productName;
  bool? isFree;
  int? packId;
  int? packValue;
  int? packCount;
  int? count;
  int? schemeId;
  String? createdAt;
  String? updatedAt;

  CartItemDataDetail(
      this.storeId,
      this.productId,
      this.productName,
      this.isFree,
      this.packId,
      this.packValue,
      this.packCount,
      this.count,
      this.schemeId,
      this.createdAt,
      this.updatedAt
      );

  Map<String, Object?> toJson() => {
    CartItemDataDetailFields.id:id,
    CartItemDataDetailFields.storeId:storeId,
    CartItemDataDetailFields.productId:productId,
    CartItemDataDetailFields.productName:productName,
    CartItemDataDetailFields.isFree:isFree,
    CartItemDataDetailFields.packId:packId,
    CartItemDataDetailFields.packValue:packValue,
    CartItemDataDetailFields.packCount:packCount,
    CartItemDataDetailFields.count:count,
    CartItemDataDetailFields.schemeId:schemeId,
    CartItemDataDetailFields.createdAt:createdAt,
    CartItemDataDetailFields.updatedAt:updatedAt,
  };
}