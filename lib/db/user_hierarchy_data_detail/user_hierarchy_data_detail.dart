
class UserHierarchyDataDetailFields{
  static const String id = '_id';
  static const String serverId = 'serverId';
  static const String employName = 'employName';
  static const String employId = 'employId';
  static const String locations = 'locations';
  static const String salesmanDistributors = 'salesmanDistributors' ;
  static const String beats  = 'beats';
  static const String lastLogin = 'lastLogin';
  static const String tenantId = 'tenantId';
  static const String userId = 'userId';
  static const String name = 'name';
  static const String mobileNumber = 'mobileNumber';
  static const String email = 'email';
  static const String isExternal = 'isExternal';
  static const String isActive = 'isActive';
  static const String dateJoined = 'dateJoined';
  static const String fcmToken = 'fcmToken';
  static const String createdAt = 'createdAt';
  static const String updatedAt = 'updatedAt';
  static const String isSalesman = 'isSalesman';
  static const String isGeoRestricted = 'isGeoRestricted';
  static const String place = 'place';
  static const String role = 'role';
  static const String manager = 'manager';
  static const String createdBy = 'createdBy';
  static const String updatedBy = 'updatedBy';
}

class UserHierarchyDataDetail{
  int? id;
  int? serverId;
  String? employName;
  String? employId;
  String? locations;
  String? salesmanDistributors ;
  String? beats ;
  String? lastLogin;
  String? tenantId;
  String? userId;
  String? name;
  String? mobileNumber;
  String? email;
  bool? isExternal;
  bool? isActive;
  String? dateJoined;
  String? fcmToken;
  String? createdAt;
  String? updatedAt;
  bool? isSalesman;
  bool? isGeoRestricted;
  int? place;
  int? role;
  int? manager;
  int? createdBy;
  int? updatedBy;

  UserHierarchyDataDetail(
      this.serverId,
      this.employName,
      this.employId,
      this.locations,
      this.salesmanDistributors,
      this.beats,
      this.lastLogin,
      this.tenantId,
      this.userId,
      this.name,
      this.mobileNumber,
      this.email,
      this.isExternal,
      this.isActive,
      this.dateJoined,
      this.fcmToken,
      this.createdAt,
      this.updatedAt,
      this.isSalesman,
      this.isGeoRestricted,
      this.place,
      this.role,
      this.manager,
      this.createdBy,
      this.updatedBy);

  Map<String,Object?> toJson() =>{
    UserHierarchyDataDetailFields.id: id,
    UserHierarchyDataDetailFields.serverId: serverId,
    UserHierarchyDataDetailFields.employName: employName,
    UserHierarchyDataDetailFields.employId: employId,
    UserHierarchyDataDetailFields.locations: locations,
    UserHierarchyDataDetailFields.salesmanDistributors: salesmanDistributors,
    UserHierarchyDataDetailFields.beats: beats,
    UserHierarchyDataDetailFields.lastLogin: lastLogin,
    UserHierarchyDataDetailFields.tenantId: tenantId,
    UserHierarchyDataDetailFields.userId: userId,
    UserHierarchyDataDetailFields.name: name,
    UserHierarchyDataDetailFields.mobileNumber: mobileNumber,
    UserHierarchyDataDetailFields.email: email,
    UserHierarchyDataDetailFields.isExternal: isExternal,
    UserHierarchyDataDetailFields.isActive: isActive,
    UserHierarchyDataDetailFields.dateJoined: dateJoined,
    UserHierarchyDataDetailFields.fcmToken: fcmToken,
    UserHierarchyDataDetailFields.createdAt: createdAt,
    UserHierarchyDataDetailFields.updatedAt: updatedAt,
    UserHierarchyDataDetailFields.isSalesman: isSalesman,
    UserHierarchyDataDetailFields.isGeoRestricted: isGeoRestricted,
    UserHierarchyDataDetailFields.role: role,
    UserHierarchyDataDetailFields.place: place,
    UserHierarchyDataDetailFields.manager: manager,
    UserHierarchyDataDetailFields.createdBy: createdBy,
    UserHierarchyDataDetailFields.updatedBy: updatedBy,
  };

}