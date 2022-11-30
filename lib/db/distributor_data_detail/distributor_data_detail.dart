class DistributorDataDetailFields{
  static const String  id = 'id';
  static const String  distributorId = 'distributorId';
  static const String  name = 'name';
  static const String  code = 'code';
  static const String  contactNumber = 'contactNumber';
  static const String  type = 'type';
  static const String  distributorStatus = 'distributorStatus';
  static const String  emailId = 'emailId';
  static const String  salesmanId = 'salesmanId';
  static const String  territories = 'territories';
  static const String  types = 'types';
}

class DistributorDataDetail{
   int? id;
   int? distributorId;
   String? name;
   String? code;
   String? contactNumber;
   String? type;
   bool? distributorStatus;
   String? emailId;
   int? salesmanId;
   String? territories;
   String? types;

   DistributorDataDetail(
      this.distributorId,
      this.name,
      this.code,
      this.contactNumber,
      this.type,
      this.distributorStatus,
      this.emailId,
      this.salesmanId,
      this.territories,
      this.types);

   Map<String, Object?> toJson() => {
     DistributorDataDetailFields.id:id,
     DistributorDataDetailFields.distributorId:distributorId,
     DistributorDataDetailFields.name:name,
     DistributorDataDetailFields.code:code,
     DistributorDataDetailFields.contactNumber:contactNumber,
     DistributorDataDetailFields.type:type,
     DistributorDataDetailFields.distributorStatus:distributorStatus,
     DistributorDataDetailFields.emailId:emailId,
     DistributorDataDetailFields.salesmanId:salesmanId,
     DistributorDataDetailFields.territories:territories,
     DistributorDataDetailFields.types:types,
   };

}