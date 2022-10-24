class StoreColorDataDetailFields{
  static const String id = '_id';
  static const String storeId = 'storeId';
  static const String colour = 'colour';
  static const String beat = 'beat';
  static const String salesTerritory = 'salesTerritory';
  static const String visitDate = 'visitDate';
  static const String bill = 'bill';
  static const String noBill = 'noBill';
}
class StoreColorDataDetail{
  int? id;
  String? storeId;
  int? colour;
  int? beat;
  int? salesTerritory;
  String? visitDate;
  int? bill;
  int? noBill;

  StoreColorDataDetail( this.storeId, this.colour, this.beat,
      this.salesTerritory, this.visitDate, this.bill, this.noBill);

  Map<String, Object?> toJson() => {
    StoreColorDataDetailFields.id:id,
    StoreColorDataDetailFields.storeId:storeId,
    StoreColorDataDetailFields.colour:colour,
    StoreColorDataDetailFields.beat:beat,
    StoreColorDataDetailFields.salesTerritory:salesTerritory,
    StoreColorDataDetailFields.visitDate:visitDate,
    StoreColorDataDetailFields.bill:bill,
    StoreColorDataDetailFields.noBill:noBill,
  };
}