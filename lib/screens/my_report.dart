import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vajra/dialogs/date_dropdown.dart';
import 'package:vajra/resource_helper/strings.dart';
import 'package:vajra/utils/app_utils.dart';

import '../resource_helper/color_constants.dart';
import '../services/APIServices.dart';

class MyReport extends StatefulWidget{
  const MyReport({Key? key}) : super(key: key);

  @override
  State<MyReport> createState() => _MyReport();

}


class _MyReport extends State<MyReport>{

  var reportDateText = AppStrings.today;
  var fromDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  var toDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  var path = '';

   SharedPreferences? prefs;

  Map<String, String> headers = {};
  PDFView? pdfView;
  
  @override
  void initState() {
    AppUtils.getPrefs().then((value) => {
        setState(() {
          prefs = value;
          headers = AppUtils.headers(
              value.getString('tenant_id') != null
                  ? value.getString('tenant_id')!
                  : '',
              value.getString('token') != null ? value.getString('token')! : '');
        }),
      getReport()

      });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.myReport),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(onPressed: (){
            shareFile();
          }, icon: Icon(Icons.share)),
          IconButton(onPressed: (){
            pdfView = null;
            getReport();
          }, icon: Icon(Icons.refresh)),
        ],
      ),
      body: prefs!=null?Container(
        margin: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => {
                AppUtils.showBottomDialog(
                    context,
                    true,
                    true,
                    Colors.white,
                    DateDropDown(
                      selected:
                      reportDateText,
                      prefs: prefs!,
                      onDateSelected:
                      onDateSelected,
                    ))
              },
              child: Container(
                decoration: const BoxDecoration(
                    color: ColorConstants
                        .color_ECE6F6_64,
                    borderRadius:
                    BorderRadius.all(
                        Radius.circular(
                            25))),
                child: Padding(
                  padding:
                  const EdgeInsets.only(
                      left: 15,
                      top: 10,
                      right: 15,
                      bottom: 10),
                  child: Row(
                    children: [
                      Image.asset(
                          'assets/images/ic_calendar_primary.png'),
                      const SizedBox(
                        width: 10,
                        height: 1,
                      ),
                      Flexible(
                          fit:
                          FlexFit.tight,
                          child: Text(
                            '$reportDateText',
                            style: TextStyle(
                                color: ColorConstants
                                    .colorPrimary,
                                fontSize:
                                14,
                                fontWeight:
                                FontWeight
                                    .w500),
                          )),
                      const Icon(
                        Icons
                            .arrow_drop_down,
                        color: ColorConstants
                            .colorPrimary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 15,),
            Expanded(
                child:pdfView!=null?pdfView!:Center(child: CircularProgressIndicator(),)
            )
          ],
        ),
      ):Container(),
    );
  }


  void onDateSelected(String item, String fromDate, String toDate) {
    setState(() {
      reportDateText = item;
      this.fromDate = fromDate;
      this.toDate = toDate;
      pdfView = null;
    });
    getReport();
  }

  getReport() async{
    String url = '${AppUtils.baseUrl}${APIServices.getMyReportService(fromDate, toDate)}';
    var report = await AppUtils.requestBuilder(url, headers);
    try{
      if (report.statusCode == 200) {
        handleReport(report.bodyBytes);
      }
    }catch(e){
      AppUtils.showMessage('report error ${e.toString()}');
    }
  }

  void handleReport(Uint8List body) async{
    String dirPath = await getReportPath();
    final File file = File('$dirPath/report.pdf');
    file.writeAsBytesSync(body);
    setState(() {
      path = file.path;
      pdfView =  PDFView(
        filePath: file.path,
        onError: (e){
          print('error - ${e.toString()}');
        },
      );
    });
  }

  getReportPath() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/${AppUtils.report}';
    directory = Directory(path);
    if(!await directory.exists()){
      directory.create();
    }
    return directory.path;

  }

  void shareFile() async{
    final box = context.findRenderObject() as RenderBox?;
    File file = File(path);
    final data = file.readAsBytesSync();
    final buffer = data.buffer;
    final shareResult = await Share.shareXFiles(
      [
        XFile.fromData(
          buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
          name: 'Report',
          mimeType: 'application/pdf',
        ),
      ],
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }


}