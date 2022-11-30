import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vajra/dialogs/user_hierarchy_list_dropdown.dart';
import 'package:vajra/models/user_hierarchy/user_hierarchy_location.dart';
import 'package:vajra/models/user_selector/user_selector.dart';
import 'package:vajra/resource_helper/strings.dart';
import 'package:vajra/utils/app_utils.dart';

class UserHierarchySelectionComponent extends StatefulWidget{

  final List<UserSelector> listSelector;
  final Function setSelectedUser;

  const UserHierarchySelectionComponent ({ Key? key, required this.listSelector, required this.setSelectedUser }): super(key: key);

  @override
  State<UserHierarchySelectionComponent> createState() => _UserHierarchySelectionComponent();
}

class _UserHierarchySelectionComponent extends State<UserHierarchySelectionComponent>{
  
  List<UserSelector> selectorList = [];
  
  @override
  void initState() {
    setState(() {
      selectorList = widget.listSelector;
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: getHierarchy(selectorList),
    );
  }

  List<Widget> getHierarchy(List<UserSelector> selectors){
    List<Widget> widgets = [];

    int pos = -1;
    bool isSelected = false;
    for(UserSelector selector in selectors){
      ++pos;
      if(selector.isSelected){
        isSelected = true;
        widgets.add(getWidget(selectors,pos));
        if(selector.userSelectors!=null && selector.userSelectors!.isNotEmpty){
          widgets.addAll(getHierarchy(selector.userSelectors!));
        }
      }
    }

    if(!isSelected){
      widgets.add(getEmptyWidget(selectors));
    }

    return widgets;
  }

  Widget getEmptyWidget(List<UserSelector> selectors){
    return InkWell(
      onTap: (){
        AppUtils.showBottomDialog(context,true,false,Colors.white,UserHierarchyListDropDown(listSelector: selectors,selectedUserFromList:selectedUserFromList));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration:BoxDecoration(
          borderRadius: BorderRadius.all(
              Radius.circular(4)),
          border: Border.all(
            color: Colors.grey.shade400,
            width: 1,
          ),
        ),
        child: Padding(padding: EdgeInsets.all(8),child: Row(
          children: [
            Expanded(child: Text(AppStrings.select,style: TextStyle(color: Colors.grey,fontSize: 16),),flex: 9,),
            Expanded(child: Icon(Icons.expand_more,color: Colors.grey,),flex: 1,)
            
          ],
        ),),
      ),
    );
  }

  Widget getWidget(List<UserSelector> selectors,int pos){
    UserSelector selector = selectors[pos];
    return InkWell(child: Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration:BoxDecoration(
        borderRadius: BorderRadius.all(
            Radius.circular(4)),
        border: Border.all(
          color: Colors.grey.shade400,
          width: 1,
        ),
      ),
      child: Padding(padding: EdgeInsets.all(8),child: Row(
        children: [
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(selector.name!,style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w700),),
              SizedBox(height: 5,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 2,
                      child: Text(selector.userId!,style: TextStyle(color: Colors.grey,fontSize: 10),)),
                  Expanded(
                      flex: 8,
                      child: Container(
                        child: Row(
                          children: selector.locations!.map((e) => Row(children: [
                            SizedBox(width: 10,),
                            Text('|  ',style: TextStyle(color: Colors.grey,fontSize: 10,),),
                            Icon(Icons.pin_drop,color: Colors.grey,size: 12,),
                            SizedBox(width: 4,),
                            Text('${e.name!}',style: TextStyle(color: Colors.grey,fontSize: 10),)
                          ],)).toList(),
                        ),
                      )),
                ],
              )
            ],
          ),flex: 9,),
          Expanded(child: Icon(Icons.expand_more,color: Colors.grey,),flex: 1,)
        ],
      ),),
    ),
    onTap: (){
      AppUtils.showBottomDialog(context,true,false,Colors.white,UserHierarchyListDropDown(listSelector: selectors,selectedUserFromList: selectedUserFromList));
    },);
  }

  void selectedUserFromList(List<UserSelector> selectors,int pos){
   if(!selectors[pos].isSelected){
     widget.setSelectedUser(selectors[pos]);
     int c = -1;
     for(UserSelector sel in selectors){
       ++c;
       sel.isSelected = c==pos;
       if(sel.userSelectors!=null && sel.userSelectors!.isNotEmpty) {
         setAllSublistIsSelectedAsFalse(sel.userSelectors!);
       }
     }
     //set selectors to respective level
     List<UserSelector> selList = (selectorList!=null && selectorList.isNotEmpty)?selectorList:[];
     selList = checkWithLevel(selectors,selList);
     setState(() {
       selectorList = selList;
     });
   }
  }

  List<UserSelector> checkWithLevel(List<UserSelector> currentLevel,List<UserSelector> allLevels){

    if(currentLevel.isNotEmpty && allLevels.isNotEmpty){
      if(currentLevel[0].id == allLevels[0].id){
        return currentLevel;
      }else{
        for(UserSelector sel in allLevels){
          if(sel.userSelectors!=null && sel.userSelectors!.isNotEmpty){
            checkWithLevel(currentLevel, sel.userSelectors!);
          }
        }
      }
    }

    return allLevels;
  }

  void setAllSublistIsSelectedAsFalse(List<UserSelector> sel){
      for(UserSelector selector in sel){
        selector.isSelected = false;
        if(selector.userSelectors!=null && selector.userSelectors!.isNotEmpty) {
          setAllSublistIsSelectedAsFalse(selector.userSelectors!);
        }
    }
  }

}