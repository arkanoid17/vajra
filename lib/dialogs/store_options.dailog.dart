import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vajra/db/stores_data_detail/stores_data_detail.dart';
import 'package:vajra/resource_helper/color_constants.dart';
import 'package:vajra/resource_helper/strings.dart';

class StoreOptionsDialog extends StatefulWidget{

  final StoresDataDetail store;

  const StoreOptionsDialog ({ Key? key , required this.store}): super(key: key);

  @override
  State<StoreOptionsDialog> createState() => _StoreOptionsDialog();
}

class _StoreOptionsDialog extends State<StoreOptionsDialog>{
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.all(16),child: Center(child: Text(widget.store.name!,style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),)),),
          Divider(
            thickness: 1,
            color: ColorConstants.color_ECE6F6_96,
          ),
          Padding(padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 5),child: Text(AppStrings.selectStoreAction,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),),),
          Padding(padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 5),child: Row(children: [
            Image.asset("assets/images/view_store_primary.png"),
            const SizedBox(width: 15,),
            Expanded(child: Text(AppStrings.viewStore,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),),),
          ],)),
          Padding(padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 5),child: Row(children: [
            Image.asset("assets/images/book_order_primary.png"),
            const SizedBox(width: 15,),
            Expanded(child: Text(AppStrings.bookOrder,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),),),
          ],)),
          Padding(padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 5),child: Row(children: [
            Image.asset("assets/images/bill_no_order_primary.png"),
            const SizedBox(width: 15,),
            Expanded(child: Text(AppStrings.billNoOrder,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),),),
          ],)),
          Padding(padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 5),child: Row(children: [
            Image.asset("assets/images/task_primary.png"),
            const SizedBox(width: 15,),
            Expanded(child: Text(AppStrings.task,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),),),
          ],)),
          Padding(padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 5),child: Row(children: [
            Image.asset("assets/images/call_primary.png"),
            const SizedBox(width: 15,),
            Expanded(child: Text(AppStrings.callStore,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),),),
          ],)),
          Padding(padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 5),child: Row(children: [
            Image.asset("assets/images/message_primary.png"),
            const SizedBox(width: 15,),
            Expanded(child: Text(AppStrings.messageStore,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),),),
          ],)),
          Padding(padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 5),child: Row(children: [
            Image.asset("assets/images/navigation_primary.png"),
            const SizedBox(width: 15,),
            Expanded(child: Text(AppStrings.navigation,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),),),
          ],)),
          Padding(padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 5),child: Row(children: [
            Image.asset("assets/images/view_image_primary.png"),
            const SizedBox(width: 15,),
            Expanded(child: Text(AppStrings.viewImage,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),),),
          ],)),
        ],
      );
  }

}