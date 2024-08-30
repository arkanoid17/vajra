import 'package:flutter/material.dart';
import 'package:vajra_test/cores/themes/app_palette.dart';
import 'package:vajra_test/cores/model/user/locations.dart';

class PlacesDropdown extends StatelessWidget {
  final List<Locations> places;
  final Locations selectedLocation;
  final Function locationSelected;

  const PlacesDropdown(
      {super.key,
      required this.places,
      required this.selectedLocation,
      required this.locationSelected});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (value) => locationSelected(value),
      itemBuilder: (ctx) {
        return places
            .map((place) => PopupMenuItem(child: Text(place.name!)))
            .toList();
      },
      child: Container(
        padding: const EdgeInsets.all(8).copyWith(left: 15, right: 15),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            color: AppPalette.lightWhite),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              selectedLocation.name!,
              style:
                  const TextStyle(fontSize: 14, color: AppPalette.whiteColor),
            ),
            const Icon(
              Icons.keyboard_arrow_down,
              color: AppPalette.whiteColor,
            )
          ],
        ),
      ),
    );
  }
}
