import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vajra/models/country_code/country_code.dart';
import 'package:vajra/resource_helper/color_constants.dart';
import 'package:vajra/resource_helper/dimensionns.dart';
import 'package:vajra/resource_helper/strings.dart';
import 'package:vajra/utils/app_utils.dart';

class CountryCodeDialog extends StatefulWidget{


  final List<CountryCode> countryList;
  final TextEditingController codeController;

  const CountryCodeDialog ({ Key? key, required this.countryList, required this.codeController }): super(key: key);

  @override
  State<CountryCodeDialog> createState() => _CountryCodeDialog();

}


class _CountryCodeDialog extends State<CountryCodeDialog>{

  List<CountryCode> countryList = [];
  List<CountryCode> filterList = [];

  String searchText = "";
  bool _isCountryCodeFetched = false;

  TextEditingController searchController = TextEditingController();



  @override
  Widget build(BuildContext context) {



    if(countryList.isEmpty){
      countryList.clear();
      filterList.clear();

      DefaultAssetBundle.of(context)
          .loadString("assets/json/country.json")
          .then((value) => {
        countryList = (json.decode(value) as List)
            .map((i) => CountryCode.fromJson(i))
            .toList(),
        filterList.addAll(countryList),

        setState((){
          _isCountryCodeFetched = true;
        })
      });

    }


    return  _isCountryCodeFetched?SizedBox(
      height: 800,
      child: Padding(padding: const EdgeInsets.all(16),child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:  [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppStrings.selectCountryCode,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () => {
                  // searchController.text = "",
                  Navigator.pop(context),
                  // setState(() {
                  //   searchString = '';
                  // })
                },
                child: const Icon(Icons.close),
              )
            ],
          ),

          const SizedBox(height: 25),
          TextField(
            controller: searchController,
            onChanged: (value) => {
              setState((){
                searchText = value;
                filterList.clear();
                if(value == ""){
                  filterList.addAll(countryList);
                }else{
                  filterList.addAll(countryList.where((element) => element.name.toLowerCase().contains(value.toLowerCase())).toList());
                }

                print ("size");
                print(filterList.length);
              })
            },
            decoration: InputDecoration(
                isDense: true,
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                labelText: AppStrings.search,
                hintText: AppStrings.search),
          ),

          const SizedBox(height: 25),

          Expanded(
              child: Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: filterList.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return Container(
                        key: UniqueKey(),
                        child: InkWell(
                          onTap: () => {
                            Navigator.pop(context),
                            // setState(() {
                            //   codeController.text =
                            //       countryList[index].dialCode;
                            //   searchController.text = '';
                            // })

                            setState(() {
                              widget.codeController.text = filterList[index].dialCode;
                            })
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                    child: Text('${filterList[index].name} (${filterList[index].code})')),
                                Text(filterList[index].dialCode)
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )))

        ],
      )),
    ):const SizedBox(
      height: 200,
      child:  Center(
        child: CircularProgressIndicator(
          color: ColorConstants.colorPrimary,
        ),
      ),
    );

  }

}