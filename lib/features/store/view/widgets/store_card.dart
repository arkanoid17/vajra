import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vajra_test/cores/constants/app_dimens.dart';
import 'package:vajra_test/cores/constants/app_strings.dart';
import 'package:vajra_test/cores/themes/app_palette.dart';
import 'package:vajra_test/cores/themes/app_theme.dart';
import 'package:vajra_test/cores/utils/app_utils.dart';
import 'package:vajra_test/features/store/model/models/store.dart';

class StoreCard extends StatelessWidget {
  final Store store;

  const StoreCard({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.cardBoxDecoration,
      margin: const EdgeInsets.only(
        left: AppDimens.screenPadding,
        right: AppDimens.screenPadding,
        bottom: 8.0,
      ),
      padding: const EdgeInsets.all(8.0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                flex: 1,
                child: Text(
                  '${AppStrings.storeName}:',
                  style: AppTheme.indicatorText,
                ),
              ),
              const SizedBox(
                width: 5.0,
              ),
              Expanded(
                flex: 3,
                child: Text(
                  store.name ?? '',
                  style: AppTheme.valueTextText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 5.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                flex: 1,
                child: Text(
                  '${AppStrings.distance}:',
                  style: AppTheme.indicatorText,
                ),
              ),
              const SizedBox(
                width: 5.0,
              ),
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Text(
                      '${_getCalculatedDiIstance(store)}',
                      style: AppTheme.valueTextText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      '| ${AppStrings.notVisited}',
                      style: AppTheme.textTheme(
                          AppPalette.notVisitedColor, 14.0, FontWeight.w500),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5.0,
          ),
          Row(
            children: [
              IconButton(
                style: IconButton.styleFrom(
                    backgroundColor: AppPalette.buttonBackgroundLightPrimary),
                onPressed: () {},
                icon: const Icon(
                  Icons.call_outlined,
                  color: AppPalette.primaryColor,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppPalette.buttonBackgroundLightPrimary,
                  ),
                  child: Text(
                    AppStrings.noOrder,
                    style: AppTheme.textTheme(
                      AppPalette.primaryColor,
                      14.0,
                      FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppPalette.buttonBackgroundLightPrimary,
                  ),
                  child: Text(
                    AppStrings.bookOrder,
                    style: AppTheme.textTheme(
                      AppPalette.primaryColor,
                      14.0,
                      FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _getCalculatedDiIstance(Store store) {
    var distance = store.distance!;

    if (distance > 1000) {
      distance = distance / 1000;
      String formattedNumber = distance.toStringAsFixed(2);
      return '$formattedNumber km';
    } else {
      return '${distance.toInt()} m';
    }
  }
}
