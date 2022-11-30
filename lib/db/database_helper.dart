import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vajra/db/activity_data_detail/activity_data_detail.dart';
import 'package:vajra/db/cart_item_data_detail/cart_item_data_detail.dart';
import 'package:vajra/db/cart_item_data_detail/cart_item_distributor_type.dart';
import 'package:vajra/db/channel_data_detail/channel_data_detail.dart';
import 'package:vajra/db/distributor_data_detail/distributor_data_detail.dart';
import 'package:vajra/db/form_actions_data_detail/form_action_data_details.dart';
import 'package:vajra/db/pending_task_data_detail/pending_task_data_detail.dart';
import 'package:vajra/db/places_data_detail/places_data_detail.dart';
import 'package:vajra/db/pricing_data_detail/pricing_data_detail.dart';
import 'package:vajra/db/product_data_detail/product_data_detail.dart';
import 'package:vajra/db/product_distributor_type_data_detail/product_distributor_type_data_detail.dart';
import 'package:vajra/db/reasons_data_detail/reasons_data_detail.dart';
import 'package:vajra/db/schemes_data_detail/schemes_data_detail.dart';
import 'package:vajra/db/store_beat_mapping_data_detail/store_beat_mapping_data_detail.dart';
import 'package:vajra/db/store_color_data_detail/store_color_data_detail.dart';
import 'package:vajra/db/store_price_mapping_data_detail/store_price_mapping_data_detail.dart';
import 'package:vajra/db/store_types_data_detail/store_types_data_detail.dart';
import 'package:vajra/db/stores_data_detail/stores_data_detail.dart';
import 'package:vajra/db/user_hierarchy_data_detail/user_hierarchy_data_detail.dart';
import 'package:vajra/db/user_stats_data_detail/user_stats_data_detail.dart';
import 'package:vajra/utils/app_utils.dart';
import 'package:path/path.dart' as p;

class DatabaseHelper {


  static const _databaseName = "vajra.db";
  static const _databaseVersion = 1;

  //tables
  final String tableUserHierarchyDataDetail = 'user_hierarchy_data_detail';
  final String productDataDetail = 'product_data_detail';
  final String schemesDataDetail = 'schemes_data_detail';
  final String channelDataDetail = 'channel_data_detail';
  final String placeDataDetail = 'place_data_detail';
  final String pendingTaskDataDetail = 'pending_task_data_detail';
  final String activitiesDataDetail = 'activity_data_detail';
  final String userStatsDataDetail = 'user_stats_data_detail';
  final String storeTypesDataDetail = 'store_types_data_detail';
  final String formActionsDataDetail = 'form_actions_data_detail';
  final String reasonsDataDetail = 'reasons_data_detail';
  final String storeDataDetail = 'store_data_detail';
  final String storeBeatMappingDataDetail = 'store_beat_mapping_data_detail';
  final String storeColorDataDetail = 'store_color_data_detail';
  final String storePriceMappingDataDetail = 'store_price_mapping_data_detail';
  final String pricingDataDetail = 'price_data_detail';
  final String cartItemDataDetail = 'cart_item_data_detail';
  final String cartItemDistributorTypeDataDetail = 'cart_item_distributor_type_data_detail';
  final String productDataDistributorTypeDataDetail = 'product_data_distributor_type_data_detail';
  final String distributorDataDetail = 'distributor_data_detail';

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  DatabaseHelper._privateConstructor();

  static Database? _database;

  final String primaryKeyAutoIncrement = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  final String primaryKey = 'INTEGER PRIMARY KEY';
  final String primaryKeyText = 'TEXT PRIMARY KEY';
  final String integer = 'INTEGER';
  final String real = 'REAL';
  final String text = 'TEXT';
  final String boolean = 'BOOLEAN';

  late String path;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
     path = p.join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future<void> deleteDatabase() =>
      databaseFactory.deleteDatabase(path);


  Future _onCreate(Database db, int version) async {

    //hierarchy table
    await db.execute(''
        'CREATE TABLE $tableUserHierarchyDataDetail '
        '(${UserHierarchyDataDetailFields.id} $primaryKeyAutoIncrement,'
        '${UserHierarchyDataDetailFields.serverId} $integer,'
        '${UserHierarchyDataDetailFields.employName} $text,'
        '${UserHierarchyDataDetailFields.employId} $text,'
        '${UserHierarchyDataDetailFields.locations} $text,'
        '${UserHierarchyDataDetailFields.salesmanDistributors} $text,'
        '${UserHierarchyDataDetailFields.beats} $text,'
        '${UserHierarchyDataDetailFields.lastLogin} $text,'
        '${UserHierarchyDataDetailFields.tenantId} $text,'
        '${UserHierarchyDataDetailFields.userId} $text,'
        '${UserHierarchyDataDetailFields.name} $text,'
        '${UserHierarchyDataDetailFields.mobileNumber} $text,'
        '${UserHierarchyDataDetailFields.email} $text,'
        '${UserHierarchyDataDetailFields.isExternal} $boolean,'
        '${UserHierarchyDataDetailFields.isActive} $boolean,'
        '${UserHierarchyDataDetailFields.dateJoined} $text,'
        '${UserHierarchyDataDetailFields.fcmToken} $text,'
        '${UserHierarchyDataDetailFields.createdAt} $text,'
        '${UserHierarchyDataDetailFields.updatedAt} $text,'
        '${UserHierarchyDataDetailFields.isSalesman} $boolean,'
        '${UserHierarchyDataDetailFields.isGeoRestricted} $boolean,'
        '${UserHierarchyDataDetailFields.place} $integer,'
        '${UserHierarchyDataDetailFields.role} $integer,'
        '${UserHierarchyDataDetailFields.manager} $integer,'
        '${UserHierarchyDataDetailFields.createdBy} $integer,'
        '${UserHierarchyDataDetailFields.updatedBy} $integer'
        '  )');

    //product table
    await db.execute(' '
        'CREATE TABLE $productDataDetail'
        '('
        '${ProductDataFields.id} $primaryKeyAutoIncrement,'
        '${ProductDataFields.productName} $text,'
        '${ProductDataFields.productId} $integer,'
        '${ProductDataFields.barcodeNumber} $text,'
        '${ProductDataFields.hsnNumber} $text,'
        '${ProductDataFields.description} $text,'
        '${ProductDataFields.manufacturer} $text,'
        '${ProductDataFields.productCategory} $text,'
        '${ProductDataFields.scope} $text,'
        '${ProductDataFields.mrp} $text,'
        '${ProductDataFields.nrv} $text,'
        '${ProductDataFields.ptr} $text,'
        '${ProductDataFields.taxType} $text,'
        '${ProductDataFields.isQps} $boolean,'
        '${ProductDataFields.discountValue} $integer,'
        '${ProductDataFields.productStatus} $boolean,'
        '${ProductDataFields.quantityLimit} $integer,'
        '${ProductDataFields.taxValue} $text,'
        '${ProductDataFields.pts} $text,'
        '${ProductDataFields.netPrice} $text,'
        '${ProductDataFields.isFeatureProduct} $boolean,'
        '${ProductDataFields.packs} $text,'
        '${ProductDataFields.pricingId} $integer,'
        '${ProductDataFields.pricingNodeId} $integer,'
        '${ProductDataFields.queryNodeId} $integer,'
        '${ProductDataFields.channel} $integer,'
        '${ProductDataFields.count} $integer,'
        '${ProductDataFields.packCount} $integer,'
        '${ProductDataFields.image} $text,'
        '${ProductDataFields.salesmanId} $integer,'
        '${ProductDataFields.brand} $text,'
        '${ProductDataFields.schemeId} $integer,'
        '${ProductDataFields.schemeCount} $integer'
        ')');

    await db.execute('CREATE TABLE ${instance.productDataDistributorTypeDataDetail}'
        '('
        '${ProductDataDistributorTypeDataDetailFields.id} $primaryKeyAutoIncrement,'
        '${ProductDataDistributorTypeDataDetailFields.productId} $integer,'
        '${ProductDataDistributorTypeDataDetailFields.salesmanId} $integer,'
        '${ProductDataDistributorTypeDataDetailFields.distributorTypeId} $integer,'
        '${ProductDataDistributorTypeDataDetailFields.distributorTypeName} $text'
        ')');

    //schemes table
    await db.execute('CREATE TABLE $schemesDataDetail'
        '('
        '${SchemeDataDetailFields.id} $primaryKeyAutoIncrement,'
        '${SchemeDataDetailFields.discountId} $integer,'
        '${SchemeDataDetailFields.productId} $integer,'
        '${SchemeDataDetailFields.discountName} $text,'
        '${SchemeDataDetailFields.productName} $text,'
        '${SchemeDataDetailFields.minQty} $integer,'
        '${SchemeDataDetailFields.tenure} $integer,'
        '${SchemeDataDetailFields.minPurchaseValue} $real,'
        '${SchemeDataDetailFields.discountValue} $real,'
        '${SchemeDataDetailFields.discountUom} $text,'
        '${SchemeDataDetailFields.startDate} $text,'
        '${SchemeDataDetailFields.endDate} $text,'
        '${SchemeDataDetailFields.isQps} $boolean,'
        '${SchemeDataDetailFields.description} $text,'
        '${SchemeDataDetailFields.schemeTypeId} $integer,'
        '${SchemeDataDetailFields.schemeType} $text,'
        '${SchemeDataDetailFields.salesmanId} $integer'
        ')'
    );

    await db.execute('CREATE TABLE $channelDataDetail'
        '('
        '${ChannelDataDetailFields.id} $primaryKey,'
        '${ChannelDataDetailFields.tenantId} $text,'
        '${ChannelDataDetailFields.name} $text,'
        '${ChannelDataDetailFields.status} $boolean,'
        '${ChannelDataDetailFields.description} $text,'
        '${ChannelDataDetailFields.createdAt} $text,'
        '${ChannelDataDetailFields.updatedAt} $text'
        ')'
    );

    await db.execute('CREATE TABLE $placeDataDetail'
        '('
        '${PlacesDataDetailFields.id} $primaryKeyAutoIncrement,'
        '${PlacesDataDetailFields.placeId} $integer,'
        '${PlacesDataDetailFields.tenantId} $text,'
        '${PlacesDataDetailFields.name} $text,'
        '${PlacesDataDetailFields.createdAt} $text,'
        '${PlacesDataDetailFields.updatedAt} $text,'
        '${PlacesDataDetailFields.isTerritory} $boolean,'
        '${PlacesDataDetailFields.type} $integer,'
        '${PlacesDataDetailFields.parent} $integer'
        ')'
    );

    await db.execute('CREATE TABLE $pendingTaskDataDetail'
        '('
        '${PendingTaskDataDetailFields.id} $primaryKey,'
        '${PendingTaskDataDetailFields.form} $text,'
        '${PendingTaskDataDetailFields.instance} $text,'
        '${PendingTaskDataDetailFields.submittedBy} $text,'
        '${PendingTaskDataDetailFields.taskName} $text,'
        '${PendingTaskDataDetailFields.status} $text,'
        '${PendingTaskDataDetailFields.createdAt} $text,'
        '${PendingTaskDataDetailFields.updatedAt} $text,'
        '${PendingTaskDataDetailFields.startDate} $text,'
        '${PendingTaskDataDetailFields.expireDate} $text,'
        '${PendingTaskDataDetailFields.submittedAt} $text,'
        '${PendingTaskDataDetailFields.checksum} $text,'
        '${PendingTaskDataDetailFields.data} $text,'
        '${PendingTaskDataDetailFields.actor} $text,'
        '${PendingTaskDataDetailFields.group} $integer,'
        '${PendingTaskDataDetailFields.step} $integer,'
        '${PendingTaskDataDetailFields.storeId} $text'
        ')'
    );

    await db.execute('CREATE TABLE $activitiesDataDetail'
        '('
        '${ActivityDataDetailFields.id} $primaryKey,'
        '${ActivityDataDetailFields.name} $text,'
        '${ActivityDataDetailFields.startDate} $text,'
        '${ActivityDataDetailFields.endDate} $text,'
        '${ActivityDataDetailFields.isActive} $text'
        ')'
    );

    await db.execute('CREATE TABLE $userStatsDataDetail'
        '('
        '${UserStatsDataDetailFields.id} $primaryKeyAutoIncrement,'
        '${UserStatsDataDetailFields.status} $text,'
        '${UserStatsDataDetailFields.monthNrv} $real,'
        '${UserStatsDataDetailFields.todayNrv} $real,'
        '${UserStatsDataDetailFields.monthBilled} $integer,'
        '${UserStatsDataDetailFields.monthUnbilled} $integer,'
        '${UserStatsDataDetailFields.todayBilled} $integer,'
        '${UserStatsDataDetailFields.todayUnbilled} $integer'
        ')'
    );

    await db.execute('CREATE TABLE $storeTypesDataDetail'
        '('
        '${StoreTypesDataDetailFields.id} $primaryKey,'
        '${StoreTypesDataDetailFields.name} $text'
        ')'
    );

    await db.execute('CREATE TABLE $formActionsDataDetail'
        '('
        '${FormActionsDataDetailsFields.id} $primaryKey,'
        '${FormActionsDataDetailsFields.tenantId} $text,'
        '${FormActionsDataDetailsFields.name} $text,'
        '${FormActionsDataDetailsFields.description} $text,'
        '${FormActionsDataDetailsFields.status} $boolean,'
        '${FormActionsDataDetailsFields.createdAt} $text,'
        '${FormActionsDataDetailsFields.updatedAt} $text,'
        '${FormActionsDataDetailsFields.actor} $integer,'
        '${FormActionsDataDetailsFields.group} $integer,'
        '${FormActionsDataDetailsFields.process} $integer,'
        '${FormActionsDataDetailsFields.category} $text,'
        '${FormActionsDataDetailsFields.formContent} $text,'
        '${FormActionsDataDetailsFields.documentType} $text,'
        '${FormActionsDataDetailsFields.permissionId} $integer'
        ')'

    );

    await db.execute('CREATE TABLE $reasonsDataDetail'
        '('
        '${ReasonDataDetailsFields.id} $primaryKey,'
        '${ReasonDataDetailsFields.tenantId} $text,'
        '${ReasonDataDetailsFields.value} $text,'
        '${ReasonDataDetailsFields.groupName} $text,'
        '${ReasonDataDetailsFields.label} $text,'
        '${ReasonDataDetailsFields.status} $boolean,'
        '${ReasonDataDetailsFields.createdAt} $text,'
        '${ReasonDataDetailsFields.updatedAt} $text'
        ')'
    );

    await db.execute('CREATE TABLE $storeDataDetail'
        '('
        '${StoresDataDetailFields.outletId} $primaryKeyText,'
        '${StoresDataDetailFields.storeId} $text,'
        '${StoresDataDetailFields.storeName} $text,'
        '${StoresDataDetailFields.storeLatitude} $text,'
        '${StoresDataDetailFields.storeLongitude} $text,'
        '${StoresDataDetailFields.beats} $text,'
        '${StoresDataDetailFields.distributorRelation} $text,'
        '${StoresDataDetailFields.tenantId} $text,'
        '${StoresDataDetailFields.name} $text,'
        '${StoresDataDetailFields.ownerName} $text,'
        '${StoresDataDetailFields.managerName} $text,'
        '${StoresDataDetailFields.contactNo} $text,'
        '${StoresDataDetailFields.alternateNo} $text,'
        '${StoresDataDetailFields.division} $text,'
        '${StoresDataDetailFields.outletLatitude} $text,'
        '${StoresDataDetailFields.outletLongitude} $text,'
        '${StoresDataDetailFields.outletAccuracy} $text,'
        '${StoresDataDetailFields.storeStatus} $boolean,'
        '${StoresDataDetailFields.description} $text,'
        '${StoresDataDetailFields.surveyStatus} $boolean,'
        '${StoresDataDetailFields.colorStatus} $integer,'
        '${StoresDataDetailFields.otpSent} $boolean,'
        '${StoresDataDetailFields.otpVerified} $boolean,'
        '${StoresDataDetailFields.otpSentAlternate} $boolean,'
        '${StoresDataDetailFields.otpVerifiedAlternate} $boolean,'
        '${StoresDataDetailFields.sms} $boolean,'
        '${StoresDataDetailFields.tele} $boolean,'
        '${StoresDataDetailFields.email} $boolean,'
        '${StoresDataDetailFields.createdAt} $text,'
        '${StoresDataDetailFields.updatedAt} $text,'
        '${StoresDataDetailFields.source} $text,'
        '${StoresDataDetailFields.companyOutletCode} $text,'
        '${StoresDataDetailFields.metaData} $text,'
        '${StoresDataDetailFields.taxType} $text,'
        '${StoresDataDetailFields.taxId} $text,'
        '${StoresDataDetailFields.outletType} $integer,'
        '${StoresDataDetailFields.channel} $integer,'
        '${StoresDataDetailFields.territory} $integer,'
        '${StoresDataDetailFields.beat} $integer,'
        '${StoresDataDetailFields.createdBy} $integer,'
        '${StoresDataDetailFields.updatedBy} $integer,'
        '${StoresDataDetailFields.distance} $text,'
        '${StoresDataDetailFields.salesmanId} $integer,'
        '${StoresDataDetailFields.schemes} $text,'
        '${StoresDataDetailFields.gstNumber} $text,'
        '${StoresDataDetailFields.licenceNumber} $text,'
        '${StoresDataDetailFields.address} $text,'
        '${StoresDataDetailFields.remarks} $text'
        ')'
    );

    await db.execute('CREATE TABLE $storeBeatMappingDataDetail'
        '('
        '${StoreBeatMappingDataDetailFields.id} $primaryKeyAutoIncrement,'
        '${StoreBeatMappingDataDetailFields.storeId} $text,'
        '${StoreBeatMappingDataDetailFields.beatId} $integer,'
        '${StoreBeatMappingDataDetailFields.beatName} $text,'
        '${StoreBeatMappingDataDetailFields.salesmanId} $integer'
        ')'
    );

    await db.execute('CREATE TABLE $storeColorDataDetail'
        '('
        '${StoreColorDataDetailFields.id} $primaryKeyAutoIncrement,'
        '${StoreColorDataDetailFields.storeId} $text,'
        '${StoreColorDataDetailFields.colour} $integer,'
        '${StoreColorDataDetailFields.beat} $integer,'
        '${StoreColorDataDetailFields.salesTerritory} $integer,'
        '${StoreColorDataDetailFields.visitDate} $text,'
        '${StoreColorDataDetailFields.bill} $integer,'
        '${StoreColorDataDetailFields.noBill} $integer'
        ')'
    );

    await db.execute('CREATE TABLE $storePriceMappingDataDetail'
        '('
        '${StorePriceMappingDataDetailFields.id} $primaryKeyAutoIncrement,'
        '${StorePriceMappingDataDetailFields.storeId} $text,'
        '${StorePriceMappingDataDetailFields.scope} $text,'
        '${StorePriceMappingDataDetailFields.pricingList} $integer,'
        '${StorePriceMappingDataDetailFields.status} $boolean,'
        '${StorePriceMappingDataDetailFields.userId} $integer'
        ')'
    );

    await db.execute('CREATE TABLE $pricingDataDetail'
        '('
        '${PricingDataDetailFields.id} $primaryKeyAutoIncrement,'
        '${PricingDataDetailFields.pricing_id} $integer,'
        '${PricingDataDetailFields.name} $text,'
        '${PricingDataDetailFields.code} $text,'
        '${PricingDataDetailFields.description} $text,'
        '${PricingDataDetailFields.created_at} $text,'
        '${PricingDataDetailFields.updated_at} $text,'
        '${PricingDataDetailFields.pricing_status} $boolean,'
        '${PricingDataDetailFields.product} $integer,'
        '${PricingDataDetailFields.mrp} $text,'
        '${PricingDataDetailFields.ptr} $text,'
        '${PricingDataDetailFields.pts} $text,'
        '${PricingDataDetailFields.nrv} $text,'
        '${PricingDataDetailFields.is_feature_product} $boolean,'
        '${PricingDataDetailFields.product_status} $boolean,'
        '${PricingDataDetailFields.userId} $integer'
        ')'
    );



    await db.execute('CREATE TABLE ${instance.cartItemDataDetail}'
        '('
        '${CartItemDataDetailFields.id} $primaryKeyAutoIncrement,'
        '${CartItemDataDetailFields.storeId} $text,'
        '${CartItemDataDetailFields.productId} $integer,'
        '${CartItemDataDetailFields.productName} $text,'
        '${CartItemDataDetailFields.isFree} $integer,'
        '${CartItemDataDetailFields.packId} $integer,'
        '${CartItemDataDetailFields.packValue} $integer,'
        '${CartItemDataDetailFields.packCount} $integer,'
        '${CartItemDataDetailFields.count} $integer,'
        '${CartItemDataDetailFields.schemeId} $integer,'
        '${CartItemDataDetailFields.createdAt} $text,'
        '${CartItemDataDetailFields.updatedAt} $text'
        ')'
    );

    await db.execute('CREATE TABLE ${instance.cartItemDistributorTypeDataDetail}'
        '('
        '${CartItemDistributorTypeFields.id} $primaryKeyAutoIncrement,'
        '${CartItemDistributorTypeFields.cartId} $integer,'
        '${CartItemDistributorTypeFields.distributorTypeId} $integer,'
        '${CartItemDistributorTypeFields.distributorTypeName} $integer,'
        'FOREIGN KEY(${CartItemDistributorTypeFields.cartId}) REFERENCES ${instance.cartItemDataDetail}(${CartItemDataDetailFields.id}) ON UPDATE NO ACTION ON DELETE CASCADE'
        ')');

    await db.execute('CREATE TABLE ${instance.distributorDataDetail}'
        '('
        '${DistributorDataDetailFields.id} $primaryKeyAutoIncrement,'
        '${DistributorDataDetailFields.distributorId} $integer,'
        '${DistributorDataDetailFields.name} $text,'
        '${DistributorDataDetailFields.code} $text,'
        '${DistributorDataDetailFields.contactNumber} $text,'
        '${DistributorDataDetailFields.type} $text,'
        '${DistributorDataDetailFields.distributorStatus} $bool,'
        '${DistributorDataDetailFields.emailId} $text,'
        '${DistributorDataDetailFields.salesmanId} $integer,'
        '${DistributorDataDetailFields.territories} $text,'
        '${DistributorDataDetailFields.types} $text'
        ')'
    );


  }


  Future<int> insert(String table,Map<String,dynamic> row) async{
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<int> deleteAllData(String table) async{
    Database db = await instance.database;
    return await db.delete(table);
  }

  Future<int?> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $tableUserHierarchyDataDetail'));
  }

  Future<List<Map>> execQuery(String query) async{
    Database db = await instance.database;
    List<Map> result = await db.rawQuery(query);
    return result;
  }


  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
