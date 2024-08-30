import 'locations.dart';
import 'place_data.dart';
import 'user_groups.dart';
import 'user_settings.dart';
import 'salesman_distributors.dart';
import 'user_beats.dart';
import 'user_categories.dart';

class UserData {
  int? id;
  String? employName;
  String? employId;
  List<Locations>? locations;
  PlaceData? placeData;
  List<UserGroups>? groups;
  UserSettings? settings;
  List<Object>? userPermissions;
  List<Object>? userDistributors;
  List<SalesmanDistributors>? salesmanDistributors;
  List<UserBeats>? beats;
  List<Object>? products;
  List<UserCategories>? categories;
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
  List<Object>? divisions;
  List<int>? distributors;
  String? token;

  UserData(
      {this.id,
      this.employName,
      this.employId,
      this.locations,
      this.placeData,
      this.groups,
      this.settings,
      this.userPermissions,
      this.userDistributors,
      this.salesmanDistributors,
      this.beats,
      this.products,
      this.categories,
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
      this.updatedBy,
      this.divisions,
      this.distributors,
      this.token});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employName = json['employ_name'];
    employId = json['employ_id'];
    if (json['locations'] != null) {
      locations = <Locations>[];
      json['locations'].forEach((v) {
        locations!.add(Locations.fromJson(v));
      });
    }
    placeData = json['place_data'] != null
        ? PlaceData.fromJson(json['place_data'])
        : null;
    if (json['groups'] != null) {
      groups = <UserGroups>[];
      json['groups'].forEach((v) {
        groups!.add(UserGroups.fromJson(v));
      });
    }
    settings = json['settings'] != null
        ? UserSettings.fromJson(json['settings'])
        : null;
    if (json['user_permissions'] != null) {
      userPermissions = <Object>[];
      json['user_permissions'].forEach((v) {
        userPermissions!.add(v);
      });
    }
    if (json['user_distributors'] != null) {
      userDistributors = <Object>[];
      json['user_distributors'].forEach((v) {
        userDistributors!.add(v);
      });
    }
    if (json['salesman_distributors'] != null) {
      salesmanDistributors = <SalesmanDistributors>[];
      json['salesman_distributors'].forEach((v) {
        salesmanDistributors!.add(SalesmanDistributors.fromJson(v));
      });
    }
    if (json['beats'] != null) {
      beats = <UserBeats>[];
      json['beats'].forEach((v) {
        beats!.add(UserBeats.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <Object>[];
      json['products'].forEach((v) {
        products!.add(v);
      });
    }
    if (json['categories'] != null) {
      categories = <UserCategories>[];
      json['categories'].forEach((v) {
        categories!.add(UserCategories.fromJson(v));
      });
    }
    lastLogin = json['last_login'];
    tenantId = json['tenant_id'];
    userId = json['user_id'];
    name = json['name'];
    mobileNumber = json['mobile_number'];
    email = json['email'];
    isExternal = json['is_external'];
    isActive = json['is_active'];
    dateJoined = json['date_joined'];
    fcmToken = json['fcm_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isSalesman = json['is_salesman'];
    isGeoRestricted = json['is_geo_restricted'];
    place = json['place'];
    role = json['role'];
    manager = json['manager'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    if (json['divisions'] != null) {
      divisions = <Object>[];
      json['divisions'].forEach((v) {
        divisions!.add(v);
      });
    }
    if (json['distributors'] != null) {
      distributors = <int>[];
      json['distributors'].forEach((v) {
        distributors!.add(v);
      });
    }
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['employ_name'] = this.employName;
    data['employ_id'] = this.employId;
    if (this.locations != null) {
      data['locations'] = this.locations!.map((v) => v.toJson()).toList();
    }
    if (this.placeData != null) {
      data['place_data'] = this.placeData!.toJson();
    }
    if (this.groups != null) {
      data['groups'] = this.groups!.map((v) => v.toJson()).toList();
    }
    if (this.settings != null) {
      data['settings'] = this.settings!.toJson();
    }
    if (this.userPermissions != null) {
      data['user_permissions'] = this.userPermissions!.map((v) => v).toList();
    }
    if (this.userDistributors != null) {
      data['user_distributors'] = this.userDistributors!.map((v) => v).toList();
    }
    if (this.salesmanDistributors != null) {
      data['salesman_distributors'] =
          this.salesmanDistributors!.map((v) => v.toJson()).toList();
    }
    if (this.beats != null) {
      data['beats'] = this.beats!.map((v) => v.toJson()).toList();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v).toList();
    }
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v).toList();
    }
    data['last_login'] = this.lastLogin;
    data['tenant_id'] = this.tenantId;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['mobile_number'] = this.mobileNumber;
    data['email'] = this.email;
    data['is_external'] = this.isExternal;
    data['is_active'] = this.isActive;
    data['date_joined'] = this.dateJoined;
    data['fcm_token'] = this.fcmToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_salesman'] = this.isSalesman;
    data['is_geo_restricted'] = this.isGeoRestricted;
    data['place'] = this.place;
    data['role'] = this.role;
    data['manager'] = this.manager;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    if (this.divisions != null) {
      data['divisions'] = this.divisions!.map((v) => v).toList();
    }
    if (this.distributors != null) {
      data['distributors'] = this.distributors!.map((v) => v).toList();
    }
    data['token'] = this.token;
    return data;
  }
}
