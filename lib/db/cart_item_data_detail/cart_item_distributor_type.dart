class CartItemDistributorTypeFields{
  static const String id = '_id';
  static const String cartId = 'cartId';
  static const String distributorTypeId = 'distributorTypeId';
  static const String distributorTypeName = 'distributorTypeName';
}

class CartItemDistributorType{
  int? id;
  int? cartId;
  int? distributorTypeId;
  String? distributorTypeName;

  CartItemDistributorType(this.cartId, this.distributorTypeId, this.distributorTypeName);

  Map<String, Object?> toJson() => {
    CartItemDistributorTypeFields.id:id,
    CartItemDistributorTypeFields.cartId:cartId,
    CartItemDistributorTypeFields.distributorTypeId:distributorTypeId,
    CartItemDistributorTypeFields.distributorTypeName:distributorTypeName,
  };

}