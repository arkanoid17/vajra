import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vajra/db/database_helper.dart';
import 'package:vajra/db/form_actions_data_detail/form_action_data_details.dart';
import 'package:vajra/db/store_types_data_detail/store_types_data_detail.dart';
import 'package:vajra/db/user_hierarchy_data_detail/user_hierarchy_data_detail.dart';
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

  String visitId = '';

  @override
  void initState() {
    instance = DatabaseHelper.instance;

    if (Platform.isAndroid) WebView.platform = AndroidWebView();

    setState(() {});

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
            : webView != null
                ? webView
                : Container());
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

    setState(() {
      webView = WebView(
        debuggingEnabled: true,
        initialUrl: Uri.dataFromString(fileText,
                mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
            .toString(),
        javascriptMode: JavascriptMode.unrestricted,
        javascriptChannels: {
          JavascriptChannel(
            name: 'AndroidInterface',
            onMessageReceived: (data) {
              var value = jsonDecode(data.message);
              switch (value['name']) {
                case 'getStoreOutletTypes':
                  getStoreOutletTypes();
                  break;
                case 'getChannels':
                  getChannels();
                  break;
                case 'getUserToken':
                  getUserToken();
                  break;
                case 'getTenantId':
                  getTenantId();
                  break;
                case 'getUserData':
                  getUserData();
                  break;
                case 'getVisitId':
                  getVisitId();
                  break;
                case 'getDistributors':
                  getDistributors();
                  break;
                case 'getBeatCategories':
                  getBeatCategories();
                  break;
                case 'getBeats':
                  getBeats();
                  break;
                case 'canAddBeatMapping':
                  canAddBeatMapping();
                  break;
                case 'takePicture':
                  takePicture(data.message);
                  break;
                case 'showToast':
                  AppUtils.showMessage(value['data'].toString());
                  break;
              }
            },
          ),
        },
        onWebViewCreated: (controller) {
          setState(() {
            _controller = controller;
          });
        },
        onPageStarted: (string) {},
        onProgress: (val) {},
        onPageFinished: (string) {},
      );
    });
  }

  void loadForm() {
    setState(() {});
  }

  void getStoreOutletTypes() async {
    var outletTypesRaw = await instance
        .execQuery('SELECT * FROM ${instance.storeTypesDataDetail}');
    var arr = [];
    for (var outletTypes in outletTypesRaw) {
      var value = getObj(
          outletTypes[StoreTypesDataDetailFields.id],
          outletTypes[StoreTypesDataDetailFields.name],
          'outlet type',
          outletTypes[StoreTypesDataDetailFields.name],
          true);
      arr.add(value);
    }
    var data = arr.toString();
    _controller?.runJavascript("getStoreOutletTypes('$data')");
  }

  void getChannels() async {
    var channelsRaw =
        await instance.execQuery('SELECT * FROM ${instance.channelDataDetail}');
    var arr = [];
    for (var channel in channelsRaw) {
      var value = getObj(
          channel[StoreTypesDataDetailFields.id],
          channel[StoreTypesDataDetailFields.name],
          'user_channels',
          channel[StoreTypesDataDetailFields.name],
          true);
      arr.add(value);
    }
    var data = arr.toString();
    _controller?.runJavascript("getChannels('$data')");
  }



  void showToast(String message) {
    AppUtils.showMessage(message);
  }

  void getUserToken() {
    var token = prefs.getString('token');
    _controller?.runJavascript("getUserToken('${token ?? ''}')");
  }

  void getTenantId() {
    var tenantId = prefs.getString('tenant_id');
    tenantId ?? '';
    _controller?.runJavascript("getTenantId('${tenantId ?? ''}')");
  }

  void getUserData() {
    var data = '';
    var userData = AppUtils.getUserData(prefs);
    if (userData != null) {
      data = jsonEncode(userData);
    }

    _controller?.runJavascript("getUserData('')");
  }

  void getVisitId() {
    var data = '';
    var userData = AppUtils.getUserData(prefs);
    if (userData != null) {
      var tmpId = '';
      if (userData.employId!.length > 3) {
        tmpId = userData.employId!.substring(userData.employId!.length - 3);
      } else {
        tmpId = userData.employId!;
      }
      data = 'OT$tmpId${DateTime.now().millisecondsSinceEpoch}';
    }

    setState(() {
      visitId = data;
    });
    _controller?.runJavascript("getVisitId('$data')");
  }

  void getDistributors() async {
    var arr = [];
    var hierarchy = await AppUtils.getUserFromHierarchy(instance, prefs);
    if (hierarchy != null) {
      var dists = hierarchy[UserHierarchyDataDetailFields.salesmanDistributors];
      List<dynamic> parsedListJson = jsonDecode(dists);
      for (var json in parsedListJson) {
        var value = getObj(
            json['id'], json['name'], 'distributors', json['name'], true);
        arr.add(value);
      }
    }
    var data = arr.toString();
    _controller?.runJavascript("getDistributors('$data')");
  }

  void getBeatCategories() async {
    var arr = [];
    var hierarchy = await AppUtils.getUserFromHierarchy(instance, prefs);
    if (hierarchy != null) {
      var beats = hierarchy[UserHierarchyDataDetailFields.beats];
      List<dynamic> parsedListJson = jsonDecode(beats);
      var types = [];
      for (var json in parsedListJson) {
       if(!types.contains(json['type'])){
         types.add(json['type']);
       }
      }
      int id = 0;
      for(var type in types){
        var value = getObj(
            ++id, type, 'beat categories', type, true);
        arr.add(value);
      }
    }
    var data = arr.toString();
    _controller?.runJavascript("getBeatCategories('$data')");
  }

  void getBeats() async {
    var arr = [];
    var hierarchy = await AppUtils.getUserFromHierarchy(instance, prefs);
    if (hierarchy != null){
      var beats = hierarchy[UserHierarchyDataDetailFields.beats];
      List<dynamic> parsedListJson = jsonDecode(beats);
      for (var json in parsedListJson){
        var value = getBeatObj(
            json['id'], json['name'], 'beats', json['name'], true,'',json['type']);
        arr.add(value);
      }
    }
    var data = arr.toString();
    _controller?.runJavascript("getBeats('$data')");
  }

  void canAddBeatMapping() {
    var canAddBeatMapping = AppUtils.checkPermission(prefs, 'add_outletbeatmapping');
    var data = canAddBeatMapping.toString();
    _controller?.runJavascript("canAddBeatMapping('$data')");
  }


  getObj(int id, String vvalue, String groupName, String label, bool status,) {
    var obj = {
      'id': id,
      'vvalue': vvalue,
      'groupName': groupName,
      'label': label,
      'status': status,
    };
    return jsonEncode(obj);
  }

  getBeatObj(int id, String vvalue, String groupName, String label, bool status,String description,String beat_category) {
    var obj = {
      'id': id,
      'vvalue': vvalue,
      'groupName': groupName,
      'label': label,
      'status': status,
      'description': description,
      'beat_category': beat_category,
    };
    return jsonEncode(obj);
  }

  void takePicture(String message) async{

    var data = jsonDecode(message);
    var ext = data['data']['extension'];
    var callback = data['data']['callback'];
    print('callback - $callback');

    var isPermissionGranted = await AppUtils.permissionChecker([Permission.camera,Permission.microphone]);
    if(isPermissionGranted){

      var path = await AppUtils.getImagePath('$visitId-$ext');

      Navigator.pushNamed(context, '/camera', arguments: {
        'visitId':visitId,
        'path': path,
        'screen': 'StoreOnboarding',
        'callback': imageCallback,
        'callback_name':callback
      });
    }else{
      AppUtils.showMessage( "Please grant all permissions");
    }
  }

  void imageCallback(String callback,String name,String path){
    print("$callback('$name','$path')");
    _controller?.runJavascript("$callback('$name','$path')");
  }

}
