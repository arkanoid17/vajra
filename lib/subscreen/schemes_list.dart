import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vajra/db/schemes_data_detail/schemes_data_detail.dart';
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

  const SchemeList(
      {Key? key,
      required this.itemList,
      required this.instance,
      required this.mapQps,
      required this.mapDiscount,
      required this.mapVisibility,
      required this.prefs,
        required this.type})
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

                          },
                          child:Wrap(
                            children: [
                              Icon(Icons.add,size: 14,),
                              SizedBox(width: 5,),
                              Text(
                                AppStrings.add.toUpperCase(),
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
        return getQpsView(widget.mapQps[key]!);
      case AppStrings.discount:
        return getDiscountView(widget.mapDiscount[key]!);
      case AppStrings.visibility:
        return getVisibilityView(widget.mapVisibility[key]!);
      default: return Container();
    }
  }

  getItemRows(List<SchemesDataDetail> paid) {
    List<Widget> widgets = [];
    for (SchemesDataDetail scheme in paid){
      widgets.add(Row(
        children: [
          Expanded(
              child: Text('${scheme.minQty} ${AppStrings.itemsOf}',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: Colors.black),)
          ),
          Text(scheme.productName!,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: Colors.black))
        ],
      )) ;
    }
    return widgets;
  }

  Widget getQpsView(List<SchemesDataDetail> list) {
    List<SchemesDataDetail> free = list.where((element) => element.isQps!).toList();
    List<SchemesDataDetail> paid = list.where((element) => !element.isQps!).toList();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5,),
          Text(AppStrings.buy,style: TextStyle(color: Colors.grey,fontSize: 12),),
          SizedBox(height: 10,),
          Column(children: getItemRows(paid),),
          SizedBox(height: 10,),
          Text(AppStrings.get,style: TextStyle(color: Colors.grey,fontSize: 12),),
          SizedBox(height: 10,),
          Column(children: getItemRows(free),),
          SizedBox(height: 10,),
        ],
      )
    );
  }

  getDiscountView(List<SchemesDataDetail> list) {
    List<SchemesDataDetail> paid = list.where((element) => !element.isQps!).toList();
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5,),
            const Text(AppStrings.buy,style: TextStyle(color: Colors.grey,fontSize: 12),),
            const SizedBox(height: 10,),
            Column(children: getItemRows(paid),),
            const SizedBox(height: 20,),
            Wrap(
              children: [
                Text(AppStrings.getDiscountOf,style: TextStyle(color: Colors.grey,fontSize: 12),),
                SizedBox(width: 5,),
                getDiscountAmountView(paid[0])
              ],
            )
          ],
        )
    );
  }

  getDiscountAmountView(SchemesDataDetail disc) {
    Widget view = Container();
    if(disc.discountUom=='INR') {
      view = Text('${AppUtils.getCurrency(widget.prefs)} ${disc.discountValue}',style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w600),);
    }
    if(disc.discountUom=='%') {
      view = Text('${disc.discountValue} ${disc.discountUom}',style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w600),);
    }
    return view;
  }

  getVisibilityView(List<SchemesDataDetail> list) {
    List<SchemesDataDetail> paid = list.where((element) => !element.isQps!).toList();
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5,),
            const Text(AppStrings.buy,style: TextStyle(color: Colors.grey,fontSize: 12),),
            const SizedBox(height: 10,),
            Column(children: getVisibilityItemRows(paid),),
            const SizedBox(height: 20,),
            Row(
              children: [
                Expanded(child: Text('${AppStrings.worth}:',style: TextStyle(fontSize: 12,color: Colors.grey),)),
                Text('${paid[0].minPurchaseValue}',style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w600),),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Text('${AppStrings.andMaintainDisplayOf} ',style: TextStyle(fontSize: 12,color: Colors.grey),),
                Text('${paid[0].tenure} ${AppStrings.days} ',style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w600),),
                Text('${AppStrings.toGet} ',style: TextStyle(fontSize: 12,color: Colors.grey),),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                const Expanded(child: Text('${AppStrings.offerValue}:',style: TextStyle(fontSize: 12,color: Colors.grey),)),
                Text('${AppUtils.getCurrency(widget.prefs)} ${paid[0].discountValue}',style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w600),),
              ],
            ),
          ],
        )
    );
  }

  getVisibilityItemRows(List<SchemesDataDetail> paid) {
    List<Widget> widgets = [];
    for (SchemesDataDetail scheme in paid){
      widgets.add(Row(
        children: [
          Expanded(
              child: Text(scheme.productName!,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: Colors.black))
          ),
        ],
      )) ;
    }
    return widgets;
  }
}
