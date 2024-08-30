import 'package:flutter/material.dart';
import 'package:vajra_test/cores/constants/app_strings.dart';
import 'package:vajra_test/cores/themes/app_palette.dart';
import 'package:vajra_test/cores/themes/app_theme.dart';

class HomeCards extends StatelessWidget {
  final String header;
  final String todayValue;
  final String monthValue;
  final String syncPendingValue;

  const HomeCards(
      {super.key,
      required this.header,
      required this.todayValue,
      required this.monthValue,
      required this.syncPendingValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: 200,
      height: 240,
      decoration: AppTheme.homeCardsBorder,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            header,
            style: AppTheme.textTheme(
              AppPalette.whiteColor,
              16.0,
              FontWeight.w400,
            ),
          ),
          Center(
            child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                direction: Axis.vertical,
                children: [
                  Text(
                    todayValue,
                    style: AppTheme.textTheme(
                      AppPalette.whiteColor,
                      30.0,
                      FontWeight.bold,
                    ),
                  ),
                  Text(
                    AppStrings.today,
                    style: AppTheme.textTheme(
                      AppPalette.whiteColor,
                      22.0,
                      FontWeight.bold,
                    ),
                  ),
                ]),
          ),
          Row(
            children: [
              Expanded(
                child: Center(
                  child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.center,
                      direction: Axis.vertical,
                      children: [
                        Text(
                          monthValue,
                          style: AppTheme.textTheme(
                            AppPalette.whiteColor,
                            20.0,
                            FontWeight.w500,
                          ),
                        ),
                        Text(
                          AppStrings.inMonth,
                          style: AppTheme.textTheme(
                            AppPalette.whiteColor,
                            15.0,
                            FontWeight.w500,
                          ),
                        ),
                      ]),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Center(
                  child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.center,
                      direction: Axis.vertical,
                      children: [
                        Text(
                          syncPendingValue,
                          style: AppTheme.textTheme(
                            AppPalette.whiteColor,
                            20.0,
                            FontWeight.w500,
                          ),
                        ),
                        Text(
                          AppStrings.pendingForSync,
                          style: AppTheme.textTheme(
                            AppPalette.whiteColor,
                            15.0,
                            FontWeight.w500,
                          ),
                        ),
                      ]),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
