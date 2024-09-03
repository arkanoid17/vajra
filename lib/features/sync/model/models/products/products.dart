import 'package:hive/hive.dart';
import 'package:vajra_test/features/sync/model/models/products/brand.dart';
import 'package:vajra_test/features/sync/model/models/products/packs.dart';
import 'package:vajra_test/features/sync/model/models/products/product_distributor_types.dart';

part 'products.g.dart';

@HiveType(typeId: 9, adapterName: 'ProductsAdapter')
class Products {
  @HiveField(0)
  String? productName;

  @HiveField(1)
  int? productId;

  @HiveField(2)
  String? barcodeNumber;

  @HiveField(3)
  String? hsnNumber;

  @HiveField(4)
  String? description;

  @HiveField(5)
  String? manufacturer;

  @HiveField(6)
  String? productCategory;

  @HiveField(7)
  Brand? brand;

  @HiveField(8)
  String? scope;

  @HiveField(9)
  String? mrp;

  @HiveField(10)
  String? nrv;

  @HiveField(11)
  String? ptr;

  @HiveField(12)
  String? taxType;

  @HiveField(13)
  bool? isQps;

  @HiveField(14)
  int? discountValue;

  @HiveField(15)
  bool? productStatus;

  @HiveField(16)
  int? quantityLimit;

  // String? taxValue;

  @HiveField(17)
  String? pts;

  @HiveField(18)
  String? netPrice;

  @HiveField(19)
  bool? isFeatureProduct;

  @HiveField(20)
  List<Packs>? packs;

  @HiveField(21)
  List<ProductDistributorTypes>? distributorTypes;

  @HiveField(22)
  int? pricingId;

  @HiveField(23)
  int? pricingNodeId;

  @HiveField(24)
  int? queryNodeId;

  @HiveField(25)
  int? channel;

  @HiveField(26)
  String? image;

  @HiveField(27)
  int? salesmanId;

  Products(
      {this.productName,
      this.productId,
      this.barcodeNumber,
      this.hsnNumber,
      this.description,
      this.manufacturer,
      this.productCategory,
      this.brand,
      this.scope,
      this.mrp,
      this.nrv,
      this.ptr,
      this.taxType,
      this.isQps,
      this.discountValue,
      this.productStatus,
      this.quantityLimit,
      // this.taxValue,
      this.pts,
      this.netPrice,
      this.isFeatureProduct,
      this.packs,
      this.distributorTypes,
      this.pricingId,
      this.pricingNodeId,
      this.queryNodeId,
      this.channel,
      this.image});

  Products.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    productId = json['product_id'];
    barcodeNumber = json['barcode_number'];
    hsnNumber = json['hsn_number'];
    description = json['description'];
    manufacturer = json['manufacturer'];
    productCategory = json['product_category'];
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
    scope = json['scope'];
    mrp = json['mrp'];
    nrv = json['nrv'];
    ptr = json['ptr'];
    taxType = json['tax_type'];
    isQps = json['isQps'];
    discountValue = json['discount_value'];
    productStatus = json['product_status'];
    quantityLimit = json['quantity_limit'];
    // taxValue = json['tax_value'];
    pts = json['pts'];
    netPrice = json['net_price'];
    isFeatureProduct = json['is_feature_product'];
    if (json['packs'] != null) {
      packs = <Packs>[];
      json['packs'].forEach((v) {
        packs!.add(Packs.fromJson(v));
      });
    }
    if (json['distributor_types'] != null) {
      distributorTypes = <ProductDistributorTypes>[];
      json['distributor_types'].forEach((v) {
        distributorTypes!.add(ProductDistributorTypes.fromJson(v));
      });
    }
    pricingId = json['pricing_id'];
    pricingNodeId = json['pricing_node_id'];
    queryNodeId = json['query_node_id'];
    channel = json['channel'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['product_id'] = this.productId;
    data['barcode_number'] = this.barcodeNumber;
    data['hsn_number'] = this.hsnNumber;
    data['description'] = this.description;
    data['manufacturer'] = this.manufacturer;
    data['product_category'] = this.productCategory;
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }
    data['scope'] = this.scope;
    data['mrp'] = this.mrp;
    data['nrv'] = this.nrv;
    data['ptr'] = this.ptr;
    data['tax_type'] = this.taxType;
    data['isQps'] = this.isQps;
    data['discount_value'] = this.discountValue;
    data['product_status'] = this.productStatus;
    data['quantity_limit'] = this.quantityLimit;
    // data['tax_value'] = this.taxValue;
    data['pts'] = this.pts;
    data['net_price'] = this.netPrice;
    data['is_feature_product'] = this.isFeatureProduct;
    if (this.packs != null) {
      data['packs'] = this.packs!.map((v) => v.toJson()).toList();
    }
    if (this.distributorTypes != null) {
      data['distributor_types'] =
          this.distributorTypes!.map((v) => v.toJson()).toList();
    }
    data['pricing_id'] = this.pricingId;
    data['pricing_node_id'] = this.pricingNodeId;
    data['query_node_id'] = this.queryNodeId;
    data['channel'] = this.channel;
    data['image'] = this.image;
    data['salesman_id'] = this.salesmanId;
    return data;
  }
}
