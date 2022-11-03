import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vajra/models/bottom_selection_data_model/bottom_selection_data_model.dart';
import 'package:vajra/resource_helper/color_constants.dart';
import 'package:vajra/resource_helper/strings.dart';

class BottomDialogSelectionComponent extends StatefulWidget{

  final List<BottomSelectionDataModel> idNameMap;
  final List<int> selectedIds;
  final Function setSelected;

  const BottomDialogSelectionComponent ({ Key? key, required this.idNameMap, required this.selectedIds, required this.setSelected }): super(key: key);

  @override
  State<BottomDialogSelectionComponent> createState() => _BottomDialogSelectionComponent();
}

class _BottomDialogSelectionComponent extends State<BottomDialogSelectionComponent>{

  late List<BottomSelectionDataModel> idNameMap;
  late List<int> selectedIds;

  @override
  void initState() {
    // TODO: implement initState
    idNameMap = widget.idNameMap;
    selectedIds = widget.selectedIds;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(height: 10,),
              Text(AppStrings.select,style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w700),),
              SizedBox(height: 10,),
              Expanded(child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: idNameMap.length,
                  itemBuilder: (BuildContext context, int index){
                    return Wrap(
                      direction: Axis.horizontal,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Checkbox(
                          value:selectedIds.contains(idNameMap[index].id) ,
                          onChanged: (val){
                            List<int> selected = selectedIds;
                            val!?selected.add(idNameMap[index].id!):selected.remove(idNameMap[index].id!);
                            setState(() {
                              selectedIds = selected;
                            });

                          },
                        ),
                        Text(idNameMap[index].name!)
                      ],
                    );
                  }
              )),
              SizedBox(height: 10,),
              ElevatedButton(
                  onPressed: (){
                    widget.setSelected(selectedIds);
                    Navigator.pop(context);
                  },
                  child: Text(AppStrings.select),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<
                          RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(18.0),
                        ),
                      ),
                padding: MaterialStateProperty.all(
                    EdgeInsets.only(left: 50,right: 50,top: 5,bottom: 5)),
                backgroundColor: MaterialStateProperty
                    .all(ColorConstants
                    .colorPrimary),
                // <-- Button color
              ))
            ],
          ),
        )
    );
  }


}