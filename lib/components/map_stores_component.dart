import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vajra/db/stores_data_detail/stores_data_detail.dart';
import 'package:vajra/dialogs/store_options.dailog.dart';
import 'package:vajra/utils/app_utils.dart';

class MapStoresComponent extends StatefulWidget {
  final Position location;
  final List<StoresDataDetail> stores;

  const MapStoresComponent(
      {Key? key, required this.location, required this.stores})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MapStoresComponent();
}

class _MapStoresComponent extends State<MapStoresComponent> {
  late GoogleMapController mapController;

  double lat = 0.0;
  double long = 0.0;

  late LatLng _center;

  List<Marker> markers = [];

  @override
  void initState() {
    lat = widget.location.latitude;
    long = widget.location.longitude;
    _center = LatLng(lat, long);

    for (StoresDataDetail store in widget.stores) {
      markers.add(Marker(
          markerId: MarkerId(store.storeId!),
          position: LatLng(double.parse(store.storeLatitude!),
              double.parse(store.storeLongitude!)),
          infoWindow: InfoWindow(title: store.name,onTap: (){
            AppUtils.showBottomDialog(context, true, false, Colors.white, StoreOptionsDialog(store:store));
          })));
    }

    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
        child: GoogleMap(
            myLocationEnabled: true,
            onMapCreated: _onMapCreated,
            markers: Set<Marker>.of(markers),
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            )));
  }
}
