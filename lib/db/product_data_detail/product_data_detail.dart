class ProductDataFields {
  static const String id = '_id';
  static const String productName = 'productName';
  static const String productId = 'productId';
  static const String barcodeNumber = 'barcodeNumber';
  static const String hsnNumber = 'hsnNumber';
  static const String description = 'description';
  static const String manufacturer = 'manufacturer';
  static const String productCategory = 'productCategory';
  static const String scope = 'scope';
  static const String mrp = 'mrp';
  static const String nrv = 'nrv';
  static const String ptr = 'ptr';
  static const String taxType = 'taxType';
  static const String isQps = 'isQps';
  static const String discountValue = 'discountValue';
  static const String productStatus = 'productStatus';
  static const String quantityLimit = 'quantityLimit';
  static const String taxValue = 'taxValue';
  static const String pts = 'pts';
  static const String netPrice = 'netPrice';
  static const String isFeatureProduct = 'isFeatureProduct';
  static const String packs = 'packs';
  static const String pricingId = 'pricingId';
  static const String pricingNodeId = 'pricingNodeId';
  static const String queryNodeId = 'queryNodeId';
  static const String channel = 'channel';
  static const String count = 'count';
  static const String packCount = 'packCount';
  static const String image = 'image';
  static const String salesmanId = 'salesmanId';
  static const String brand = 'brand';
  static const String schemeId = 'schemeId';
  static const String schemeCount = 'schemeCount';
}

class ProductDataDetail {
  ProductDataDetail(
      this.productName,
      this.productId,
      this.barcodeNumber,
      this.hsnNumber,
      this.description,
      this.manufacturer,
      this.productCategory,
      this.scope,
      this.mrp,
      this.nrv,
      this.ptr,
      this.taxType,
      this.isQps,
      this.discountValue,
      this.productStatus,
      this.quantityLimit,
      this.taxValue,
      this.pts,
      this.netPrice,
      this.isFeatureProduct,
      this.packs,
      this.pricingId,
      this.pricingNodeId,
      this.queryNodeId,
      this.channel,
      this.count,
      this.packCount,
      this.image,
      this.salesmanId,
      this.brand,
      this.schemeId,
      this.schemeCount
      );

  int? id;
  String? productName;
  int? productId;
  String? barcodeNumber;
  String? hsnNumber;
  String? description;
  String? manufacturer;
  String? productCategory;
  String? scope;
  String? mrp;
  String? nrv;
  String? ptr;
  String? taxType;
  bool? isQps;
  int? discountValue;
  bool? productStatus;
  int? quantityLimit;
  String? taxValue;
  String? pts;
  String? netPrice;
  bool? isFeatureProduct;
  String? packs;
  int? pricingId;
  int? pricingNodeId;
  int? queryNodeId;
  int? channel;
  int? count;
  int? packCount;
  String? image;
  int? salesmanId;
  String? brand;
  int? schemeId;
  int? schemeCount;

  Map<String, Object?> toJson() => {
        ProductDataFields.id: id,
        ProductDataFields.productName: productName,
        ProductDataFields.productId: productId,
        ProductDataFields.barcodeNumber: barcodeNumber,
        ProductDataFields.hsnNumber: hsnNumber,
        ProductDataFields.description: description,
        ProductDataFields.manufacturer: manufacturer,
        ProductDataFields.productCategory: productCategory,
        ProductDataFields.scope: scope,
        ProductDataFields.mrp: mrp,
        ProductDataFields.nrv: nrv,
        ProductDataFields.ptr: ptr,
        ProductDataFields.taxType: taxType,
        ProductDataFields.isQps: isQps,
        ProductDataFields.discountValue: discountValue,
        ProductDataFields.productStatus: productStatus,
        ProductDataFields.quantityLimit: quantityLimit,
        ProductDataFields.taxValue: taxValue,
        ProductDataFields.pts: pts,
        ProductDataFields.netPrice: netPrice,
        ProductDataFields.isFeatureProduct: isFeatureProduct,
        ProductDataFields.packs: packs,
        ProductDataFields.pricingId: pricingId,
        ProductDataFields.pricingNodeId: pricingNodeId,
        ProductDataFields.queryNodeId: queryNodeId,
        ProductDataFields.channel: channel,
        ProductDataFields.count: count,
        ProductDataFields.packCount: packCount,
        ProductDataFields.image: image,
        ProductDataFields.salesmanId: salesmanId,
        ProductDataFields.brand: brand,
        ProductDataFields.schemeId: schemeId,
        ProductDataFields.schemeCount: schemeCount,
      };

  factory ProductDataDetail.fromJson(Map<dynamic, dynamic> json) =>
      ProductDataDetail(
          json['productName'],
          json['productId'],
          json['barcodeNumber'],
          json['hsnNumber'],
          json['description'],
          json['manufacturer'],
          json['productCategory'],
          json['scope'],
          json['mrp'],
          json['nrv'],
          json['ptr'],
          json['taxType'],
          json['isQps']==1,
          json['discountValue'],
          json['productStatus']==1,
          json['quantityLimit'],
          json['taxValue'],
          json['pts'],
          json['netPrice'],
          json['isFeatureProduct']==1,
          json['packs'],
          json['pricingId'],
          json['pricingNodeId'],
          json['queryNodeId'],
          json['channel'],
          json['count'],
          json['packCount'],
          json['image'],
          json['salesmanId'],
          json['brand'],
          json['schemeId'],
          json['schemeCount']);


}
