import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vajra/components/bottom_dialog_selection_component.dart';
import 'package:vajra/components/user_hierarchy_selection_component.dart';
import 'package:vajra/db/database_helper.dart';
import 'package:vajra/db/product_data_detail/product_data_detail.dart';
import 'package:vajra/db/schemes_data_detail/schemes_data_detail.dart';
import 'package:vajra/db/user_hierarchy_data_detail/user_hierarchy_data_detail.dart';
import 'package:vajra/models/bottom_selection_data_model/bottom_selection_data_model.dart';
import 'package:vajra/models/common_schemes/common_schemes.dart';
import 'package:vajra/models/product/product_response.dart';
import 'package:vajra/models/user_hierarchy/hierarchy_beat_calendar.dart';
import 'package:vajra/models/user_hierarchy/user_hierarchy_beat.dart';
import 'package:vajra/models/user_selector/user_selector.dart';
import 'package:vajra/resource_helper/color_constants.dart';
import 'package:vajra/resource_helper/strings.dart';
import 'package:vajra/services/APIServices.dart';
import 'package:vajra/utils/app_utils.dart';

import '../db/product_distributor_type_data_detail/product_distributor_type_data_detail.dart';
import '../models/product/product.dart';
import '../models/user_hierarchy/distributor_types.dart';

class UserSelectionDialog extends StatefulWidget{

  final List<UserHierarchyDataDetail> allUsers;
  final List<UserSelector> listUser;
  final SharedPreferences prefs;
  final String todayDate;
  final Function getDate;
  final Function applyFilter;
  final List<UserHierarchyBeat> availableBeats;
  final List<UserHierarchyBeat> selectedBeats;
  final int selectedUser;

  const UserSelectionDialog ({ Key? key, required this.allUsers, required this.listUser, required this.prefs, required this.todayDate, required this.getDate, required this.applyFilter, required this.availableBeats, required this.selectedBeats, required this.selectedUser }): super(key: key);

  @override
  State<UserSelectionDialog> createState() => _UserSelectionDialog();
}

class _UserSelectionDialog extends State<UserSelectionDialog>{

  String userType = AppStrings.active;
  UserSelector? selectedUser;
  List<UserSelector> selectorList = [];

  List<UserHierarchyBeat> availableBeats = [];
  List<UserHierarchyBeat> selectedBeats = [];

  TextEditingController dateController = TextEditingController();
  TextEditingController beatsController = TextEditingController();

  Map<String,String> headers = {};

  late DatabaseHelper instance;

  @override
  void initState() {
    setState(() {
      selectedUser = widget.listUser.where((element) => element.id==widget.selectedUser).first;
    });
    setInitUser();
    setState(() {
      dateController.text = widget.todayDate;
      getAvailableBeats();
    });
    headers = AppUtils.headers(
        widget.prefs.getString('tenant_id')!=null?widget.prefs.getString('tenant_id')!:'',
        widget.prefs.getString('token')!=null?widget.prefs.getString('token')!:''
    );
    instance = DatabaseHelper.instance;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.applyFilters),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 25,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 7,
                      child: Text(AppStrings.selectUser,style: TextStyle(color: Colors.grey,fontSize: 14),)),
                  Expanded(
                      flex: 3,
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(4)),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          child: Padding(
                              padding: EdgeInsets.all(3), child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(userType,style: TextStyle(color: Colors.grey,fontSize: 12),),
                              Icon(Icons.expand_more,color: Colors.grey,)
                            ],
                          )
                          ),
                        ),
                      )
                  )
                ],
              ),
              SizedBox(height: 10,),
              Container(
              width: double.infinity,
              child: Column(
                children: [
                  UserHierarchySelectionComponent(listSelector: selectorList,setSelectedUser:setSelectedUser)
                ],
              ),
            ),
              TextField(
                readOnly: true,
                onTap: (){
                  AppUtils.showDatePickerDialog(context, dateController.text.isNotEmpty?dateController.text:DateFormat('dd/MM/yyyy').format(DateTime.now()), getDate);
                },
                controller: dateController,
                decoration:  InputDecoration(
                    isDense: true,
                    suffixIcon: IconButton(icon: const Icon(Icons.clear),onPressed:(){
                      setState(() {
                        dateController.text = '';
                        getAvailableBeats();
                      });
                    }),
                    border: OutlineInputBorder(),
                    labelText: AppStrings.date,
                    hintText: AppStrings.date),
              ),
              SizedBox(height: 10,),
              TextField(
                controller: beatsController,
                onTap: (){
                  AppUtils.showBottomDialog(context, true, getIdNameMaps().length>5?true:false, Colors.white,BottomDialogSelectionComponent(idNameMap:getIdNameMaps(),selectedIds:getSelectedIds(),setSelected: setSelected));
                },
                readOnly: true,
                decoration:  InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                  labelText: AppStrings.beats,
                    hintText: AppStrings.beats),
                ),
              Expanded(
                  flex: 1,
                  child: Container()
              ),
              Row(
                children: [
                  Expanded(child: ElevatedButton(
                      onPressed: (){
                        if(selectedUser!=null) {
                          callServices();
                          widget.applyFilter(selectedUser!.id,availableBeats,selectedBeats,dateController.text);
                        }
                        Navigator.pop(context);
                      },
                      child: Text(AppStrings.apply.toUpperCase(),style: TextStyle(fontSize: 16),),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            EdgeInsets.all(8)),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(18.0),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty
                            .all(ColorConstants.colorPrimary),
                        // <-- Button color
                      )))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }


  void setSelected(List<int> selectedIds){
    List<UserHierarchyBeat> selected = [];
    for(int id in selectedIds){
      selected.add(availableBeats.where((element) => element.id==id).first);
    }
    setState(() {
      selectedBeats = selected;
      beatsController.text = selected.map((e) => e.name).toList().join(', ');
    });
  }

  List<BottomSelectionDataModel> getIdNameMaps(){
    List<BottomSelectionDataModel> idNameMap = [];
    if(availableBeats.isNotEmpty){
      idNameMap = availableBeats.map((e) => BottomSelectionDataModel(e.id!, e.name!)).toList();
    }
    return idNameMap;
  }

  List<int> getSelectedIds(){
    List<int> selectedIds = [];
    if(selectedBeats.isNotEmpty){
      selectedIds = selectedBeats.map((e) => e.id!).toList();
    }
    return selectedIds;
  }

  void setSelectedUser(UserSelector user){
    setState(() {
      selectedUser = user;
    });
    getAvailableBeats();
  }

  void getDate(String date){
    setState(() {
      dateController.text = date;
    });
    getAvailableBeats();
  }


  void setInitUser() {
    List<UserSelector> selectors = [];
    for(UserSelector entity in widget.listUser){
      if (entity.id == AppUtils.getSalesman(widget.prefs)) {
        entity.isSelected = true;
          if(widget.selectedUser==entity.id) {
            setState(() {
              selectedUser = entity;
            });
          }
        selectors.add(entity);
      }
    }
    for (UserSelector user in selectors) {
      user.userSelectors = createSubList(user);
    }

    setState(() {
      selectorList = selectors;
    });

  }

  List<UserSelector> createSubList(UserSelector user){
    List<UserSelector> subList = [];
    for (UserSelector userAll in widget.listUser) {
      if (userAll.manager!=null && userAll.manager==user.id) {
        subList.add(userAll);
        userAll.userSelectors = createSubList(userAll);
      }
    }
    return subList;
  }

  void getAvailableBeats(){
    List<UserHierarchyBeat> todayBeats = [];
    if(selectedUser!=null && selectedUser!.beats!=null && selectedUser!.beats!.isNotEmpty){
      if(dateController.text.isNotEmpty){
        int wk = AppUtils.weekOfTheMonth(DateFormat('dd/MM/yyyy').parse(dateController.text));
        String dayOfWeek = AppUtils.dayOfTheWeek(DateFormat('dd/MM/yyyy').parse(dateController.text));
        for(UserHierarchyBeat beat in selectedUser!.beats!){
          if (beat.calendar != null && beat.calendar!.isNotEmpty) {
            for (HierarchyBeatCalendar calendar in beat.calendar!) {
              if (calendar.dayName == dayOfWeek && calendar.weekNo == wk) {
                todayBeats.add(beat);
                break;
              }
            }
          }
        }
      }else{
        todayBeats = selectedUser!.beats!;
      }
    }
    setState(() {
      print(todayBeats.length);
      availableBeats = todayBeats;
      selectedBeats = todayBeats;
      beatsController.text = todayBeats.map((e) => e.name).toList().join(', ');
    });
  }

  void callServices() async{

    /*scheme service start*/
    bool noPage = true;
    String schemeUrl = '${AppUtils.baseUrl}${APIServices.schemeServices}?no_page=$noPage';
    var schemes = await AppUtils.requestBuilder(schemeUrl, headers);
    try {
      if (schemes.statusCode == 200) {
        handleSchemeResponse(schemes.body,selectedUser!.id!);
      }
    } catch (e) {
      AppUtils.showMessage(e.toString());
    }
    /*scheme service end*/

    /*product service start*/
    String productUrl = '${AppUtils.baseUrl}${APIServices.products}?salesman_id=${selectedUser!.id!}';
    var products = await AppUtils.requestBuilder(productUrl, headers);
    try {
      if (products.statusCode == 200) {
        handleProductResponse(products.body,selectedUser!.id!);
      }
    } catch (e) {
      AppUtils.showMessage( 'product error ${e.toString()}');
    }
    /*product service end*/
  }

  void handleSchemeResponse(String body, int id) async {
    if(body.isNotEmpty){

      var val = await instance.execQuery('DELETE FROM ${instance.schemesDataDetail} where ${SchemeDataDetailFields.salesmanId} = $id');

      List<dynamic> parsedListJson = jsonDecode(body);
      List<CommonSchemes> schemes = List<CommonSchemes>.from(parsedListJson.map<CommonSchemes>((dynamic i) => CommonSchemes.fromJson(i)));
      if(schemes.isNotEmpty){
        SchemesDataDetail detail;
        schemes.map((scheme) => {
          if(scheme.products !=null){
            scheme.products?.map((schemeProduct) => {
              detail = SchemesDataDetail(scheme.id, schemeProduct.product!.id , scheme.name, schemeProduct.product!.name, schemeProduct.minQty, scheme.tenure,double.parse(scheme.minPurchaseValue!), double.parse(scheme.schemeValue!), scheme.schemeType!.name, scheme.startDate, scheme.endDate, schemeProduct.isFree, scheme.description, scheme.schemeType!.id, scheme.schemeType!.name, id),
              instance.insert(instance.schemesDataDetail, detail.toJson()),
            }),
          }
        });
      }
    }
  }

  void handleProductResponse(String body,int id) async{
    if(body.isNotEmpty){
      ProductResponse productResponse = ProductResponse.fromJson(jsonDecode(body));
      if(productResponse.data != null){
        instance.execQuery('DELETE FROM ${instance.productDataDetail} where ${ProductDataFields.salesmanId} = $id');
        ProductDataDetail product;
        int isInserted;
        for (Product prd in productResponse.data!) {
          product = ProductDataDetail(
              prd.productName,
              prd.productId,
              prd.barcodeNumber,
              prd.hsnNumber,
              prd.description,
              prd.manufacturer,
              prd.productCategory,
              prd.scope,
              prd.mrp,
              prd.nrv,
              prd.ptr,
              prd.taxType,
              prd.isQps,
              prd.discountValue,
              prd.productStatus,
              prd.quantityLimit,
              "",
              //todo: add value
              prd.pts,
              prd.netPrice,
              prd.isFeatureProduct,
              jsonEncode(prd.packs?.map((e) => e.toJson()).toList()),
              prd.pricingId,
              prd.pricingNodeId,
              prd.queryNodeId,
              prd.channel,
              0,
              0,
              prd.image,
              id,
              jsonEncode(prd.brand),
              0,
              0);
          isInserted = await instance.insert(instance.productDataDetail, product.toJson());
          if(prd.distributorTypes!=null && prd.distributorTypes!.isNotEmpty){
            for(DistributorTypes type in prd.distributorTypes!){
              ProductDataDistributorTypeDataDetail detail = ProductDataDistributorTypeDataDetail(prd.productId, selectedUser!.id, type.id, type.name);
              instance.insert(instance.productDataDistributorTypeDataDetail, detail.toJson());
            }
          }
        }

      }
    }
  }


}