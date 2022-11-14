import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vajra/db/database_helper.dart';
import 'package:vajra/db/form_actions_data_detail/form_action_data_details.dart';

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

  late InAppWebViewController _controller;


  InAppWebView webView = InAppWebView(
    initialUrlRequest: URLRequest(
      url: Uri.dataFromString(
          'about:blank',
          mimeType: 'text/html',
      )
    ),
  );


  @override
  void initState() {

    instance = DatabaseHelper.instance;

    AppUtils.getPrefs().then((value) => {
          setState(() {
            prefs = value;
          }),
          getLocation()
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (actionId == null || actionId == 0) {
      final arguments = (ModalRoute.of(context)?.settings.arguments ??
          <String, dynamic>{}) as Map;
      actionId = arguments['action_id'];

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
            : webView);
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
    var fileText = '';
    var form = await instance.execQuery(
        'SELECT * FROM ${instance.formActionsDataDetail} where ${FormActionsDataDetailsFields.id} = $actionId');
    for (var f in form) {
      name = '${f[FormActionsDataDetailsFields.name]}.html';
      fileText = '${f[FormActionsDataDetailsFields.formContent]}';
    }



    loadWebview(fileText);
  }

  void loadWebview(String fileText) async{
    // String fileText = '';
    // Directory directory = await getApplicationDocumentsDirectory();
    // String path = '${directory.path}/${AppUtils.webFiles}';
    // directory = Directory(path);
    // if (!await directory.exists()) {
    //   directory.create();
    // }
    //
    // final File file = File('${directory.path}/$name');
    // print(file.uri);
    // if (await file.exists()) {
    //   fileText = file.readAsStringSync();
    // }

    // print(fileText);

    // var manifestJson = await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    // var plugins = json.decode(manifestJson).keys.where((String key) => key.startsWith('assets/plugins'));
    //
    // var p = await getApplicationDocumentsDirectory();
    //
    //
    // for(var plugin in plugins){
    //   var val = await DefaultAssetBundle.of(context).load(plugin);
    //   File f = File('${p.path}/plugin/$plugin');
    //   if(await f.exists()){
    //     f.create();
    //   }
    //
    //   f.writeAsBytesSync(val.buffer.asUint8List(val.offsetInBytes, val.lengthInBytes));
    // }
    //
    // print(plugins);
    //
    //
    // fileText = fileText.replaceAll('file:///android_asset', '${p.path}');

    print(fileText);

    setState(() {
      webView = InAppWebView(
        initialData: InAppWebViewInitialData(
          data: fileText
        ),
        onWebViewCreated: (controller) =>
        _controller = controller..addJavaScriptHandler(
            handlerName: 'takePicture',
            callback: (data) {
              // Catch and handle js function
              for(var d in data){
                print(d);
              }
            },
          ),
      );

    });
  }
  Future<void> evalJs(dynamic param) async {
    await _controller.evaluateJavascript(
        source: "window.someFuncName( '$param ');");
  }




}
