import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vajra/db/user_hierarchy_data_detail/user_hierarchy_data_detail.dart';
import 'package:vajra/models/user_selector/user_selector.dart';
import 'package:vajra/resource_helper/strings.dart';

class UserSelectionDialog extends StatefulWidget{

  final List<UserHierarchyDataDetail> allUsers;
  final List<UserSelector> listUser;

  const UserSelectionDialog ({ Key? key, required this.allUsers, required this.listUser }): super(key: key);

  @override
  State<UserSelectionDialog> createState() => _UserSelectionDialog();
}

class _UserSelectionDialog extends State<UserSelectionDialog>{


  String userType = AppStrings.active;

  @override
  void initState() {
    // TODO: implement initState
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
                              Icon(Icons.arrow_drop_down,color: Colors.grey,)
                            ],
                          )
                          ),
                        ),
                      )
                  )
                ],
              ),
              TextField(

              )

            ],
          ),
        ),
      ),
    );
  }

}