import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vajra/db/cart_item_data_detail/cart_item_distributor_type.dart';
import 'package:vajra/db/database_helper.dart';
import 'package:vajra/db/stores_data_detail/stores_data_detail.dart';
import 'package:vajra/list_items/cart_item.dart';
import 'package:vajra/resource_helper/strings.dart';
import 'package:vajra/utils/app_utils.dart';

import '../db/cart_item_data_detail/cart_item_data_detail.dart';
import '../db/product_data_detail/product_data_detail.dart';
import '../models/order_dtls/order_dtls.dart';
import '../models/user_hierarchy/user_hierarchy_salesman_distributors.dart';
import '../resource_helper/color_constants.dart';

class CartItemsList extends StatefulWidget {
  final List<ProductDataDetail> itemList;
  final List<CartItemDataDetail> cartItems;
  final StoresDataDetail store;
  final Function getItemsFromCartId;
  final Function getServiceableDistributors;
  final Function getListOfDistributorsInType;
  final String visitId;
  final SharedPreferences prefs;
  final int selectedUser;
  final List<UserHierarchySalesmanDistributor> availableDistributors;

  const CartItemsList(
      {Key? key,
      required this.itemList,
      required this.cartItems,
      required this.store,
      required this.getItemsFromCartId,
      required this.getServiceableDistributors,
      required this.visitId,
      required this.getListOfDistributorsInType,
      required this.prefs,
      required this.selectedUser,
      required this.availableDistributors})
      : super(key: key);

  @override
  State<CartItemsList> createState() => _CartItemsList();
}

class _CartItemsList extends State<CartItemsList> {

  late DatabaseHelper instance;
  List<OrderDtls> orderDtls = [];
  List<Widget> header = [];

  @override
  void initState() {
    instance = DatabaseHelper.instance;
    splitOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Expanded(child:
        ListView.builder(
            itemCount: orderDtls.length,
            itemBuilder: (ctx,index){
              return CartItem(
                  detail: orderDtls[index],
                  items:  widget.itemList,
                  prefs: widget.prefs,
                selectedUser: widget.selectedUser,
                availableDistributors: widget.availableDistributors,
                orderNum: (index+1)
              );
            })),


        Container(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                onPressed: () {},
                child: Text(AppStrings.placeOrder),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.colorPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // <-- Radius
                  ),
                ),
              )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: ElevatedButton(
                onPressed: () {},
                child: Text(AppStrings.verifyOrder),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // <-- Radius
                  ),
                ),
              ))
            ],
          ),
        )
      ],
    );
  }

  void splitOrders() async {
    List<OrderDtls> updatedOrderDetails = [];

    Map<List<int>, List<CartItemDataDetail>> mapTypeCart = Map();
    Map<List<int>, List<CartItemDataDetail>> mapDistributorCart = Map();

    List<int> schemeIds = [];
    var schemeIdRaw = await instance.execQuery(
        'SELECT ${CartItemDataDetailFields.schemeId} FROM ${instance.cartItemDataDetail} WHERE ${CartItemDataDetailFields.storeId} = "${widget.store.storeId}" GROUP BY ${CartItemDataDetailFields.schemeId}');
    for (var scheme in schemeIdRaw) {
      if (scheme[CartItemDataDetailFields.schemeId] != 0) {
        schemeIds.add(scheme[CartItemDataDetailFields.schemeId]);
      }
    }

    //map scheme cart items
    for (int schemeId in schemeIds) {
      List<int> cartIds = [];
      var cartIdsRaw = await instance.execQuery(
          'SELECT ${CartItemDataDetailFields.id} from ${instance.cartItemDataDetail} WHERE ${CartItemDataDetailFields.storeId} = "${widget.store.storeId}" AND ${CartItemDataDetailFields.schemeId} = $schemeId ');
      for (var cartId in cartIdsRaw) {
        cartIds.add(cartId[CartItemDataDetailFields.id]);
      }

      List<int> mostCommonType = [];

      String cIds = cartIds.join(', ');
      var cTypes = await instance.execQuery(
          'SELECT ${CartItemDistributorTypeFields.distributorTypeId}, count(*) AS cnt FROM ${instance.cartItemDistributorTypeDataDetail} WHERE ${CartItemDistributorTypeFields.cartId} IN ($cIds) GROUP BY ${CartItemDistributorTypeFields.distributorTypeId} ORDER BY cnt DESC');

      Map<int, int> mapTypeCount = Map();
      for (var cType in cTypes) {
        mapTypeCount.putIfAbsent(
            cType[CartItemDistributorTypeFields.distributorTypeId],
            () => cType['cnt']);
      }
      mostCommonType.addAll(AppUtils.getMax(mapTypeCount));

      if (mapTypeCart.isNotEmpty) {
        for (List<int> typeIds in mapTypeCart.keys) {
          List<int> common = getSubList(typeIds, mostCommonType);
          if (common.isNotEmpty) {
            //take history and current and compare if exist replace, if not add
            List<CartItemDataDetail> items = [];

            List<CartItemDataDetail> history =
                mapTypeCart[typeIds] != null ? mapTypeCart[typeIds]! : [];
            List<CartItemDataDetail> current =
                await widget.getItemsFromCartId(cartIds);

            if (current.isNotEmpty) {
              items.addAll(current);
            }

            if (history.isNotEmpty) {
              items.addAll(history);
            }

            mapTypeCart.remove(typeIds);
            mapTypeCart.putIfAbsent(common, () => items);
            break;
          } else {
            var itms = await widget.getItemsFromCartId(cartIds);
            mapTypeCart.putIfAbsent(mostCommonType, () => itms);
          }
        }
      } else {
        if (mostCommonType.isNotEmpty) {
          var itms = await widget.getItemsFromCartId(cartIds);
          mapTypeCart.putIfAbsent(mostCommonType, () => itms);
        } else {
          var itms = await widget.getItemsFromCartId(cartIds);
          var dists = await widget.getServiceableDistributors(cartIds);
          mapDistributorCart.putIfAbsent(dists, () => itms);
        }
      }
    }
    //get regular items

    List<int> cartIds = [];
    var cartIdsRaw = await instance.execQuery(
        'SELECT ${CartItemDataDetailFields.id} from ${instance.cartItemDataDetail} WHERE ${CartItemDataDetailFields.storeId} = "${widget.store.storeId}" AND ${CartItemDataDetailFields.schemeId} = 0 ');
    for (var cartId in cartIdsRaw) {
      cartIds.add(cartId[CartItemDataDetailFields.id]);
    }




    for (int cartId in cartIds) {
      List<int> tempCartId = [];
      tempCartId.add(cartId);

      List<int> distTypeIds = [];
      var distTypeIdsRaw = await instance.execQuery(
          'SELECT ${CartItemDistributorTypeFields.distributorTypeId} FROM ${instance.cartItemDistributorTypeDataDetail} WHERE ${CartItemDistributorTypeFields.cartId} = $cartId');
      for (var id in distTypeIdsRaw) {
        distTypeIds.add(id[CartItemDistributorTypeFields.distributorTypeId]);
      }

      if (mapTypeCart.isNotEmpty) {
        for (List<int> typeIds in mapTypeCart.keys.toList()) {
          List<int> common = getSubList(typeIds, distTypeIds);
          if (common.isNotEmpty) {
            //take history and current and compare if exist replace, if not add
            List<CartItemDataDetail> items = [];
            List<CartItemDataDetail> history =
                mapTypeCart[typeIds] != null ? mapTypeCart[typeIds]! : [];

            List<CartItemDataDetail> current =
                await widget.getItemsFromCartId(tempCartId);

            // get history using cart id get current values and
            if (history.isNotEmpty) {
              for (CartItemDataDetail hItem in history) {
                var itm = await widget.getItemsFromCartId([hItem.id!]);
                if (itm != null) {
                  items.addAll(itm);
                }
              }
            }

            //using current check if already there don't bother if not add
            if (current.isNotEmpty) {
              for (CartItemDataDetail cItem in current) {
                if (!cartItemExistInList(items, cItem.id!)) {
                  items.add(cItem);
                }
              }
            }
            mapTypeCart.remove(typeIds);
            mapTypeCart.putIfAbsent(common, () => items);
            break;
          } else {
            var itms = await widget.getItemsFromCartId(tempCartId);
            mapTypeCart.putIfAbsent(distTypeIds, () => itms);
          }
        }
      } else {
        var itms = await widget.getItemsFromCartId(tempCartId);
        mapTypeCart.putIfAbsent(distTypeIds, () => itms);
      }
    }

    //assemble order details from map
    int cnt = 0;

    print(mapTypeCart);

    //first all types
    for (List<int> types in mapTypeCart.keys) {
      cnt++;
      OrderDtls? details;

      String transactionId = '${widget.visitId}$cnt';
      OrderDtls? existingOrder = checkExist(mapTypeCart[types]!, orderDtls);

      if (existingOrder != null) {
        details = existingOrder;
        List<CartItemDataDetail> items = [];
        items.addAll(mapTypeCart[types]!);
        details.items = items;
        details.availableDistTypes = types;
      } else {
        details = OrderDtls(transactionId, '', 0, '', '', 0, types, null, true,
            false, mapTypeCart[types] != null ? mapTypeCart[types]! : []);

        if (types.length == 1) {
          details.distributorTypeId = types[0];
          details.distributorType = await getDistributorTypeNames(types[0]);

          List<UserHierarchySalesmanDistributor> distributorFromTypes = [];
          distributorFromTypes.addAll(await widget.getListOfDistributorsInType(types));
          if (distributorFromTypes.length == 1) {
            details.distributorId = distributorFromTypes[0].id;
            details.distributorName = distributorFromTypes[0].name;
          }
        }
        details.items = mapTypeCart[types]!;
      }
      updatedOrderDetails.add(details);
    }

    //Then distributors
    for (List<int> distributors in mapDistributorCart.keys) {
      cnt++;
      OrderDtls? details;
      String transactionId = '${widget.visitId}$cnt';
      OrderDtls? existingOrder =
          checkExist(mapDistributorCart[distributors]!, orderDtls);

      if (existingOrder != null) {
        details = existingOrder;
        List<CartItemDataDetail> items = [];
        items.addAll(mapDistributorCart[distributors]!);
        details.items = items;
        details.availableDistributors = distributors;
      } else {
        details = OrderDtls(transactionId, '', 0, '', null, 0, null,
            distributors, false, true, []);

        if (distributors.length == 1) {
          details.distributorId = distributors[0];
          details.distributorName = getNameFromDistId(distributors[0]);
        }
        details.items = mapDistributorCart[distributors]!;
      }
      updatedOrderDetails.add(details);
    }

    setState(() {
      orderDtls = updatedOrderDetails;
    });
  }

  List<int> getSubList(List<int> typeIds, List<int> mostCommonType) {
    typeIds.removeWhere((item) => !mostCommonType.contains(item));
    return typeIds;
  }

  bool cartItemExistInList(List<CartItemDataDetail> items, int id) {
    for (CartItemDataDetail item in items) {
      if (item.id == id) {
        return true;
      }
    }

    return false;
  }

  OrderDtls? checkExist(List<CartItemDataDetail> cartItemsDataDetails,
      List<OrderDtls> orderDtls) {
    for (CartItemDataDetail item in cartItemsDataDetails) {
      for (OrderDtls dtls in orderDtls) {
        for (CartItemDataDetail crtItem in dtls.items) {
          if (item.id == crtItem.id) {
            return dtls;
          }
        }
      }
    }

    return null;
  }

  Future<String?> getDistributorTypeNames(int typ) async {
    String name = '';
    List<UserHierarchySalesmanDistributor> dist = await
        widget.getListOfDistributorsInType([typ]);
    for (var dis in dist) {
      for (var type in dis.distributorTypes!) {
        if (type.id == typ) {
          name = type.name!;
        }
      }
    }
    return name;
  }

  String? getNameFromDistId(int distributor) {
    String name = '';
    return name;
  }

  List<Widget> getOrderItems() {
    List<Widget> widgets = [];

    int c = 0;

    for (OrderDtls details in orderDtls) {
      ++c;
      widgets.add(Container(
          decoration: BoxDecoration(color: ColorConstants.color_ECE6F6_FF),
          padding: EdgeInsets.only(left: 8, right: 8),
          child: Expanded(
            child: Row(
              children: [
                SvgPicture.asset('assets/images/ic_brief_case_primary.svg'),
                SizedBox(width: 5),
                Text(
                  '${AppStrings.order} $c',
                  style: TextStyle(
                      color: ColorConstants.colorPrimary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 5),
                Expanded(
                    child: Text(
                  '${AppStrings.orderId}: ${details.transactionId}',
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
          )));
      widgets.add(
        Text(
          '${AppStrings.itemsSelected}: ${details.items.length}',
          style: TextStyle(
              color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w400),
        ),
      );
    }

    return widgets;

  }

  void onDistributorSelected(OrderDtls detail){
    var details = orderDtls;
    int pos = -1;
    for(OrderDtls dtl in details){
      ++pos;
      if(detail.transactionId==dtl.transactionId){
        details[pos] = detail;
      }
    }
    setState(() {
      orderDtls = details;
    });

  }



}
