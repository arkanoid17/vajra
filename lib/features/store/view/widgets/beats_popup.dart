import 'package:flutter/material.dart';
import 'package:vajra_test/cores/constants/app_dimens.dart';
import 'package:vajra_test/cores/constants/app_strings.dart';
import 'package:vajra_test/cores/themes/app_palette.dart';
import 'package:vajra_test/cores/themes/app_theme.dart';
import 'package:vajra_test/features/sync/model/models/userhierarchy/user_hierarchy_beats.dart';

class BeatsPopup extends StatefulWidget {
  final int salesmanId;
  final String selectedDate;
  final List<UserHierarchyBeats> selectedBeats;
  final List<UserHierarchyBeats> allBeats;

  const BeatsPopup(
      {super.key,
      required this.salesmanId,
      required this.selectedBeats,
      required this.selectedDate,
      required this.allBeats});

  @override
  State<BeatsPopup> createState() => _BeatsPopupState();
}

class _BeatsPopupState extends State<BeatsPopup> {
  late List<UserHierarchyBeats> allBeats;
  late List<UserHierarchyBeats> selectedBeats;

  @override
  void initState() {
    allBeats = widget.allBeats;
    selectedBeats = widget.selectedBeats;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 1.0,
      builder: (ctx, scrollController) {
        return Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(AppDimens.screenPadding),
              child: Text(
                AppStrings.selectBeats,
                style: AppTheme.titleText,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: allBeats.length,
                itemBuilder: (context, index) => CheckboxListTile(
                  title: Text(
                    allBeats[index].name ?? '',
                    style: AppTheme.textTheme(
                        AppPalette.blackColor, 13.0, FontWeight.w400),
                  ),
                  value: selectedBeats
                      .where((e) => (e.id!) == allBeats[index].id!)
                      .toList()
                      .isNotEmpty,
                  onChanged: (val) => handleChange(val, index),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void handleChange(bool? val, int index) {
    if (val != null && val) {
      selectedBeats.add(allBeats[index]);
    } else {
      selectedBeats =
          selectedBeats.where((e) => e.id! != allBeats[index].id!).toList();
      setState(() {});
    }
  }
}
