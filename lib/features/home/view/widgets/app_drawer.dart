import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vajra_test/cores/constants/app_dimens.dart';
import 'package:vajra_test/cores/constants/app_strings.dart';
import 'package:vajra_test/cores/themes/app_palette.dart';
import 'package:vajra_test/cores/themes/app_theme.dart';
import 'package:vajra_test/cores/utils/app_utils.dart';

class AppDrawer extends StatefulWidget {
  final String name;
  final String empId;
  const AppDrawer({super.key, required this.name, required this.empId});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(color: AppPalette.primaryColor),
            width: double.infinity,
            height: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: AppPalette.whiteColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.name.characters.first,
                      style: const TextStyle(
                          color: AppPalette.primaryColor,
                          fontSize: 50,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.name,
                  style: const TextStyle(
                    color: AppPalette.whiteColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.empId,
                  style: const TextStyle(
                    color: AppPalette.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  horizontalTitleGap: AppDimens.screenPadding,
                  visualDensity: VisualDensity.compact,
                  leading: SvgPicture.asset(
                      'assets/images/ic_menu_pending_activities.svg'),
                  title: const Text(
                    AppStrings.pendingActivities,
                    style: AppTheme.smallText,
                  ),
                ),
                ListTile(
                  horizontalTitleGap: AppDimens.screenPadding,
                  visualDensity: VisualDensity.compact,
                  leading: SvgPicture.asset(
                      'assets/images/ic_menu_pending_activities.svg'),
                  title: const Text(
                    AppStrings.orderHistory,
                    style: AppTheme.smallText,
                  ),
                ),
                ListTile(
                  horizontalTitleGap: AppDimens.screenPadding,
                  visualDensity: VisualDensity.compact,
                  leading: SvgPicture.asset(
                      'assets/images/ic_menu_pending_activities.svg'),
                  title: const Text(
                    AppStrings.myReport,
                    style: AppTheme.smallText,
                  ),
                ),
                ListTile(
                  horizontalTitleGap: AppDimens.screenPadding,
                  visualDensity: VisualDensity.compact,
                  leading: SvgPicture.asset(
                      'assets/images/ic_menu_pending_activities.svg'),
                  title: const Text(
                    AppStrings.pendingActivities,
                    style: AppTheme.smallText,
                  ),
                ),
                ListTile(
                  horizontalTitleGap: AppDimens.screenPadding,
                  visualDensity: VisualDensity.compact,
                  leading: SvgPicture.asset(
                      'assets/images/ic_menu_pending_activities.svg'),
                  title: const Text(
                    AppStrings.onboardStore,
                    style: AppTheme.smallText,
                  ),
                ),
                ListTile(
                  horizontalTitleGap: AppDimens.screenPadding,
                  visualDensity: VisualDensity.compact,
                  leading: SvgPicture.asset(
                      'assets/images/ic_menu_pending_activities.svg'),
                  title: const Text(
                    AppStrings.actions,
                    style: AppTheme.smallText,
                  ),
                ),
                ListTile(
                  horizontalTitleGap: AppDimens.screenPadding,
                  visualDensity: VisualDensity.compact,
                  leading: SvgPicture.asset(
                      'assets/images/ic_menu_pending_activities.svg'),
                  title: const Text(
                    AppStrings.reports,
                    style: AppTheme.smallText,
                  ),
                ),
                ListTile(
                  horizontalTitleGap: AppDimens.screenPadding,
                  visualDensity: VisualDensity.compact,
                  leading: SvgPicture.asset(
                      'assets/images/ic_menu_pending_activities.svg'),
                  title: const Text(
                    AppStrings.shareBackUp,
                    style: AppTheme.smallText,
                  ),
                ),
                ListTile(
                  horizontalTitleGap: AppDimens.screenPadding,
                  visualDensity: VisualDensity.compact,
                  leading: SvgPicture.asset(
                      'assets/images/ic_menu_pending_activities.svg'),
                  title: const Text(
                    AppStrings.syncData,
                    style: AppTheme.smallText,
                  ),
                ),
                ListTile(
                  horizontalTitleGap: AppDimens.screenPadding,
                  visualDensity: VisualDensity.compact,
                  leading: SvgPicture.asset(
                      'assets/images/ic_menu_pending_activities.svg'),
                  title: const Text(
                    AppStrings.referrals,
                    style: AppTheme.smallText,
                  ),
                ),
                ListTile(
                  horizontalTitleGap: AppDimens.screenPadding,
                  visualDensity: VisualDensity.compact,
                  leading: SvgPicture.asset(
                      'assets/images/ic_menu_pending_activities.svg'),
                  title: const Text(
                    AppStrings.appInfo,
                    style: AppTheme.smallText,
                  ),
                ),
                ListTile(
                  onTap: () => logout(context),
                  horizontalTitleGap: AppDimens.screenPadding,
                  visualDensity: VisualDensity.compact,
                  leading: SvgPicture.asset(
                      'assets/images/ic_menu_pending_activities.svg'),
                  title: const Text(
                    AppStrings.logout,
                    style: AppTheme.smallText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
