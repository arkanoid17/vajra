import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vajra/models/country_code/country_code.dart';
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

  @override
  Widget build(BuildContext context) {

    countryList.addAll(widget.countryList);

    return 
      SizedBox(
        height: 800,
        child: Padding(padding: EdgeInsets.all(16),child: Column(
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

            Expanded(
                child: Container(
                    child: ListView.builder(
                      itemCount: countryList.length,
                      itemBuilder: (BuildContext ctx, int index) {
                        return Container(
                          child: InkWell(
                            onTap: () => {
                              Navigator.pop(context),
                              // setState(() {
                              //   codeController.text =
                              //       countryList[index].dialCode;
                              //   searchController.text = '';
                              // })

                              setState(() {
                                widget.codeController.text = countryList[index].dialCode;
                              })
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                      child: Text('${countryList[index].name} (${countryList[index].code})')),
                                  Text(countryList[index].dialCode)
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )))

          ],
        )),
      );
  }

}