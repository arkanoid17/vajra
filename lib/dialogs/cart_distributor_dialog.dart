import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vajra/models/order_dtls/order_dtls.dart';
import 'package:vajra/models/user_hierarchy/user_hierarchy_salesman_distributors.dart';
import 'package:vajra/resource_helper/color_constants.dart';
import 'package:vajra/resource_helper/strings.dart';

import '../db/distributor_data_detail/distributor_data_detail.dart';

class CartDistributorDialog extends StatefulWidget{

  final OrderDtls detail;
  final int selectedUser;
  final SharedPreferences prefs;
  final List<UserHierarchySalesmanDistributor> availableDistributors;
  final Function onDistributorSelected;
  final int selectedDistId;

  const CartDistributorDialog(
      {Key? key,
        required this.detail,
        required this.selectedUser,
        required this.prefs,
        required this.availableDistributors,
        required this.onDistributorSelected,
        required this.selectedDistId,
        })
      : super(key: key);

  @override
  State<CartDistributorDialog> createState() => _CartDistributorDialog();

}

class _CartDistributorDialog extends State<CartDistributorDialog>{

  List<UserHierarchySalesmanDistributor> distributors = [];

  @override
  void initState() {


    if(widget.detail.groupByType! && widget.detail.availableDistTypes!.length==1){
      getDistributorList();
    }


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5,),
            Padding(padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${AppStrings.orderId}: ${widget.detail.transactionId}',style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w700)),
                InkWell(
                  child: Wrap(
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Icon(Icons.edit_outlined,color: ColorConstants.colorPrimary,size: 14,),
                      SizedBox(width: 5,),
                      Text(AppStrings.editOrder, style: TextStyle(color: ColorConstants.colorPrimary,fontSize: 12),)
                    ],
                  ),
                  onTap: ()=>Navigator.pop(context),
                )
              ],
            ),),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: const Text(AppStrings.selectDistributor,style: TextStyle(color: Colors.grey,fontSize: 12),),
            ),
            SizedBox(height: 5,),
            distributors.isNotEmpty?Column(
              children: getDistributorsView(),
            ):Padding(padding: EdgeInsets.all(10),
            child: Text(AppStrings.noDistributorAvailable,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 14,color: Colors.black),),),
            SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }

  List<Widget> getDistributorsView() {
    List<Widget> views = [];
    for(var dist in distributors){
      views.add(
        ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -1),
          dense: true,
          leading: Container(
            width: 24,
            height: 24,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              border: Border.all(
                width: 1,
                color: Colors.grey.shade200
              ),
              color: widget.selectedDistId==dist.id?ColorConstants.color_ECE6F6_FF:Colors.white
            ),
            child: widget.selectedDistId==dist.id?SvgPicture.asset('assets/images/ic_distributor_primary.svg'):SvgPicture.asset('assets/images/ic_distributor_black.svg'),
          ),
          title: Text(dist.name!,style: TextStyle(fontSize: 12,color: widget.selectedDistId==dist.id?ColorConstants.colorPrimary:Colors.black,fontWeight: FontWeight.w500),),
          onTap: (){
            widget.onDistributorSelected(dist);
            Navigator.pop(context);
          },
        )
      );
    }
    return views;
  }

  void getDistributorList() async{
    List<UserHierarchySalesmanDistributor> distList = [];


    for(var dist in  widget.availableDistributors){

      bool hasValue = false;

      var types = dist.distributorTypes??[];
      for(var type in types){
        for(var id in widget.detail.availableDistTypes!){
          if(type.id==id){
            hasValue = true;
            break;
          }
        }
        if(hasValue){
          distList.add(dist);
          break;
        }
      }
    }


    setState(() {
      distributors = distList;
    });

  }

}