import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vajra/db/cart_item_data_detail/cart_item_data_detail.dart';
import 'package:vajra/db/cart_item_data_detail/cart_item_distributor_type.dart';
import 'package:vajra/db/database_helper.dart';
import 'package:vajra/db/distributor_data_detail/distributor_data_detail.dart';
import 'package:vajra/db/pricing_data_detail/pricing_data_detail.dart';
import 'package:vajra/db/product_distributor_type_data_detail/product_distributor_type_data_detail.dart';
import 'package:vajra/db/store_price_mapping_data_detail/store_price_mapping_data_detail.dart';
import 'package:vajra/db/stores_data_detail/stores_data_detail.dart';
import 'package:vajra/db/user_hierarchy_data_detail/user_hierarchy_data_detail.dart';
import 'package:vajra/dialogs/generic_string_popup.dart';
import 'package:vajra/models/product/pack.dart';
import 'package:vajra/models/stores_data/store_distributor_relation.dart';
import 'package:vajra/models/user_hierarchy/distributor_types.dart';
import 'package:vajra/resource_helper/color_constants.dart';
import 'package:vajra/resource_helper/strings.dart';
import 'package:vajra/subscreen/cart_list.dart';
import 'package:vajra/subscreen/schemes_list.dart';
import 'package:vajra/utils/app_utils.dart';

import '../db/product_data_detail/product_data_detail.dart';
import '../db/schemes_data_detail/schemes_data_detail.dart';
import '../models/user_hierarchy/user_hierarchy_salesman_distributors.dart';
import '../subscreen/item_list.dart';

class BookOrder extends StatefulWidget {

  final Object? arguments;

  const BookOrder(this.arguments, {Key? key}) : super(key: key);

  @override
  State<BookOrder> createState() => _BookOrder();
}

class _BookOrder extends State<BookOrder> {
  late SharedPreferences prefs;

  late StoresDataDetail store;

  List<ProductDataDetail> productList = [];
  List<ProductDataDetail> filteredList = [];

  int selectedUser = 0;

  late DatabaseHelper instance;

  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  Map<int, List<SchemesDataDetail>> mapQps = Map();
  Map<int, List<SchemesDataDetail>> mapDiscount = Map();
  Map<int, List<SchemesDataDetail>> mapVisibility = Map();

  bool bottomBarVisible = true;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var schemeTypes = [
    AppStrings.all,
    AppStrings.qps,
    AppStrings.discount,
    AppStrings.visibility
  ];
  var selectedSchemeType = AppStrings.all;

  List<int> selectedSchemeKey = [];

  var cartItemCount = 0;

  int step = 1;

  int prevStep = 1;

  String visitId = '';

  List<UserHierarchySalesmanDistributor> availableDistributors = [];

  void getPricings() async {
    List<ProductDataDetail> prdList = [];

    var pricingResults = await instance.execQuery(
        'SELECT ${StorePriceMappingDataDetailFields.pricingList} FROM ${instance.storePriceMappingDataDetail} WHERE ${StorePriceMappingDataDetailFields.storeId} = "${store.storeId}" AND ${StorePriceMappingDataDetailFields.scope} = "Field" AND ${StorePriceMappingDataDetailFields.userId} = $selectedUser AND ${StorePriceMappingDataDetailFields.status} = ${true}');
    var pricingId = -1;
    for (var pricing in pricingResults) {
      pricingId = pricing[StorePriceMappingDataDetailFields.pricingList];
      break;
    }
    var priceListResults = await instance.execQuery(
        'SELECT * FROM ${instance.pricingDataDetail} WHERE ${PricingDataDetailFields.pricing_id} = $pricingId AND ${PricingDataDetailFields.userId} = $selectedUser AND ${PricingDataDetailFields.pricing_status} = ${true} AND ${PricingDataDetailFields.product_status} = ${true}');
    for (var price in priceListResults) {
      ProductDataDetail? prd;
      var prdResult = await instance.execQuery(
          'SELECT * FROM ${instance.productDataDetail} where ${ProductDataFields.productId} = ${price['product']} AND ${ProductDataFields.salesmanId} = $selectedUser');
      for (var prod in prdResult) {
        prd = ProductDataDetail.fromJson(prod);

        //sort pack and set first selected
        List<Pack> packList = [];
        List<dynamic> parsedListJson = jsonDecode(prod['packs']);
        packList = List<Pack>.from(
            parsedListJson.map<Pack>((dynamic i) => Pack.fromJson(i)));
        packList.sort((a, b) => a.units!.compareTo(b.units!));
        if (packList.isNotEmpty) {
          bool isAnyPackSelected = false;
          for (Pack pack in packList) {
            if (pack.isSelected != null && pack.isSelected!) {
              isAnyPackSelected = true;
              break;
            }
          }

          if (!isAnyPackSelected) {
            packList[0].isSelected = true;
          }
        }
        prd.packs = jsonEncode(packList.map((e) => e.toJson()).toList());
        //pack finished

        prd.mrp = price['mrp'];
        prd.nrv = price['nrv'];
        prd.ptr = price['ptr'];
        prd.pts = price['pts'];
        prd.schemeCount = await getSchemeCount(prod['productId']);
        prd.productStatus = price['productStatus'] == 1;
        prdList.add(prd);
        break;
      }
    }

    prdList.sort((a, b) => a.productName!.compareTo(b.productName!));

    var featured =
        prdList.where((element) => element.isFeatureProduct!).toList();
    var notFeatured =
        prdList.where((element) => !element.isFeatureProduct!).toList();

    
    print('featured - ${featured.length}');
    
    prdList = [];
    if (featured != null && featured.isNotEmpty) {
      prdList.addAll(featured);
    }
    if (notFeatured != null && notFeatured.isNotEmpty) {
      prdList.addAll(notFeatured);
    }

    setState(() {
      productList = prdList;
      filteredList = prdList;
      currentWidget = ItemList(
        itemList: filteredList,
        instance: instance,
        addToCart: addToCart,
        store: store,
        cartItems: cartItems,
        updateCartItem: updateCartItem,
        onSchemeFiltered: onSchemeFiltered,
        selectedUser: selectedUser,
      );
    });
  }

  Future<int> getSchemeCount(int productId) async {
    var count = await instance.execQuery(
        'SELECT COUNT(*) AS cnt FROM ${instance.schemesDataDetail} WHERE ${SchemeDataDetailFields.productId} = $productId AND ${SchemeDataDetailFields.isQps} = ${false}');

    if (count.isNotEmpty) {
      for (var cnt in count) {
        return cnt['cnt'];
      }
    }

    return 0;
  }

  Widget? currentWidget = Center(
    child: CircularProgressIndicator(),
  );

  late Widget toolbar;

  List<CartItemDataDetail> cartItems = [];

  @override
  void initState() {
    getPrefs();
    super.initState();
  }


  void getPrefs() async{
    prefs = await AppUtils.getPrefs();
    setState((){
      visitId = '${AppUtils.getUserData(prefs)!.userId}${DateTime.now().millisecond}';
    });
  }

  @override
  Widget build(BuildContext context) {
    if (selectedUser == 0) {

      final arguments = (ModalRoute.of(context)?.settings.arguments ??
          <String, dynamic>{}) as Map;
      setState(() {
        instance = DatabaseHelper.instance;
        store = arguments['store'];
        selectedUser = arguments['selectedUser'];
      });
      getPricings();
      getDistributors();
      setCartItems();
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: getTitleText(),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (step == 1) {
              Navigator.pop(context);
            } else {
              if (step == 2) {
                setState(() {
                  selectedSchemeType = AppStrings.all;
                  selectedSchemeKey = [];
                });
              }
              setState(() {
                step = prevStep;
                prevStep = 1;
              });
              setCurrentWidget();
            }
          },
        ),
        actions: getActions(),
      ),
      body: Column(
        children: [
          Expanded(
              child: currentWidget!),
          Padding(
            padding: EdgeInsets.all(10),
            child: bottomBarVisible
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          if (step != 2) {
                            setState(() {
                              step = 2;
                            });
                            setCurrentWidget();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 7, right: 7, top: 15, bottom: 15),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/ic_schemes_white.png',
                                width: 12,
                                height: 12,
                              ),
                              Text(
                                AppStrings.schemes,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: ColorConstants.color_7E5BC0_FF,
                            borderRadius: BorderRadius.all(Radius.circular(32)),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      InkWell(
                        onTap: () {

                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 18, right: 18, top: 15, bottom: 15),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/ic_tasks_white.png',
                                width: 12,
                                height: 12,
                              ),
                              Text(
                                AppStrings.task,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: ColorConstants.color_7E5BC0_FF,
                            borderRadius: BorderRadius.all(Radius.circular(32)),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 15, bottom: 15),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Image.asset(
                                    'assets/images/ic_cart_white.png',
                                    width: 12,
                                    height: 12,
                                  ),
                                  Text(
                                    AppStrings.cart,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  )
                                ],
                              ),
                              cartItems.isNotEmpty
                                  ? Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${cartItemCount} ${AppStrings.items}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10),
                                      ),
                                      Text(
                                        '${AppStrings.cartValue}: ${getItemPrices()}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.white,
                                  ),
                                ],
                              )
                                  : Container()
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: ColorConstants.color_7E5BC0_FF,
                            borderRadius: BorderRadius.all(Radius.circular(32)),
                          ),
                        ),
                        onTap: (){
                         navigateToCart(1);
                        },
                      )
                    ],
                  )
                : Container(),
          )
        ],
      ),
    );
  }

  void setCurrentWidget() {
    switch (step) {
      case 1:
        setState(() {
          bottomBarVisible = true;
          currentWidget = ItemList(
            itemList: filteredList,
            instance: instance,
            addToCart: addToCart,
            store: store,
            cartItems: cartItems,
            updateCartItem: updateCartItem,
            onSchemeFiltered: onSchemeFiltered,
            selectedUser: selectedUser,
          );
        });
        break;
      case 2:
        setState(() {
          bottomBarVisible = false;
        });
        setSchemes();
        break;
      case 3:
        setState(() {
          bottomBarVisible = false;
          currentWidget = CartItemsList(
            itemList: productList,
            cartItems: cartItems,
            store: store,
            getItemsFromCartId: getItemsFromCartId,
            getServiceableDistributors: getServiceableDistributors,
            visitId: visitId,
            getListOfDistributorsInType: getListOfDistributorsInType,
            prefs: prefs,
            selectedUser: selectedUser,
            availableDistributors: availableDistributors,
          );
        });
        break;

      default:
        currentWidget = ItemList(
          itemList: filteredList,
          instance: instance,
          addToCart: addToCart,
          store: store,
          cartItems: cartItems,
          updateCartItem: updateCartItem,
          onSchemeFiltered: onSchemeFiltered,
          selectedUser: selectedUser,
        );
    }
  }

  getTitleText() {
    switch (step) {
      case 1:
        return isSearching
            ? TextField(
                style: const TextStyle(color: Colors.white, fontSize: 16),
                controller: searchController,
                onChanged: (text) {
                  setState(() {
                    if (searchController.text.isEmpty) {
                      setState(() {
                        filteredList = productList;
                        if (step == 1) {
                          currentWidget = ItemList(
                            itemList: filteredList,
                            instance: instance,
                            addToCart: addToCart,
                            store: store,
                            cartItems: cartItems,
                            updateCartItem: updateCartItem,
                            onSchemeFiltered: onSchemeFiltered,
                            selectedUser: selectedUser,
                          );
                        }
                      });
                    } else {
                      List<ProductDataDetail> prds = productList
                          .where((element) => element.productName!
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase()))
                          .toList();
                      setState(() {
                        filteredList = prds;
                        if (step == 1) {
                          currentWidget = ItemList(
                            itemList: filteredList,
                            instance: instance,
                            addToCart: addToCart,
                            store: store,
                            cartItems: cartItems,
                            updateCartItem: updateCartItem,
                            onSchemeFiltered: onSchemeFiltered,
                            selectedUser: selectedUser,
                          );
                        }
                      });
                    }
                  });
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: AppStrings.search,
                  hintStyle: TextStyle(
                      color: Colors.white.withAlpha(120), fontSize: 16),
                ),
              )
            : Text(store.name != null ? store.name! : '');
      case 2:
        return const Text(AppStrings.schemes);
      case 3:
        return const Text(AppStrings.cart);
    }
  }

  getActions() {
    List<Widget> actions = [];
    switch (step) {
      case 1:
        actions.add(IconButton(
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                searchController.text = '';
                filteredList = productList;
                if (step == 1) {
                  currentWidget = ItemList(
                    itemList: filteredList,
                    instance: instance,
                    addToCart: addToCart,
                    store: store,
                    cartItems: cartItems,
                    updateCartItem: updateCartItem,
                    onSchemeFiltered: onSchemeFiltered,
                    selectedUser: selectedUser,
                  );
                }
              });
            },
            icon: isSearching
                ? const Icon(Icons.cancel)
                : const Icon((Icons.search))));
        break;
      case 2:
        actions.add(Badge(
          position: BadgePosition(top: 5, start: 25),
          elevation: 4,
          toAnimate: true,
          alignment: Alignment.center,
          badgeColor: ColorConstants.billedColor,
          badgeContent: Text(
            '${cartItemCount}',
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
          child: IconButton(
              onPressed: () {
                navigateToCart(2);
              }, icon: const Icon(Icons.shopping_cart_outlined)),
        ));
        actions.add(GenericStringPopup(
            options: schemeTypes,
            selectedOption: selectedSchemeType,
            onPopupChanged: onPopupChanged,
            child: const Icon(Icons.filter_alt_outlined)));

        break;
    }
    return actions;
  }

  updateCartItem(
      CartItemDataDetail item, ProductDataDetail product, int packCount) {
    if (packCount > 999) {
      packCount = 999;
      AppUtils.showMessage(AppStrings.maxLimitReached);
    }

    if (packCount <= 0) {
      packCount = 0;
    }

    if (packCount == 0) {
      instance.execQuery(
          'DELETE FROM ${instance.cartItemDataDetail} WHERE ${CartItemDataDetailFields.id} = ${item.id}');
    } else {
      Pack selectedPack = AppUtils.getSelectedPack(product.packs);
      var count = selectedPack.units! * packCount;

      instance.execQuery(
          'UPDATE ${instance.cartItemDataDetail} SET ${CartItemDataDetailFields.packCount} = $packCount, ${CartItemDataDetailFields.count} = $count WHERE ${CartItemDataDetailFields.id} = ${item.id}');
    }

    setCartItems();
  }

  void addSchemeToCart(
      List<ProductDataDetail> nonFreeItems,
      List<ProductDataDetail> freeItems,
      int schemeId,
      List<int> distributorTypeIds,
      List<String> distributorTypes) async {
    for (var item in nonFreeItems) {
      //check scheme Id for items to remove their free product and change schemeId to 0 for non free items
      //remove the item to remove from cart table
      if (schemeId != 0) {
        List<CartItemDataDetail> itemsToRemove = cartItems
            .where((element) =>
                (element.productId == item.productId && !element.isFree!))
            .toList();
        for (var itm in itemsToRemove) {
          int scheme = itm.schemeId != null ? item.schemeId! : 0;
          if (scheme != 0) {
            var freeItemsToRemoveRaw = await instance.execQuery(
                'SELECT ${CartItemDataDetailFields.id} WHERE ${CartItemDataDetailFields.schemeId} = $schemeId AND ${CartItemDataDetailFields.isFree} = 1');
            if (freeItemsToRemoveRaw.isNotEmpty) {
              for (var freeItm in freeItemsToRemoveRaw) {
                await instance.execQuery(
                    'DELETE FROM ${instance.cartItemDataDetail} WHERE ${CartItemDataDetailFields.id} = ${freeItm[CartItemDataDetailFields.id]}');
              }
            }
            await instance.execQuery(
                'UPDATE ${instance.cartItemDataDetail} SET ${CartItemDataDetailFields.schemeId} = 0, ${CartItemDataDetailFields.updatedAt} = ${AppUtils.getNowDateAndTime()} WHERE ${CartItemDataDetailFields.id} = ${itm.id}');
          }
          await instance.execQuery(
              'DELETE FROM ${instance.cartItemDataDetail} WHERE ${CartItemDataDetailFields.storeId} = "${store.storeId}" AND ${CartItemDataDetailFields.productId} = ${itm.productId} AND ${CartItemDataDetailFields.isFree} = ${itm.isFree}');
        }
      }

      addToCart(item, AppUtils.getSelectedPack(item.packs!).name!, false,
          item.packCount!, schemeId, distributorTypeIds, distributorTypes);
    }
    for (var item in freeItems) {
      addToCart(item, AppUtils.getSelectedPack(item.packs!).name!, true,
          item.packCount!, schemeId, distributorTypeIds, distributorTypes);
    }
  }

  void addToCart(
      ProductDataDetail productDataDetail,
      String selectedPackName,
      bool isFree,
      int packCount,
      int schemeId,
      List<int> distributorTypeIds,
      List<String> distributorTypes) async {


    Pack selectedPack = AppUtils.getSelectedPack(productDataDetail.packs);

    var count = selectedPack.units! * packCount;

    CartItemDataDetail item = CartItemDataDetail(
        store.storeId,
        productDataDetail.productId,
        productDataDetail.productName,
        isFree,
        selectedPack.id,
        selectedPack.units,
        packCount,
        count,
        schemeId,
        AppUtils.getNowDateAndTime(),
        AppUtils.getNowDateAndTime());

    var cartId =
        await instance.insert(instance.cartItemDataDetail, item.toJson());
    for (int i = 0; i < distributorTypeIds.length; i++) {
      CartItemDistributorType type = CartItemDistributorType(
          cartId, distributorTypeIds[i], distributorTypes[i]);
      instance.insert(
          instance.cartItemDistributorTypeDataDetail, type.toJson());
    }
    setCartItems();
  }

  void setCartItems() async {
    var items = await instance.execQuery(
        'SELECT * FROM ${instance.cartItemDataDetail} WHERE ${CartItemDataDetailFields.storeId} = "${store.storeId}"');
    List<CartItemDataDetail> carts = [];
    for (var item in items) {
      CartItemDataDetail itm = CartItemDataDetail(
          item['storeId'],
          item['productId'],
          item['productName'],
          item['isFree'] == 1,
          item['packId'],
          item['packValue'],
          item['packCount'],
          item['_count'],
          item['schemeId'],
          item['createdAt'],
          item['updatedAt']);

      itm.id = item['_id'];
      carts.add(itm);
    }

    setState(() {
      cartItems = carts;
    });

    getCartItemsCount();
    setCurrentWidget();
  }

  void setSchemes() async {
    var additionalQuery = selectedSchemeKey.isNotEmpty
        ? 'AND ${SchemeDataDetailFields.discountId} in (${selectedSchemeKey.join(',')})'
        : '';

    List<SchemesDataDetail> schemeList = [];
    var schemeData = await instance.execQuery(
        'SELECT * FROM ${instance.schemesDataDetail} WHERE ${SchemeDataDetailFields.salesmanId} = $selectedUser $additionalQuery');
    if (schemeData.isNotEmpty) {
      for (var scheme in schemeData) {
        schemeList.add(SchemesDataDetail.fromJson(scheme));
      }
    }

    List<SchemesDataDetail> discounts = [];
    List<SchemesDataDetail> qps = [];
    List<SchemesDataDetail> visibility = [];
    for (SchemesDataDetail scheme in schemeList) {
      if (scheme.schemeTypeId == AppUtils.schemes['flat'] ||
          scheme.schemeTypeId == AppUtils.schemes['percentage']) {
        discounts.add(scheme);
      }
      if (scheme.schemeTypeId == AppUtils.schemes['qps']) {
        qps.add(scheme);
      }
      if (scheme.schemeTypeId == AppUtils.schemes['visibility']) {
        visibility.add(scheme);
      }
    }

    Map<int, List<SchemesDataDetail>> mapD = Map();

    //discounts//
    var discKeys = [];
    for (SchemesDataDetail scheme in discounts) {
      if (!discKeys.contains(scheme.discountId)) {
        discKeys.add(scheme.discountId);
      }
    }

    for (int key in discKeys) {
      mapD[key] =
          discounts.where((element) => element.discountId == key).toList();
    }

    setState(() {
      mapDiscount = mapD;
    });
    //discounts//

    //qps//
    Map<int, List<SchemesDataDetail>> mapQ = Map();
    var qpsKeys = [];
    for (SchemesDataDetail scheme in qps) {
      if (!qpsKeys.contains(scheme.discountId)) {
        qpsKeys.add(scheme.discountId);
      }
    }

    for (int key in qpsKeys) {
      mapQ[key] = qps.where((element) => element.discountId == key).toList();
    }

    setState(() {
      mapQps = mapQ;
    });
    //qps//

    //visibility//
    Map<int, List<SchemesDataDetail>> mapV = Map();
    var visibilityKeys = [];
    for (SchemesDataDetail scheme in visibility) {
      if (!visibilityKeys.contains(scheme.discountId)) {
        visibilityKeys.add(scheme.discountId);
      }
    }

    for (int key in visibilityKeys) {
      mapV[key] =
          visibility.where((element) => element.discountId == key).toList();
    }

    setState(() {
      mapVisibility = mapV;
    });
    //visibility//

    setState(() {
      prevStep = 1;
      currentWidget = SchemeList(
        itemList: productList,
        instance: instance,
        mapQps: mapQps,
        mapDiscount: mapDiscount,
        mapVisibility: mapVisibility,
        prefs: prefs,
        type: selectedSchemeType,
        filterKey: selectedSchemeKey,
        selectedUser: selectedUser,
        addSchemeToCart: addSchemeToCart,
        navigateToCart: navigateToCart,
        cartItems: cartItems
      );
    });
  }

  void onPopupChanged(String value) {
    setState(() {
      selectedSchemeType = value;
    });
    setCurrentWidget();
  }

  void onSchemeFiltered(List<int> value) {
    setState(() {
      selectedSchemeKey = value;
      ++step;
    });
    setCurrentWidget();
  }

  void getCartItemsCount() {
    // instance.execQuery('DELETE FROM ${instance.cartItemDataDetail} WHERE ${CartItemDataDetailFields.storeId} = ${store.storeId}');
    int count = 0;
    for (var item in cartItems) {
      if (!item.isFree!) {
        count += item.count!;
      }
    }
    setState(() {
      cartItemCount = count;
    });
  }

  getItemPrices() {
    double price = 0;
    if(cartItems.isNotEmpty && productList.isNotEmpty){
      for (var item in cartItems) {
        if (!item.isFree!) {
          var prd = productList
              .where((element) => element.productId == item.productId)
              .first;

          price += double.parse(prd.ptr!)*item.count!;
        }
      }
    }
    return '${AppUtils.getCurrency(prefs)} ${price.toStringAsFixed(2)}';
  }

  void navigateToCart(int previous) {
    if(cartItemCount>0){
      setState(() {
        prevStep = previous;
        step = 3;
      });
      setCurrentWidget();
    }else{
      AppUtils.showMessage(AppStrings.pleaseAddItemsToCart);
    }
  }

  Future<List<CartItemDataDetail>> getItemsFromCartId(List<int> cartIds) async {
    List<CartItemDataDetail> cartItms = [];
    for (int cartId in cartIds){
      var items = await instance.execQuery('SELECT * FROM ${instance.cartItemDataDetail} WHERE ${CartItemDataDetailFields.id} = $cartId');
     for(var item in items){
       CartItemDataDetail cart = CartItemDataDetail(
           item['storeId'],
           item['productId'],
           item['productName'],
           item['isFree']==1,
           item['packId'],
           item['packValue'],
           item['packCount'],
           item['_count'],
           item['schemeId'],
           item['createdAt'],
           item['updatedAt']);
       cart.id = cartId;
       cartItms.add(cart);
     }
    }
    return cartItms;
  }

  Future<List<int>> getServiceableDistributors(List<int> cartIds)async{
    List<int> ids = [];
    Map<int,List<int>> mapProdDist = Map();
    List<CartItemDataDetail> cartItms = await getItemsFromCartId(cartIds);

    for(var itm in cartItms){
      List<int> types = [];
      var typesRaw =  await instance.execQuery('SELECT ${ProductDataDistributorTypeDataDetailFields.distributorTypeId} FROM ${instance.productDataDistributorTypeDataDetail} WHERE ${ProductDataDistributorTypeDataDetailFields.productId} = ${itm.productId} AND ${ProductDataDistributorTypeDataDetailFields.salesmanId} = $selectedUser"');
      for (var type in typesRaw){
        types.add(type[ProductDataDistributorTypeDataDetailFields.distributorTypeId]);
      }
      List<int> distributor = [];
      List<UserHierarchySalesmanDistributor> dist = await getListOfDistributorsInType(types);
      for (UserHierarchySalesmanDistributor d in dist){
        distributor.add(d.id!);
      }
      mapProdDist.putIfAbsent(itm.productId!,() =>distributor);
    }

    if (mapProdDist.length>1){
      List<int> finalIds = [];
      List<int> pIds = mapProdDist.keys.toList();
      List<int> p1Ids = mapProdDist[pIds[0]]!;
      for (int p1DistId in p1Ids){
        int count = 0;
        for (int i=1;i<pIds.length;i++){
          for (int dId in mapProdDist[pIds[i]]!) {
            if (p1DistId==dId){
              count++;
              break;
            }
          }
      }
        if (count==(mapProdDist.length-1)) {
          finalIds.add(p1DistId);
        }
      }

      if (finalIds.isNotEmpty){
        ids.addAll(finalIds);
      }
    }

    return ids;
    
  }

  Future<List<UserHierarchySalesmanDistributor>> getListOfDistributorsInType(List<int> types) async{
    List<UserHierarchySalesmanDistributor> availableDistributor = [];

    for(var dis in availableDistributors){
      var dTypes = dis.distributorTypes??[];
      for(var type in dTypes){
        if(types.contains(type.id)){
          availableDistributor.add(dis);
          break;
        }
      }
    }


    return availableDistributor;
  }

  void getDistributors() async{

    List<UserHierarchySalesmanDistributor> available = [];

    List<UserHierarchySalesmanDistributor> distributors = [];
    List<StoreDistributorRelation> storeDistributors = [];


    var user = await AppUtils.getUserFromHierarchyById(instance, selectedUser);
    List<dynamic> parsedList = jsonDecode(user!.salesmanDistributors!);
    distributors = List<UserHierarchySalesmanDistributor>.from(parsedList.map<UserHierarchySalesmanDistributor>((dynamic i) => UserHierarchySalesmanDistributor.fromJson(i)));

    List<dynamic> parsedListStore = jsonDecode(store.distributorRelation!);
    storeDistributors = List<StoreDistributorRelation>.from(parsedListStore.map<StoreDistributorRelation>((dynamic i) => StoreDistributorRelation.fromJson(i)));

    for(var relation in storeDistributors){
      if(relation.isServing!){
        for(var dist in distributors){
          if(dist.id==relation.distributorId){
            available.add(dist);
            break;
          }
        }
      }
    }

    setState(() {
      availableDistributors = available;
    });

  }

}
