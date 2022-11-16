import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vajra/db/database_helper.dart';
import 'package:vajra/db/form_actions_data_detail/form_action_data_details.dart';
import 'package:vajra/db/store_types_data_detail/store_types_data_detail.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../resource_helper/color_constants.dart';
import '../resource_helper/strings.dart';
import '../utils/app_utils.dart';

class DynamicActionsPage extends StatefulWidget {
  final Object? arguments;

  const DynamicActionsPage(this.arguments, {Key? key}) : super(key: key);

  @override
  State<DynamicActionsPage> createState() => _DynamicActionsPage();
}

class _DynamicActionsPage extends State<DynamicActionsPage> {
  int? actionId;

  late Position location;
  late SharedPreferences prefs;
  StreamSubscription<Position>? positionStream;
  bool isFetchingLocation = true;

  late DatabaseHelper instance;

   WebViewController? _controller;

   WebView? webView;

  String formText = '';

  @override
  void initState() {
    instance = DatabaseHelper.instance;

    if (Platform.isAndroid) WebView.platform = AndroidWebView();

    setState(() {

    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (actionId == null || actionId == 0) {
      final arguments = (ModalRoute.of(context)?.settings.arguments ??
          <String, dynamic>{}) as Map;
      actionId = arguments['action_id'];
      AppUtils.getPrefs().then((value) => {
        setState(() {
          prefs = value;
        }),
        getLocation(),
      });
      fetchForm();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.actions),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: isFetchingLocation
            ? Center(
            child: Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: const [
                Text(
                  AppStrings.pleaseWaitWhileWeFetchLocation,
                  style: TextStyle(
                      color: ColorConstants.colorPrimary, fontSize: 14),
                ),
                CircularProgressIndicator()
              ],
            ))
            : webView!=null?webView:Container());
  }

  void getLocation() async {
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: AppUtils.getDistanceLocationUpdate(prefs),
      timeLimit: Duration(seconds: AppUtils.getTimeLocationUpdate(prefs)),
    );
    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
          if (position != null) {
            setState(() {
              isFetchingLocation = false;
              location = position;
            });
            if (positionStream != null) {
              positionStream!.cancel();
            }
          }
        });
  }

  void fetchForm() async {
    var name = '';
    // var fileText = '';
    var form = await instance.execQuery(
        'SELECT * FROM ${instance.formActionsDataDetail} where ${FormActionsDataDetailsFields.id} = $actionId');
    for (var f in form) {
      name = '${f[FormActionsDataDetailsFields.name]}.html';
      // fileText = '${f[FormActionsDataDetailsFields.formContent]}';
    }

    loadWebView(name);
  }

  void loadWebView(String name) async {
    String fileText = '';
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/${AppUtils.webFiles}';
    directory = Directory(path);
    if (!await directory.exists()) {
      directory.create();
    }

    final File file = File('${directory.path}/$name');
    if (await file.exists()) {
      fileText = file.readAsStringSync();
    }

    fileText = """
   <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>On Boarding</title>
    </head>

    <body>
        <div id="div1"></div>
        <button onclick="buttonClick()" type="button">Show Message</button>
    </body>

    <script>
    function buttonClick() {
        Print.postMessage("Test");
    }
    function showText(message){
      document.getElementById('div1').innerHTML = message;
    }
    </script>
    </html>
    """;

    setState(() {
      webView = WebView(
        debuggingEnabled: true,
        initialUrl: Uri.dataFromString(
          fileText,
          mimeType: 'text/html',
            encoding: Encoding.getByName('utf-8')
        ).toString(),
        javascriptMode: JavascriptMode.unrestricted,
        javascriptChannels: {
          JavascriptChannel(
            name: 'Print',
            onMessageReceived: (data){
              // print(data.message);
              AppUtils.showMessage(data.message);
            },
          ),
        },
        onWebViewCreated: (controller) {
          setState(() {
            _controller = controller;
          });
        },
        onPageStarted: (string){
          print('page started - $string');
        },
        onProgress: (val){
          print('page progress - $val');
        },
        onPageFinished: (string) {
          print('page finished - $string');
          _controller?.runJavascriptReturningResult("showText('Muthu')");
          // if(formText.isNotEmpty){
          //   print('this');
          //   _controller.runJavascriptReturningResult("showText('test')");
          // }
        },

      );
    });
  }

  void loadForm() {
    setState(() {


    });
  }


}

