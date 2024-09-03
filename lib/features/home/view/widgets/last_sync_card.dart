import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vajra_test/cores/constants/app_strings.dart';
import 'package:vajra_test/cores/themes/app_palette.dart';
import 'package:vajra_test/cores/themes/app_theme.dart';

class LastSyncCard extends StatelessWidget {
  final String status;
  final String time;

  const LastSyncCard({super.key, required this.status, required this.time});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 16, right: 16),
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: status == AppStrings.online
              ? const LinearGradient(
                  colors: [
                    AppPalette.primaryColor,
                    AppPalette.welcomeTextColor
                  ],
                )
              : const LinearGradient(
                  colors: [
                    AppPalette.offlineGradient1,
                    AppPalette.offlineGradient2,
                  ],
                ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              status == AppStrings.offline
                  ? 'assets/images/offline.svg'
                  : 'assets/images/online.svg',
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status,
                  style: AppTheme.textTheme(
                    AppPalette.onlineTextColor,
                    14.0,
                    FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                  maxLines: 2,
                  text: TextSpan(
                    text: '${AppStrings.lastSyncTime}:  ',
                    style: AppTheme.textTheme(
                      AppPalette.whiteColor,
                      16.0,
                      FontWeight.w400,
                    ),
                    children: [
                      TextSpan(
                        text: time,
                        style: AppTheme.textTheme(
                          AppPalette.whiteColor,
                          16.0,
                          FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
