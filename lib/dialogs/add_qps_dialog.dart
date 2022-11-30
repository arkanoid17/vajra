import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vajra/db/database_helper.dart';
import 'package:vajra/db/product_data_detail/product_data_detail.dart';
import 'package:vajra/db/product_distributor_type_data_detail/product_distributor_type_data_detail.dart';
import 'package:vajra/resource_helper/color_constants.dart';
import 'package:vajra/resource_helper/strings.dart';
import 'package:vajra/utils/app_utils.dart';

import '../db/schemes_data_detail/schemes_data_detail.dart';
import '../models/product/pack.dart';

class AddToQps extends StatefulWidget{
  final List<SchemesDataDetail> qpsList;
  final int selectedUser;
  final List<ProductDataDetail> items;
  final SharedPreferences prefs;
  final Function addSchemeToCart;

  const AddToQps({Key? key, required this.qpsList, required this.selectedUser, required this.items, required this.prefs, required this.addSchemeToCart}) : super(key: key);

  @override
  State<AddToQps> createState()=> _AddToQps();
}

class _AddToQps extends State<AddToQps>{

  late DatabaseHelper instance;

  List<ProductDataDetail> nonFree = [];
  List<ProductDataDetail> free = [];

  List<SchemesDataDetail> nonFreeRow = [];
  List<SchemesDataDetail> freeRow = [];

  late int discountId;


  @override
  void initState() {
    instance = DatabaseHelper.instance;
    setProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                AppStrings.addItemsToAvailSchemes,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600
                ),
              ),
              const SizedBox(height: 15),
              Column(
                children: getNonFreeItems(),
              ),
              SizedBox(height: 15,),
              Text(AppStrings.freeItem,style: TextStyle(color: ColorConstants.colorPrimary,fontSize: 12,fontWeight: FontWeight.w500),),
              Column(
                children: getFreeItems(),
              ),
              SizedBox(height: 15,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(4)),
                  border: Border.all(
                    color: Colors.grey.shade200,
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(4)),
                          border: Border.all(
                            color: Colors.grey.shade200,
                            width: 1,
                          )
                      ),
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(20)),
                                color: ColorConstants.color_ECE6F6_FF
                            ),
                            child: Icon(Icons.shopping_cart_outlined,color: ColorConstants.colorPrimary,size: 14,),
                          ),
                          SizedBox(width: 10,),
                          Text(AppStrings.cartValue,style: TextStyle(fontSize: 12,color: ColorConstants.colorPrimary,fontWeight: FontWeight.w500))
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(child:
                              Text('${AppStrings.price}: ',style: TextStyle(color: Colors.grey,fontSize: 12),)
                              ),
                              Text('${AppUtils.getCurrency(widget.prefs)} ${getPriceForNonFreeItems()}',style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w400))
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Expanded(child:
                              Text('${AppStrings.discount}: ',style: TextStyle(color: Colors.grey,fontSize: 12),)
                              ),
                              Text('${AppUtils.getCurrency(widget.prefs)} ${getDiscount()}',style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w400))
                            ],
                          ),
                        ],
                      ),),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Expanded(child:
                          Text('${AppStrings.total}: ',style: TextStyle(color: Colors.grey,fontSize: 12),)
                          ),
                          Text('${AppUtils.getCurrency(widget.prefs)} ${getTotalCart()}',style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w500))
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 15,),
              Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.color_7E5BC0_FF,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(
                              20), // <-- Radius
                        ),
                      ),
                    onPressed: (){
                      addSchemeToCart();
                    },
                    child: Wrap(
                      children: [
                        SizedBox(width: 20),
                        Text(AppStrings.addToCart,style: TextStyle(color: Colors.white,fontSize: 15),),
                        SizedBox(width: 10),
                        Icon(Icons.shopping_cart_outlined,size: 18,),
                        SizedBox(width: 20),
                      ],
                    ),
                  )
              ),
              SizedBox(height: 15,),
            ],
          )


      ),
    );
  }

  getNonFreeItems() {
    List<Widget> nonFreeWidgets = [];
    for(ProductDataDetail prd in nonFree){

      nonFreeWidgets.add(
          Container(
            margin: EdgeInsets.only(bottom: 5),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: const BorderRadius.all(
                  Radius.circular(4)),
            ),
            padding: const EdgeInsets.only(left: 5,right: 5,top: 15,bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(prd.productName!,style: TextStyle(fontSize: 14, color: Colors.black,fontWeight: FontWeight.w500),),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                         border:Border.all(
                           color: Colors.black12,
                           width: 1,
                         ) ,
                          borderRadius: BorderRadius.all(Radius.circular(4))
                      ),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Padding(padding: EdgeInsets.all(4),child: Text(getSelectedPackText(prd.packs)),),
                          const SizedBox(width:10),
                          const Icon(Icons.expand_more)
                        ],
                      )
                    ),
                    Expanded(child: SizedBox()),
                    Container(
                      decoration: const BoxDecoration(
                        color: ColorConstants.color_7E5BC0_FF,
                          borderRadius: BorderRadius.all(Radius.circular(4))
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            child: const Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(' - ',style: TextStyle(color: Colors.white,fontSize: 14),),
                            ),
                            onTap: (){
                                updateProductCount('-',prd);
                            },
                          ),
                          SizedBox(width: 10,),
                          InkWell(
                            child:  Padding(
                              padding: EdgeInsets.all(5),
                              child: Text('${prd.packCount ?? 0}',style: TextStyle(color: Colors.white,fontSize: 14)),
                            ),
                            onTap: (){

                            },
                          ),
                          SizedBox(width: 10,),
                          InkWell(
                            child: const Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(' + ',style: TextStyle(color: Colors.white,fontSize: 14)),
                            ),
                            onTap: (){
                              updateProductCount('+',prd);
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppStrings.quantity,style: TextStyle(fontSize: 12,color: Colors.black54,fontWeight: FontWeight.w400),),
                            Text('${prd.count!}',style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w600),)
                          ],
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppStrings.price,style: TextStyle(fontSize: 12,color: Colors.black54,fontWeight: FontWeight.w400),),
                            Text('${AppUtils.getCurrency(widget.prefs)} ${prd.ptr!}',style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w600),)
                          ],
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppStrings.total,style: TextStyle(fontSize: 12,color: Colors.black54,fontWeight: FontWeight.w400),),
                            Text('${AppUtils.getCurrency(widget.prefs)} ${AppUtils.getTotalAmount(prd)}',style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w600),)
                          ],
                        )
                    ),
                  ],
                )
              ],
            ),
          )
      );
    }
    return nonFreeWidgets;
  }

  void setProducts() async{
    List<SchemesDataDetail> nonFreeRow = widget.qpsList.where((element) => !element.isQps!).toList();
    List<SchemesDataDetail> freeRow = widget.qpsList.where((element) => element.isQps!).toList();
    
    List<ProductDataDetail> nFProducts = [];
    List<ProductDataDetail> FProducts = [];

    var disc = 0;



    for(SchemesDataDetail detail in nonFreeRow){
      print('${detail.isQps} = ${detail.minQty}');
      disc = detail.discountId!;
      ProductDataDetail prd = await AppUtils.getProductWithCountAndPrices(detail,widget.items);
      if(prd!=null){
        nFProducts.add(prd);
      }
    }
    for(SchemesDataDetail detail in freeRow){
      print('${detail.isQps} = ${detail.minQty}');
      var prd1 = await AppUtils.getProductWithCountAndPrices(detail,widget.items);
      if(prd1!=null){
        FProducts.add(prd1);
      }
    }

    for(var prd in nFProducts){
      print(prd.packCount);
    }

    setState(() {
      nonFree = nFProducts;
      free = FProducts;
      discountId = disc;
    });

  }


  String getSelectedPackText(String? packs) {
   Pack? pck = AppUtils.getSelectedPack(packs);
    return pck.name!;
  }



  getFreeItems() {
    List<Widget> nonFreeWidgets = [];
    for(ProductDataDetail prd in free){
      nonFreeWidgets.add(
          Container(
            margin: EdgeInsets.only(bottom: 5),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: const BorderRadius.all(
                  Radius.circular(4)),
            ),
            padding: const EdgeInsets.only(left: 5,right: 5,top: 15,bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(prd.productName!,style: const TextStyle(fontSize: 14, color: Colors.black,fontWeight: FontWeight.w500),),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 7,
                        child: Text(AppStrings.quantity,style: TextStyle(fontSize: 12,color: Colors.black54,fontWeight: FontWeight.w400),),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text('${prd.count}',style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w600),),
                    )
                  ],
                )
              ],
            ),
          )
      );
    }
    return nonFreeWidgets;
  }

  String getPriceForNonFreeItems() {
    double price = 0.0;
    for(var item in nonFree){
      price+=(double.parse(item.ptr!)* item.count!);
    }
    return price.toStringAsFixed(2);
  }

  getDiscount() {
    return '0';
  }

  getTotalCart() {
    var price = double.parse(getPriceForNonFreeItems());
    var discount = double.parse(getDiscount());
    var total = price - discount;
    return total.toStringAsFixed(2);
  }

  void updateProductCount(String option, ProductDataDetail prd) {
    switch(option){
      case '-':
        prd.packCount = prd.packCount!- 1;
        break;
      case '+':
        prd.packCount = prd.packCount!+ 1;
        break;
    }

    if(prd.packCount!<0){
      prd.packCount=0;
    }
    if(prd.packCount!>999){
      AppUtils.showMessage(AppStrings.maxLimitReached);
      prd.packCount=999;
    }

    Pack? pck = AppUtils.getSelectedPack(prd.packs!);

    if(pck!=null){
      prd.count = prd.packCount!*pck .units!;
    }

    List<ProductDataDetail> list = nonFree;
    for(var item in list){
      if(prd.productId==item.productId){
        item.packCount = prd.packCount;
        item.count = prd.count;
      }
    }

    int freeFactor = AppUtils.getFreeFactor(nonFree,(widget.qpsList.where((element) => !element.isQps!).toList()));

    List<ProductDataDetail> freeProducts = free;
    for(var item in freeProducts){
      for(var scheme in (widget.qpsList.where((element) => element.isQps!).toList())){
        if(item.productId==scheme.productId){
          item.count = scheme.minQty!*freeFactor;
          break;
        }
      }
    }


    setState(() {
      nonFree = list;
      free = freeProducts;
    });

  }


  addSchemeToCart() async{
   if(await AppUtils.checkAllItemsHaveDistTypes(nonFree,widget.selectedUser,instance)){
     if(await AppUtils.hasCommonDistType(nonFree,widget.selectedUser,instance)){

      List<int> distributorTypeIds = [];
      List<String> distributorTypes = [];

      var distType = await AppUtils.getDistributorTypes(nonFree[0].productId!,widget.selectedUser,instance);
      for(var item in nonFree){
        List<ProductDataDistributorTypeDataDetail> pDTypes = await AppUtils.getDistributorTypes(item.productId!,widget.selectedUser, instance);
        distType = AppUtils.getCommonTypes(distType, pDTypes);
      }

      for(var type in distType){
        distributorTypeIds.add(type.distributorTypeId!);
        distributorTypes.add(type.distributorTypeName!);
      }
       widget.addSchemeToCart(nonFree,free,discountId,distributorTypeIds,distributorTypes);
        Navigator.pop(context);
     }else{
       AppUtils.showMessage(AppStrings.noCommonDistributorTypes);
     }
   }else{
     AppUtils.showMessage(AppStrings.noDistributorTypes);
   }
  }






}