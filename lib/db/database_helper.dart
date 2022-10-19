import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vajra/db/activity_data_detail/activity_data_detail.dart';
import 'package:vajra/db/channel_data_detail/channel_data_detail.dart';
import 'package:vajra/db/form_actions_data_detail/form_action_data_details.dart';
import 'package:vajra/db/pending_task_data_detail/pending_task_data_detail.dart';
import 'package:vajra/db/places_data_detail/places_data_detail.dart';
import 'package:vajra/db/product_data_detail/product_data_detail.dart';
import 'package:vajra/db/schemes_data_detail/schemes_data_detail.dart';
import 'package:vajra/db/store_types_data_detail/store_types_data_detail.dart';
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

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  DatabaseHelper._privateConstructor();

  static Database? _database;

  final String primaryKeyAutoIncrement = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  final String primaryKey = 'INTEGER PRIMARY KEY';
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
        '${ProductDataFields.schemeId} $integer'
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


  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
