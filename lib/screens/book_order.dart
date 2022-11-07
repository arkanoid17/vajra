import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vajra/db/database_helper.dart';
import 'package:vajra/db/pricing_data_detail/pricing_data_detail.dart';
import 'package:vajra/db/store_price_mapping_data_detail/store_price_mapping_data_detail.dart';
import 'package:vajra/db/stores_data_detail/stores_data_detail.dart';

import '../db/product_data_detail/product_data_detail.dart';

class BookOrder extends StatefulWidget{

  final Object? arguments;

  const BookOrder(this.arguments, {Key? key}) : super(key: key);

  @override
  State<BookOrder> createState() => _BookOrder();
}

class _BookOrder extends State<BookOrder>{


  late StoresDataDetail store;

  List<ProductDataDetail> productList = [];
  List<ProductDataDetail> filteredList = [];

  int selectedUser = 0;

  late DatabaseHelper instance;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void getPricings()async {
    var pricingResults = await  instance.execQuery('SELECT ${StorePriceMappingDataDetailFields.pricingList} FROM ${instance.storePriceMappingDataDetail} WHERE ${StorePriceMappingDataDetailFields.storeId} = ${store.storeId} AND ${StorePriceMappingDataDetailFields.scope} = Field AND ${StorePriceMappingDataDetailFields.userId} = $selectedUser AND ${StorePriceMappingDataDetailFields.status} = ${true}');
    var pricingId = -1;
    for( var pricing in pricingResults){
      pricingId = pricing[StorePriceMappingDataDetailFields.pricingList];
      break;
    }
    var priceListResults = await instance.execQuery('SELECT * FROM ${instance.pricingDataDetail} WHERE ${PricingDataDetailFields.pricing_id} = $pricingId AND ${PricingDataDetailFields.userId} = $selectedUser AND ${PricingDataDetailFields.pricing_status} = ${true} AND ${PricingDataDetailFields.product_status} = ${true}');
    for(var price in priceListResults){
      ProductDataDetail? prd;
      var prdResult = await instance.execQuery('SELECT * FROM ${instance.productDataDetail} where product_id = :val');
      
    }
  }

  @override
  void initState() {
    instance = DatabaseHelper.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;

    setState(() {
      store = arguments['store'];
      selectedUser = arguments['selectedUser'];

    });

    getPricings();

    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(store.name!=null?store!.name!:''),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),


    );
  }

}