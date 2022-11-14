import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:vajra/db/database_helper.dart';
import 'package:vajra/db/schemes_data_detail/schemes_data_detail.dart';
import 'package:vajra/db/stores_data_detail/stores_data_detail.dart';
import 'package:vajra/models/user_hierarchy/distributor_types.dart';
import 'package:vajra/resource_helper/strings.dart';
import 'package:vajra/screens/book_order.dart';

import '../db/cart_item_data_detail/cart_item_data_detail.dart';
import '../db/product_data_detail/product_data_detail.dart';
import '../db/product_distributor_type_data_detail/product_distributor_type_data_detail.dart';
import '../models/product/pack.dart';
import '../resource_helper/color_constants.dart';
import '../utils/app_utils.dart';

class ItemList extends StatefulWidget {
  final List<ProductDataDetail> itemList;
  final DatabaseHelper instance;
  final Function addToCart;
  final StoresDataDetail store;
  final List<CartItemDataDetail> cartItems;
  final Function updateCartItem;

  const ItemList({Key? key, required this.itemList, required this.instance, required this.addToCart, required this.store, required this.cartItems, required this.updateCartItem}) : super(key: key);

  State<ItemList> createState() => _ItemList();
}

class _ItemList extends State<ItemList> {
  late DatabaseHelper instance;

  @override
  void initState() {
    setState(() {
      instance = widget.instance;
    });


    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
        itemCount: widget.itemList.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius:
              BorderRadius.all(Radius.circular(8)),
              border: Border.all(
                  color: ColorConstants.color_FFE5E5E5,
                  width: 1),
            ),

            margin: EdgeInsets.only(left: 10,right: 10,bottom: 5,top: 5),
            child: Column(
              children: [
                Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                        widget.itemList[index].productName!,
                        maxLines: 2,
                        overflow: TextOverflow.clip,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      PopupMenuButton<int>(itemBuilder: (context) => getPacks(widget.itemList[index].packs!).map((e) => PopupMenuItem<int>(
                        value: e.id,
                        child: Text(
                          e.name!,
                        ),
                      )).toList(),
                        onSelected: (value)=> onPackChanged(value,index),
                        child:  Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(child: Text(getPackName(widget.itemList[index].packs),style: TextStyle(color: Colors.grey),)),
                              Icon(Icons.arrow_drop_down,color: Colors.grey.shade400,)
                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text('${AppStrings.mrp}: ',style: TextStyle(color: Colors.black,fontSize: 10,fontWeight: FontWeight.w300),),),
                          Expanded(
                              flex: 8,
                              child: Text(' \u20B9 ${widget.itemList[index].mrp!}',style: TextStyle(color: Colors.black,fontSize: 10,fontWeight: FontWeight.w600),))
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text('${AppStrings.ptr}: ',style: TextStyle(color: Colors.black,fontSize: 10,fontWeight: FontWeight.w300),)),
                          Expanded(
                              flex: 8,
                              child: Text(' \u20B9 ${widget.itemList[index].ptr!}',style: TextStyle(color: Colors.black,fontSize: 10,fontWeight: FontWeight.w600),))
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text('${AppStrings.nrv}: ',style: TextStyle(color: Colors.black,fontSize: 10,fontWeight: FontWeight.w300),)),
                          Expanded(
                              flex: 8,
                              child: Text(' \u20B9 ${widget.itemList[index].nrv!}',style: TextStyle(color: Colors.black,fontSize: 10,fontWeight: FontWeight.w600),))
                        ],
                      ),
                      SizedBox(width: 5,),

                    ],
                  ),
                ),
                Expanded(flex: 3, child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.asset('assets/images/ic_product_default.png'),
                        widget.itemList[index].isFeatureProduct!?Text(AppStrings.featured,style: TextStyle(
                            color: Colors.green
                        ),):Container(),
                      ],
                    ),
                    Container(
                      height: 25,
                      child: productExistInCart(widget.itemList[index].productId)?
                      Container(
                        decoration: BoxDecoration(
                          color: ColorConstants.colorPrimary,
                          borderRadius: BorderRadius.all(
                              Radius.circular(8)),
                          border: Border.all(
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              child: Text('-',style: TextStyle(color: Colors.white),),
                              onTap: () => changeQuantity('remove',widget.itemList[index]),
                            ),
                            Text('${
                               getPackCount(widget.itemList[index].productId)
                            }',style: TextStyle(color: Colors.white)),
                            InkWell(
                              child: Text('+',style: TextStyle(color: Colors.white),),
                              onTap: () => changeQuantity('add',widget.itemList[index]),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(5),
                      ):
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstants.colorPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(
                                  8), // <-- Radius
                            ),
                          ),
                          onPressed:()=> onAddPressed(index),
                          child: Text(AppStrings.add,style: TextStyle(fontSize: 12),)
                      ),
                    )
                  ],
                ))
              ],
            ),
          ),

                widget.itemList[index].schemeCount!>0? Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.all(Radius.circular(0)),
                    border: Border.all(
                        color: ColorConstants.color_FFE5E5E5,
                        width: 1),
                  ),
                  padding: EdgeInsets.all(8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/ic_primary_schemes.png'),
                      Text('  ${widget.itemList[index].schemeCount!} ${AppStrings.schemesAvailable}',style: TextStyle(color: ColorConstants.colorPrimary,fontSize: 12,fontWeight: FontWeight.w400),)
                    ],
                  ),
                ) :Container(),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.only(bottomLeft:Radius.circular(4),bottomRight: Radius.circular(4)),
                    border: Border.all(
                        color: ColorConstants.color_FFE5E5E5,
                        width: 1),
                  ),
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Text('${getCount(widget.itemList[index].productId!)}',style: TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.w700),),
                      Text('  ${AppStrings.itemsHaveBeenAddedToCart}',style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w300),)
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  String getPackName(String? packs) {
    String selected = '';
      if(packs!=null){
        List<Pack> packList = getPacks(packs);
        for(Pack pack in packList){
          if(pack.isSelected!){
            selected = pack.name!;
            break;
          }
        }
      }
      return selected;
    }

  List<Pack> getPacks(String packs) {
    List<Pack> packList = [];
    List<dynamic> parsedListJson = jsonDecode(packs);
    packList = List<Pack>.from(parsedListJson.map<Pack>((dynamic i) => Pack.fromJson(i)));
    return packList;
  }

  void onPackChanged(int value,int index){
    List<Pack> packs = getPacks(widget.itemList[index].packs!);
    for(Pack pack in packs){
      pack.isSelected = pack.id==value;
    }

    setState(() {
      widget.itemList[index].packs = jsonEncode(packs.map((e) => e.toJson()).toList());
    });


  }

  onAddPressed(int index) async {
    Pack selectedPack = AppUtils.getSelectedPack(widget.itemList[index].packs);

    List<ProductDataDistributorTypeDataDetail> types = await AppUtils.getDistributorTypes(widget.itemList[index].productId!,instance);

    List<int> typeIds = [];
    List<String> typeNames = [];

    for(ProductDataDistributorTypeDataDetail type in types){
      typeIds.add(type.distributorTypeId!);
      typeNames.add(type.distributorTypeName!);
    }

    widget.addToCart(
      widget.itemList[index],
      selectedPack.name,
      widget.itemList[index].isQps,
      1,
      0,
      typeIds,
      typeNames
    );
  }


  productExistInCart(int? id) {
    var item = getIteminCart(id);
    return item!=null ;
  }

  CartItemDataDetail? getIteminCart(int? id) {
    return widget.cartItems.where((element) => element.productId==id).isNotEmpty?widget.cartItems.where((element) => element.productId==id).first:null;
  }

  getPackCount(int? id) {
    var item = getIteminCart(id);
    return item!=null?item.packCount:0;
  }

  getCount(int id) {
    var item = getIteminCart(id);
    return item!=null?item.count:0;
  }

  changeQuantity(String option, ProductDataDetail product) {
    var item = getIteminCart(product.productId);
    if(item!=null){

      var packCount = item.packCount!;

      if(option=='add'){
        ++packCount;
      }
      if(option=='remove'){
        --packCount;
      }
      widget.updateCartItem(
        item,
        product,
        packCount
      );
    }
  }

}
