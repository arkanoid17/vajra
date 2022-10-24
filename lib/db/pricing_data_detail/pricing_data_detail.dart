class PricingDataDetailFields{
  static const String id = '_id';
  static const String pricing_id = 'pricing_id';
  static const String name = 'name';
  static const String code = 'code';
  static const String description = 'description';
  static const String created_at = 'created_at';
  static const String updated_at = 'updated_at';
  static const String pricing_status = 'pricing_status';
  static const String product = 'product';
  static const String mrp = 'mrp';
  static const String ptr = 'ptr';
  static const String pts = 'pts';
  static const String nrv = 'nrv';
  static const String is_feature_product = 'is_feature_product';
  static const String product_status = 'product_status';
  static const String userId = 'userId';
}

class PricingDataDetail{
  int? id;
  int? pricing_id;
  String? name;
  String? code;
  String? description;
  String? created_at;
  String? updated_at;
  bool? pricing_status;
  int? product;
  String? mrp;
  String? ptr;
  String? pts;
  String? nrv;
  bool? is_feature_product;
  bool? product_status;
  int? userId;

  PricingDataDetail(
      this.pricing_id,
      this.name,
      this.code,
      this.description,
      this.created_at,
      this.updated_at,
      this.pricing_status,
      this.product,
      this.mrp,
      this.ptr,
      this.pts,
      this.nrv,
      this.is_feature_product,
      this.product_status,
      this.userId);

  Map<String, Object?> toJson() => {
    PricingDataDetailFields.id:id,
    PricingDataDetailFields.pricing_id:pricing_id,
    PricingDataDetailFields.name:name,
    PricingDataDetailFields.code:code,
    PricingDataDetailFields.description:description,
    PricingDataDetailFields.created_at:created_at,
    PricingDataDetailFields.updated_at:updated_at,
    PricingDataDetailFields.pricing_status:pricing_status,
    PricingDataDetailFields.product:product,
    PricingDataDetailFields.mrp:mrp,
    PricingDataDetailFields.ptr:ptr,
    PricingDataDetailFields.pts:pts,
    PricingDataDetailFields.nrv:nrv,
    PricingDataDetailFields.is_feature_product:is_feature_product,
    PricingDataDetailFields.product_status:product_status,
    PricingDataDetailFields.userId:userId,
  };
}