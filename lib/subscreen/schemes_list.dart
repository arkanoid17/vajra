import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vajra/db/cart_item_data_detail/cart_item_data_detail.dart';
import 'package:vajra/db/schemes_data_detail/schemes_data_detail.dart';
import 'package:vajra/dialogs/add_discount_dialog.dart';
import 'package:vajra/dialogs/add_qps_dialog.dart';
import 'package:vajra/dialogs/add_visibility_dialog.dart';
import 'package:vajra/resource_helper/color_constants.dart';
import 'package:vajra/utils/app_utils.dart';

import '../db/database_helper.dart';
import '../db/product_data_detail/product_data_detail.dart';
import '../models/common_schemes/common_schemes.dart';
import '../resource_helper/strings.dart';

class SchemeList extends StatefulWidget {

  final DatabaseHelper instance;
  final List<ProductDataDetail> itemList;
  final Map<int, List<SchemesDataDetail>> mapQps;
  final Map<int, List<SchemesDataDetail>> mapDiscount;
  final Map<int, List<SchemesDataDetail>> mapVisibility;
  final SharedPreferences prefs;
  final String type;
  final List<int> filterKey;
  final int selectedUser;
  final Function addSchemeToCart;
  final Function navigateToCart;
  final List<CartItemDataDetail> cartItems;

  const SchemeList(
      {Key? key,
      required this.itemList,
      required this.instance,
      required this.mapQps,
      required this.mapDiscount,
      required this.mapVisibility,
      required this.prefs,
      required this.type,
      required this.filterKey,
      required this.selectedUser,
      required this.addSchemeToCart,
      required this.navigateToCart,
      required this.cartItems,
      })
      : super(key: key);

  State<SchemeList> createState() => _SchemeList();
}

class _SchemeList extends State<SchemeList> {
  List<int> keys = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    updateKeys();

    return ListView.builder(
        itemCount: keys.length,
        itemBuilder: (BuildContext ctx, int index) {
          return Card(
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 5,top: 5),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(4)),
                      color: ColorConstants.color_ECE6F6_FF),
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(child: Text(
                        getDiscountName(keys[index]),
                        style: TextStyle(color: ColorConstants.colorPrimary,fontSize: 14,fontWeight: FontWeight.w600,overflow: TextOverflow.clip),
                      ),),
                      SizedBox(width: 10,),
                      Chip(
                        label: Text(getSchemeType(keys[index]),style: TextStyle(fontSize: 12,color: ColorConstants.colorPrimary),),
                        backgroundColor: Colors.white,
                      )
                    ],
                  ),
                ),
                getSchemeView(keys[index]),
                Divider(height: 1,color: Colors.grey,),
                Padding(padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(child: Text(AppStrings.addSchemeToCart,style: TextStyle(color: Colors.grey,fontSize: 12),)),
                    SizedBox(width: 10,),
                    Container(
                      height: 30,
                        child: ElevatedButton(
                          onPressed: () {
                            showAddSchemeDialog(keys[index]);
                          },
                          child:Wrap(
                            children: [
                              checkIfSchemeAdded(keys[index])?Container():Icon(Icons.add,size: 14,),
                              SizedBox(width: 5,),
                              Text(
                                checkIfSchemeAdded(keys[index])?AppStrings.added.toUpperCase():AppStrings.add.toUpperCase(),
                                style: TextStyle(
                                    color:
                                    Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            ColorConstants.colorPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(
                                  8), // <-- Radius
                            ),
                          ),
                        ),
                    )
                  ],
                ),)
              ],
            ),
          );
        });
  }

  String getDiscountName(int key) {
    var name = '';
    if (widget.mapQps.isNotEmpty &&
        widget.mapQps[key] != null &&
        widget.mapQps[key]![0].discountName != null) {
      name = widget.mapQps[key]![0].discountName!;
    }
    if (widget.mapDiscount.isNotEmpty &&
        widget.mapDiscount[key] != null &&
        widget.mapDiscount[key]![0].discountName != null) {
      name = widget.mapDiscount[key]![0].discountName!;
    }
    if (widget.mapVisibility.isNotEmpty &&
        widget.mapVisibility[key] != null &&
        widget.mapVisibility[key]![0].discountName != null) {
      name = widget.mapVisibility[key]![0].discountName!;
    }
    return name;
  }

  void updateKeys() {
    List<int> allKeys = [];
    switch (widget.type) {
      case AppStrings.all:
        allKeys.addAll(widget.mapQps.keys.toList());
        allKeys.addAll(widget.mapDiscount.keys.toList());
        allKeys.addAll(widget.mapVisibility.keys.toList());
        break;
      case AppStrings.qps:
        allKeys.addAll(widget.mapQps.keys.toList());
        break;
      case AppStrings.discount:
        allKeys.addAll(widget.mapDiscount.keys.toList());
        break;
      case AppStrings.visibility:
        allKeys.addAll(widget.mapVisibility.keys.toList());
        break;
    }

    setState(() {
      keys = allKeys;
    });
  }

  getSchemeType(int key) {
    if (widget.mapQps.isNotEmpty &&
        widget.mapQps[key] != null) {
      return AppStrings.qps;
    }
    if (widget.mapDiscount.isNotEmpty &&
        widget.mapDiscount[key] != null) {
      return AppStrings.discount;
    }
    if (widget.mapVisibility.isNotEmpty &&
        widget.mapVisibility[key] != null) {
      return AppStrings.visibility;
    }
    return '';
  }

  

  getSchemeView(int key) {
    switch(getSchemeType(key)){
      case AppStrings.qps:
        return AppUtils.getQpsView(widget.mapQps[key]!);
      case AppStrings.discount:
        return AppUtils.getDiscountView(widget.mapDiscount[key]!,widget.prefs);
      case AppStrings.visibility:
        return AppUtils.getVisibilityView(widget.mapVisibility[key]!,widget.prefs);
      default: return Container();
    }
  }











  void showAddSchemeDialog(int key) {
    print(getSchemeType(key));
    switch(getSchemeType(key)){
      case AppStrings.qps:
        showAddQpsDialog(widget.mapQps[key]);
        break;
      case AppStrings.discount:
        showAddDiscountDialog(widget.mapDiscount[key]);
        break;
      case AppStrings.visibility:
        showAddVisibilityDialog(widget.mapVisibility[key]);
        break;
    }
  }

  void showAddQpsDialog(List<SchemesDataDetail>? qpsList) {
    AppUtils.showBottomDialog(context,true,true,Colors.white,AddToQps(qpsList: qpsList!,selectedUser: widget.selectedUser,items: widget.itemList,prefs: widget.prefs,addSchemeToCart: widget.addSchemeToCart,));
  }

  void showAddDiscountDialog(List<SchemesDataDetail>? discountList) {
    AppUtils.showBottomDialog(context,true,true,Colors.white,AddToDiscount(discountList: discountList!,selectedUser: widget.selectedUser,items: widget.itemList,prefs: widget.prefs,addSchemeToCart: widget.addSchemeToCart,));
  }

  void showAddVisibilityDialog(List<SchemesDataDetail>? visibilityList) {
    AppUtils.showBottomDialog(context,true,true,Colors.white,AddToVisibility(visibilityList: visibilityList!,selectedUser: widget.selectedUser,items: widget.itemList,prefs: widget.prefs,addSchemeToCart: widget.addSchemeToCart,));
  }

  bool checkIfSchemeAdded(int key) {
    for(var item in widget.cartItems){
      if(item.schemeId==key) {
        return true;
      }
    }
    return false;
  }



}
