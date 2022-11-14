class SchemeDataDetailFields{
  static const String id = '_id';
  static const String discountId = 'discountId';
  static const String productId = 'productId';
  static const String discountName = 'discountName';
  static const String productName = 'productName';
  static const String minQty = 'minQty';
  static const String tenure = 'tenure';
  static const String discountValue = 'discountValue';
  static const String discountUom = 'discountUom';
  static const String startDate = 'startDate';
  static const String endDate = 'endDate';
  static const String isQps = 'isQps';
  static const String description = 'description';
  static const String schemeTypeId = 'schemeTypeId';
  static const String schemeType = 'schemeType';
  static const String salesmanId = 'salesmanId';
}

class SchemesDataDetail{
  int? id;
  int? discountId;
  int? productId;
  String? discountName;
  String? productName;
  int? minQty;
  int? tenure;
  double? discountValue;
  String? discountUom;
  String? startDate;
  String? endDate;
  bool? isQps;
  String? description;
  int? schemeTypeId;
  String? schemeType;
  int? salesmanId;

  SchemesDataDetail(
      this.discountId,
      this.productId,
      this.discountName,
      this.productName,
      this.minQty,
      this.tenure,
      this.discountValue,
      this.discountUom,
      this.startDate,
      this.endDate,
      this.isQps,
      this.description,
      this.schemeTypeId,
      this.schemeType,
      this.salesmanId
      );

  Map<String,Object?> toJson() =>{
  SchemeDataDetailFields.id : id,
  SchemeDataDetailFields.discountId : discountId,
  SchemeDataDetailFields.productId : productId,
  SchemeDataDetailFields.discountName : discountName,
  SchemeDataDetailFields.productName : productName,
  SchemeDataDetailFields.minQty : minQty,
  SchemeDataDetailFields.tenure : tenure,
  SchemeDataDetailFields.discountValue : discountValue,
  SchemeDataDetailFields.discountUom : discountUom,
  SchemeDataDetailFields.startDate : startDate,
  SchemeDataDetailFields.endDate : endDate,
  SchemeDataDetailFields.isQps : isQps,
  SchemeDataDetailFields.description : description,
  SchemeDataDetailFields.schemeTypeId : schemeTypeId,
  SchemeDataDetailFields.schemeType : schemeType,
  SchemeDataDetailFields.salesmanId : salesmanId
  };

  factory SchemesDataDetail.fromJson(Map<dynamic, dynamic> json) =>
     SchemesDataDetail(
      json['discountId'],
      json['productId'],
      json['discountName'],
      json['productName'],
      json['minQty'],
      json['tenure'],
      json['discountValue'],
      json['discountUom'],
      json['startDate'],
      json['endDate'],
      json['isQps']==1,
      json['description'],
      json['schemeTypeId'],
      json['schemeType'],
      json['salesmanId'],
    );

}