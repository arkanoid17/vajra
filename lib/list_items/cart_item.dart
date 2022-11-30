import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vajra/db/cart_item_data_detail/cart_item_data_detail.dart';
import 'package:vajra/db/database_helper.dart';
import 'package:vajra/db/product_data_detail/product_data_detail.dart';
import 'package:vajra/db/schemes_data_detail/schemes_data_detail.dart';
import 'package:vajra/dialogs/cart_distributor_dialog.dart';
import 'package:vajra/models/order_dtls/order_dtls.dart';
import 'package:vajra/models/user_hierarchy/user_hierarchy_salesman_distributors.dart';
import 'package:vajra/resource_helper/strings.dart';
import 'package:vajra/utils/app_utils.dart';

import '../models/product/pack.dart';
import '../resource_helper/color_constants.dart';

class CartItem extends StatefulWidget{

  final OrderDtls detail;
  final List<ProductDataDetail> items;
  final SharedPreferences prefs;
  final int selectedUser;
  final List<UserHierarchySalesmanDistributor> availableDistributors;
  final int orderNum;

  const CartItem(
      {Key? key,
        required this.detail,
        required this.items,
        required this.prefs,
        required this.selectedUser,
        required this.availableDistributors,
        required this.orderNum})
      : super(key: key);

  @override
  State<CartItem> createState() => _CartItem();

}


class _CartItem extends State<CartItem>{

  bool showOrderValue = true;
  bool showRemark = true;
  bool showFreeItems = true;
  bool showOffers = true;

  var distName = '';
  var selectedDistId = 0;

  List<CartItemDataDetail> nonFreeItems = [];
  List<CartItemDataDetail> freeItems = [];

  late DatabaseHelper instance;


  Map<int,List<SchemesDataDetail>> schemeIds = Map();


  @override
  void initState() {

    setState(() {
      instance = DatabaseHelper.instance;
    });


    getAvailedSchemes();
    getSelectedDistributorName(widget.detail.distributorId);
    setState(() {
      selectedDistId = widget.detail.distributorId!;
      distName = widget.detail.distributorName!;
      nonFreeItems = widget.detail.items.where((element) => !element.isFree!).toList();
      freeItems = widget.detail.items.where((element) => element.isFree!).toList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10,right: 10,top:10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          border: Border.all(
            color: Colors.grey.shade200,
            width: 1,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //items
          Container(
            decoration: BoxDecoration(
                color: ColorConstants.color_ECE6F6_FF),
            padding: EdgeInsets.only(left: 8, right: 8),
            child: Row(
              children: [
                SvgPicture.asset(
                    'assets/images/ic_brief_case_primary.svg'),
                SizedBox(width: 5),
                Text(
                  '${AppStrings.order} ${widget.orderNum}',
                  style: TextStyle(
                      color: ColorConstants.colorPrimary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 5),
                Expanded(
                    child: Text(
                      '${AppStrings.orderId}: ${widget.detail.transactionId}',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis),
                    )),
                SizedBox(width: 5),
                const Card(
                  shape: CircleBorder(),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Text('${AppStrings.itemsSelected}: ${nonFreeItems.length}',style: TextStyle(color: Colors.grey,fontSize: 12,),),
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: nonFreeItems.length,
              itemBuilder: (BuildContext ctx,int index){
                return Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(left: 5,right: 5,bottom: 5),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(4)
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(nonFreeItems[index].productName!,style: TextStyle(fontSize: 14,color: Colors.black,overflow: TextOverflow.ellipsis),),
                          SizedBox(width: 5),
                          const Card(
                            shape: CircleBorder(),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Icon(
                                Icons.delete_outline,
                                color: ColorConstants.colorPrimary,
                                size: 14,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: Colors.grey.shade400,
                                width: 1,
                              )
                            ),
                            child: Wrap(
                              direction: Axis.horizontal,
                              children: [
                                Text(
                                  getPackName(nonFreeItems[index].packId,nonFreeItems[index].productId),
                                  style: TextStyle( color: Colors.grey.shade400, fontSize: 10),
                                ),
                                SizedBox(width: 15,),
                                Icon(Icons.expand_more,size: 14,color: Colors.grey.shade400)
                              ],
                            ),
                          ),
                          Container(
                            width:100,
                            decoration: BoxDecoration(
                              color: ColorConstants.color_7E5BC0_FF,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(8)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: Text('-',style: TextStyle(color: Colors.white),),
                                  onTap: () {},
                                ),
                                Text('${
                                    nonFreeItems[index].packCount
                                }',style: TextStyle(color: Colors.white)),
                                InkWell(
                                  child: Text('+',style: TextStyle(color: Colors.white),),
                                  onTap: () {},
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(5),
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Expanded(child: Wrap(
                            direction: Axis.vertical,
                            children: [
                              Text(AppStrings.quantity,style: TextStyle(color: Colors.black,fontSize: 10),),
                              Text('${nonFreeItems[index].count}',style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w700),)
                            ],
                          )),
                          Expanded(child: Wrap(
                            direction: Axis.vertical,
                            children: [
                              Text(AppStrings.price,style: TextStyle(color: Colors.black,fontSize: 10),),
                              Text('${AppUtils.getCurrency(widget.prefs)} ${getPrice(1,nonFreeItems[index].productId).toStringAsFixed(2)}',style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w700),)
                            ],
                          )),
                          Expanded(child:Wrap(
                            direction: Axis.vertical,
                            children: [
                              Text(AppStrings.price,style: TextStyle(color: Colors.black,fontSize: 10),),
                              Text('${AppUtils.getCurrency(widget.prefs)} ${getPrice(nonFreeItems[index].count,nonFreeItems[index].productId).toStringAsFixed(2)}',style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w700),)
                            ],
                          ))
                        ],
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),
                );
              }
          ),
          //items

          //free items
          Container(
            padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                border: Border.all(
                  color: Colors.grey.shade200,
                  width: 1,
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  direction: Axis.horizontal,
                  children: [
                    SvgPicture.asset('assets/images/ic_brief_case_black.svg',height: 24,width: 24,),
                    SizedBox(width: 5,),
                    Text(AppStrings.freeItem,style: TextStyle(fontSize: 12,color: Colors.black54,fontWeight: FontWeight.w500),)
                  ],
                ),
                InkWell(
                  child: Icon(showFreeItems?Icons.expand_less:Icons.expand_more,color: Colors.black54,),
                  onTap: (){
                    setState(() {
                      showFreeItems = !showFreeItems;
                    });
                  },
                )
              ],
            ),
          ),
          SizedBox(height: 5,),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return SizeTransition(sizeFactor: animation, child: child);
            },
            child: showFreeItems ? ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: freeItems.length,
                itemBuilder: (BuildContext ctx,int index){
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.only(left: 5,right: 5,bottom: 5),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(4)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(freeItems[index].productName!,style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(AppStrings.quantity,style: TextStyle(fontSize: 12,color: Colors.grey),),
                            Text('${freeItems[index].count}',style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w500),),
                            ElevatedButton(
                                onPressed: (){
                                  showQpsScheme(freeItems[index].schemeId);
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          20), // <-- Radius
                                    )
                                ),
                                child: Text(AppStrings.viewScheme,style: TextStyle(color: ColorConstants.colorPrimary,fontSize: 14),)
                            )
                          ],
                        )
                      ],
                    ),
                  );
                }
            ) : null,
          ),
          //free items

          //offers
          schemeIds.isNotEmpty?Container(
            padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                border: Border.all(
                  color: Colors.grey.shade200,
                  width: 1,
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  direction: Axis.horizontal,
                  children: [
                    Container(
                      padding:EdgeInsets.all(6),
                      child: SvgPicture.asset('assets/images/ic_schemes_black.svg',),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        color: Colors.grey.shade200
                      ),
                    ),
                    SizedBox(width: 5,),
                    Text(AppStrings.offers,style: TextStyle(fontSize: 12,color: Colors.black54,fontWeight: FontWeight.w500),)
                  ],
                ),
                InkWell(
                  child: Icon(showOffers?Icons.expand_less:Icons.expand_more,color: Colors.black54,),
                  onTap: (){
                    setState(() {
                      showOffers = !showOffers;
                    });
                  },
                )
              ],
            ),
          ):Container(),
          schemeIds.isNotEmpty?SizedBox(height: 5,):Container(),
          schemeIds.isNotEmpty?AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return SizeTransition(sizeFactor: animation, child: child);
            },
            child: showOffers ? ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: schemeIds.length,
                itemBuilder: (BuildContext ctx,int index){
                  return Container(
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
                                schemeIds[schemeIds.keys.toList()[index]]![0].discountName!,
                                style: TextStyle(color: ColorConstants.colorPrimary,fontSize: 14,fontWeight: FontWeight.w600,overflow: TextOverflow.clip),
                              ),),
                              SizedBox(width: 10,),

                            ],
                          ),
                        ),
                        schemeIds[schemeIds.keys.toList()[index]]![0].schemeTypeId==AppUtils.schemes['visibility']?AppUtils.getVisibilityView(schemeIds[schemeIds.keys.toList()[index]]!,widget.prefs):AppUtils.getDiscountView(schemeIds[schemeIds.keys.toList()[index]]!,widget.prefs)
                      ],
                    ),
                  );
                }
            ) : null,
          ):Container(),
          //offers

          //orderValue
          Container(
            padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                border: Border.all(
                  color: Colors.grey.shade200,
                  width: 1,
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  direction: Axis.horizontal,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius:  BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Icon(Icons.shopping_cart_outlined,size: 14,),
                    ),
                    SizedBox(width: 5,),
                    Text(AppStrings.orderValue,style: TextStyle(fontSize: 12,color: Colors.black54,fontWeight: FontWeight.w500),)
                  ],
                ),
                InkWell(
                  child: Icon(showOrderValue?Icons.expand_less:Icons.expand_more,color: Colors.black54,),
                  onTap: (){
                    setState(() {
                      showOrderValue = !showOrderValue;
                    });
                  },
                )
              ],
            ),
          ),
          SizedBox(height: 5,),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return SizeTransition(sizeFactor: animation, child: child);
            },
            child: showOrderValue ? Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(4)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${AppStrings.totalItems}: ${nonFreeItems.length}',style: TextStyle(fontSize: 12,color: Colors.grey),),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${AppStrings.price}: ',style: TextStyle(fontSize: 12,color: Colors.grey),),
                      Text('${AppUtils.getCurrency(widget.prefs)} ${getTotalPrice(nonFreeItems).toStringAsFixed(2)}',style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w700),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${AppStrings.discount}: ',style: TextStyle(fontSize: 12,color: Colors.grey),),
                      Text('${AppUtils.getCurrency(widget.prefs)} ${getTotalDiscount(nonFreeItems).toStringAsFixed(2)}',style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w700),)
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${AppStrings.discount}: ',style: TextStyle(fontSize: 12,color: Colors.grey),),
                      Text('${AppUtils.getCurrency(widget.prefs)} ${(getTotalDiscount(nonFreeItems)+getTotalPrice(nonFreeItems)).toStringAsFixed(2)}',style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w700),)
                    ],
                  ),
                ],
              ),
            ) : null,
          ),
          SizedBox(height: 5,),
          //orderValue

          //remark
          Container(
            padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                border: Border.all(
                  color: Colors.grey.shade200,
                  width: 1,
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(AppStrings.remarks,style: TextStyle(fontSize: 12,color: Colors.black54,fontWeight: FontWeight.w500),),
                InkWell(
                  child: Icon(showRemark?Icons.expand_less:Icons.expand_more,color: Colors.black54,),
                  onTap: (){
                    setState(() {
                      showRemark = !showRemark;
                    });
                  },
                )
              ],
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return SizeTransition(sizeFactor: animation, child: child);
            },
            child: showRemark ? Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(4)
              ),
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(5),
              child: const TextField(
                style: TextStyle(fontSize: 12),
                decoration: InputDecoration(
                  hintText: 'Please entaer a remark',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(2.0),//add content padding
                  isDense: true,//add
                ),
              ),
            ) : null,
          ),
          //remark

          //distributor
          InkWell(
            child: Container(
              padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
              decoration: BoxDecoration(
                  color: distName.isNotEmpty?Colors.white:Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    width: 1,
                    color: Colors.grey.shade200,
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    direction: Axis.horizontal,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: distName.isNotEmpty?ColorConstants.color_ECE6F6_FF:Colors.white,
                          borderRadius:  BorderRadius.all(Radius.circular(12)),
                        ),
                        child: distName.isNotEmpty?SvgPicture.asset('assets/images/ic_distributor_primary.svg'):SvgPicture.asset('assets/images/ic_distributor_black.svg'),
                      ),
                      SizedBox(width: 5,),
                      Wrap(
                        direction: Axis.horizontal,
                        children: [
                          Text('${AppStrings.distributor}: ',style: TextStyle(fontSize: 12,color: Colors.black54,fontWeight: FontWeight.w500),),
                          distName.isNotEmpty?Text('${distName}',style: TextStyle(fontSize: 12,color: ColorConstants.colorPrimary,fontWeight: FontWeight.w700,overflow: TextOverflow.ellipsis),):Container()
                        ],
                      )
                    ],
                  ),
                  Icon(Icons.navigate_next,color: Colors.black54,),
                ],
              ),
            ),
            onTap: (){
              showDistributorSelectionDialog();
            },
          ),
          //distributor
        ],
      ),
    );

  }

  String getPackName(int? packId, int? productId) {

    String name = '';

    var product = widget.items.where((element) => element.productId==productId).first;
    if(product!=null){
      List<dynamic> parsedListJson = jsonDecode(product.packs!);
      List<Pack> productPacks = List<Pack>.from(parsedListJson.map<Pack>((dynamic i) => Pack.fromJson(i)));
      var pack = productPacks.where((element) => element.id==packId).first;
      if(pack!=null && pack.name!=null){
        name = pack.name!;
      }
    }
    return name;
  }

  double getPrice(int? count, int? productId) {
    double amount = 0.0;
    var product = widget.items.where((element) => element.productId==productId).first;
    if(product!=null && product.ptr!=null){
      amount = count!*double.parse(product.ptr!);
    }
    return amount;
  }

  double getTotalPrice(List<CartItemDataDetail> items) {
    double amount = 0.0;
    for(var item in items){
      if(!item.isFree!){
        amount+=getPrice(item.count, item.productId);
      }
    }
    return amount;
  }

  double getTotalDiscount(List<CartItemDataDetail> items) {
    return 0.0;
  }

  void getSelectedDistributorName(int? distributorId) async{
    print(distributorId);
    var name = '';
    var dist = await AppUtils.getDistributor(distributorId!, DatabaseHelper.instance);
    if(dist!=null && dist.name!=null && dist.name!.isNotEmpty){
      name = dist.name!;
    }
    setState(() {
      distName = name;
    });
  }

  void showDistributorSelectionDialog(){
    print(widget.detail.availableDistTypes!.length);
    AppUtils.showBottomDialog(
        context,
        true,
        false,
        Colors.white,
        CartDistributorDialog(
            detail: widget.detail,
            selectedUser: widget.selectedUser,
            prefs: widget.prefs,
            availableDistributors: widget.availableDistributors,
            onDistributorSelected: onDistributorSelected,
            selectedDistId: selectedDistId
        )
    );
  }

  void onDistributorSelected(UserHierarchySalesmanDistributor selected){
    setState(() {
      distName = selected.name!;
      selectedDistId = selected.id!;
      widget.detail.distributorId = selected.id;
      widget.detail.distributorName = selected.name;
    });
  }

  void showQpsScheme(int? schemeId) async{
    List<SchemesDataDetail> schemes = await getSchemeFromId(schemeId!);
    AppUtils.showBottomDialog(
        context,
        true,
        false,
        Colors.white,
        SingleChildScrollView(
          child:Container(
            padding: EdgeInsets.all(10),
            child:  Column(
              children: [
                SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/ic_primary_schemes.png'),
                    SizedBox(width: 10,),
                    Text('1 ${AppStrings.schemesAvailable}',style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w700),),
                  ],
                ),
                SizedBox(height: 10,),
                Card(
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
                              schemes[0].discountName!,
                              style: TextStyle(color: ColorConstants.colorPrimary,fontSize: 14,fontWeight: FontWeight.w600,overflow: TextOverflow.clip),
                            ),),
                            SizedBox(width: 10,),
                            Chip(
                              label: Text(AppStrings.qps.toUpperCase(),style: TextStyle(fontSize: 12,color: ColorConstants.colorPrimary),),
                              backgroundColor: Colors.white,
                            )
                          ],
                        ),
                      ),
                      AppUtils.getQpsView(schemes)
                    ],
                  ),
                ),
                SizedBox(height: 10,),
              ],
            ),
          ),
        )
    );
  }

  Future<List<SchemesDataDetail>> getSchemeFromId(int schemeId)async{
    var schemeRaw = await instance.execQuery('SELECT * FROM ${instance.schemesDataDetail} WHERE ${SchemeDataDetailFields.discountId} = $schemeId AND ${SchemeDataDetailFields.salesmanId} = ${widget.selectedUser}');

    List<SchemesDataDetail> schemes = [];
    for(var scheme in schemeRaw){
      SchemesDataDetail detail = SchemesDataDetail(
          scheme['discountId'],
          scheme['productId'],
          scheme['discountName'],
          scheme['productName'],
          scheme['minQty'],
          scheme['tenure'],
          scheme['minPurchaseValue'],
          scheme['discountValue'],
          scheme['discountUom'],
          scheme['startDate'],
          scheme['endDate'],
          scheme['isQps']==1,
          scheme['description'],
          scheme['schemeTypeId'],
          scheme['schemeType'],
          scheme['salesmanId']
      );

      schemes.add(detail);
    }

    return schemes;
  }

  void getAvailedSchemes() async{
    Map<int,List<SchemesDataDetail>> schemes = Map();
    for(var item in widget.detail.items){
      if(item.schemeId!=null && item.schemeId!=0){
        List<SchemesDataDetail> scheme = await getSchemeFromId(item.schemeId!);
        if(scheme!=null && scheme.isNotEmpty){
          if(scheme[0].schemeTypeId!=AppUtils.schemes['qps']){
            schemes.putIfAbsent(scheme[0].discountId!, () => scheme);
          }
        }
      }
    }
    setState(() {
      schemeIds = schemes;
    });
  }

}