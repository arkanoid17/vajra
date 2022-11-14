import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vajra/db/schemes_data_detail/schemes_data_detail.dart';
import 'package:vajra/utils/app_utils.dart';

import '../db/database_helper.dart';
import '../db/product_data_detail/product_data_detail.dart';
import '../models/common_schemes/common_schemes.dart';

class SchemeList extends StatefulWidget {
  final DatabaseHelper instance;
  final List<ProductDataDetail> itemList;

  final Map<int,List<SchemesDataDetail>> mapQps;
  final Map<int,List<SchemesDataDetail>> mapDiscount;
  final Map<int,List<SchemesDataDetail>> mapVisibility;

  const SchemeList({Key? key, required this.itemList, required this.instance, required this.mapQps, required this.mapDiscount, required this.mapVisibility})
      : super(key: key);

  State<SchemeList> createState() => _SchemeList();
}

class _SchemeList extends State<SchemeList> {

  List<int> keys = [];
  String type = 'all';

  @override
  void initState() {

    updateKeys();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
        itemCount: keys.length,
        itemBuilder: (BuildContext ctx, int index){
          return Card(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Text(getDiscountName(keys[index]))
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  String getDiscountName(int key) {
    return widget.mapQps[key]![0].discountName!;
  }

  void updateKeys() {

    print('qps ${widget.mapQps.keys.length}');
    print('discount ${widget.mapDiscount.keys.length}');
    print('visibiliy ${widget.mapVisibility.keys.length}');

    List<int> allKeys = [];
    switch(type){
      case 'all':
        allKeys.addAll(widget.mapQps.keys.toList());
        allKeys.addAll(widget.mapDiscount.keys.toList());
        allKeys.addAll(widget.mapVisibility.keys.toList());
        break;
    }

    print(allKeys.length);

    setState(() {
      keys = allKeys;
    });
  }

}
