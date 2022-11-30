import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../db/database_helper.dart';
import '../db/product_data_detail/product_data_detail.dart';
import '../db/product_distributor_type_data_detail/product_distributor_type_data_detail.dart';
import '../db/schemes_data_detail/schemes_data_detail.dart';
import '../models/product/pack.dart';
import '../resource_helper/color_constants.dart';
import '../resource_helper/strings.dart';
import '../utils/app_utils.dart';

class AddToVisibility extends StatefulWidget{
  final List<SchemesDataDetail> visibilityList;
  final int selectedUser;
  final List<ProductDataDetail> items;
  final SharedPreferences prefs;
  final Function addSchemeToCart;

  const AddToVisibility({Key? key, required this.visibilityList, required this.selectedUser, required this.items, required this.prefs, required this.addSchemeToCart}) : super(key: key);

  @override
  State<AddToVisibility> createState()=> _AddToVisibility();
}

class _AddToVisibility extends State<AddToVisibility>{

  late DatabaseHelper instance;
  List<ProductDataDetail> items = [];
  List<SchemesDataDetail> schemes = [];

  late int discountId;

  @override
  void initState() {
    instance = DatabaseHelper.instance;
    setProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child:
    Container(
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
          Text(AppStrings.offerDetails,style: TextStyle(color: ColorConstants.colorPrimary,fontSize: 12,fontWeight: FontWeight.w500),),
          SizedBox(height: 5,),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: const BorderRadius.all(
                  Radius.circular(4)),
            ),
            padding: const EdgeInsets.all(5),
            child:Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text('${AppStrings.purchaseValue}: ',style: TextStyle(fontSize: 12,color: Colors.black54),)
                    ),
                    Text('${AppUtils.getCurrency(widget.prefs)} ${schemes[0].minPurchaseValue}',style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w600),)
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Expanded(
                        child: Text('${AppStrings.visibilityTenure}: ',style: TextStyle(fontSize: 12,color: Colors.black54),)
                    ),
                    Text('${schemes[0].tenure} ${AppStrings.days}',style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w600),)
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Expanded(
                        child: Text('${AppStrings.offerValue}: ',style: TextStyle(fontSize: 12,color: Colors.black54),)
                    ),
                    Text('${AppUtils.getCurrency(widget.prefs)} ${schemes[0].discountValue}',style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w600),)
                  ],
                ),
              ],
            ),
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
                          Text('${AppUtils.getCurrency(widget.prefs)} ${getDiscount().toStringAsFixed(2)}',style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w400))
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
      ),
    ) ,);
  }

  void setProducts() async {
    List<SchemesDataDetail> schemeRows = widget.visibilityList;
    var disc = 0;
    List<ProductDataDetail> itemList = [];
    for(SchemesDataDetail detail in schemeRows){
      disc = detail.discountId!;
      var prd = await AppUtils.getProductWithCountAndPrices(detail,widget.items);
      if(prd!=null){
        itemList.add(prd);
      }
    }
    setState(() {
      schemes = widget.visibilityList;
      items = itemList;
      discountId = disc;
    });
  }

  getNonFreeItems() {
    List<Widget> nonFreeWidgets = [];
    for(ProductDataDetail prd in items){
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

  String getSelectedPackText(String? packs) {
    Pack? pck = AppUtils.getSelectedPack(packs);
    return pck.name!;
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

    List<ProductDataDetail> list = items;
    for(var item in list) {
      if(prd.productId==item.productId){
        item.packCount = prd.packCount;
        item.count = prd.count;
      }
    }

    setState(() {
      items = list;
    });

  }

  String getPriceForNonFreeItems() {
    double price = 0.0;
    for(var item in items){
      price+=(double.parse(item.ptr!)* item.count!);
    }
    return price.toStringAsFixed(2);
  }

  getDiscount() {
    return 0.0;
  }

  String getTotalCart() {
    var price = double.parse(getPriceForNonFreeItems());
    var discount = getDiscount();
    var total = price - discount;
    return total.toStringAsFixed(2);
  }

  void addSchemeToCart() async{
    if(await AppUtils.checkAllItemsHaveDistTypes(items,widget.selectedUser,instance)){
      if(await AppUtils.hasCommonDistType(items,widget.selectedUser,instance)){
        if(double.parse(getTotalCart())<schemes[0].minPurchaseValue!){
          AppUtils.showDialog(context, getLessAmountDialog());
        }else{
          callAddSchemeInBookOrder(true);
        }
      }else{
        AppUtils.showMessage(AppStrings.noCommonDistributorTypes);
      }
    }else{
      AppUtils.showMessage(AppStrings.noDistributorTypes);
    }
  }

  void callAddSchemeInBookOrder(bool val) async{
    List<int> distributorTypeIds = [];
    List<String> distributorTypes = [];

    var distType = await AppUtils.getDistributorTypes(schemes[0].productId!,widget.selectedUser,instance);
    for(var item in items){
      List<ProductDataDistributorTypeDataDetail> pDTypes = await AppUtils.getDistributorTypes(item.productId!,widget.selectedUser, instance);
      distType = AppUtils.getCommonTypes(distType, pDTypes);
    }

    for(var type in distType){
      distributorTypeIds.add(type.distributorTypeId!);
      distributorTypes.add(type.distributorTypeName!);
    }

    List<ProductDataDetail> freeItem = [];

    widget.addSchemeToCart(items,freeItem,val?discountId:0,distributorTypeIds,distributorTypes);
    Navigator.pop(context);
  }

  Widget getLessAmountDialog() {
    return AlertDialog(
      title: Text(AppStrings.appName,style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w700),),
      content: Text(AppStrings.visibilityAmountLess,style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w400)),
      actions: [
        OutlinedButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text(AppStrings.no),
        ),
        ElevatedButton(onPressed: (){
          callAddSchemeInBookOrder(false);
          Navigator.pop(context);
        }, child: Text(AppStrings.yes))
      ],
    );
  }

}

