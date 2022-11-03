import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vajra/models/user_selector/user_selector.dart';
import 'package:vajra/resource_helper/strings.dart';

class UserHierarchyListDropDown extends StatefulWidget {
  final List<UserSelector> listSelector;
  final Function selectedUserFromList;

  const UserHierarchyListDropDown({Key? key, required this.listSelector, required this.selectedUserFromList})
      : super(key: key);

  @override
  State<UserHierarchyListDropDown> createState() =>
      _UserHierarchyListDropDown();
}

class _UserHierarchyListDropDown extends State<UserHierarchyListDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.selectUser,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10,),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.listSelector.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return InkWell(
                      onTap: ()=>{
                       if(!widget.listSelector[index].isSelected){
                         widget.selectedUserFromList(widget.listSelector,index)
                       },
                        Navigator.pop(context),
                      },
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child:  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.listSelector[index].name!,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            flex: 2,
                                            child: Text(
                                              widget.listSelector[index].userId!,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10),
                                            )),
                                        Expanded(
                                            flex: 8,
                                            child: Container(
                                              child: Row(
                                                children: widget.listSelector[index].locations!
                                                    .map((e) => Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              '|  ',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 10,
                                                              ),
                                                            ),
                                                            Icon(
                                                              Icons.pin_drop,
                                                              color:
                                                                  Colors.grey,
                                                              size: 12,
                                                            ),
                                                            SizedBox(
                                                              width: 4,
                                                            ),
                                                            Text(
                                                              '${e.name!}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 10),
                                                            )
                                                          ],
                                                        ))
                                                    .toList(),
                                              ),
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
